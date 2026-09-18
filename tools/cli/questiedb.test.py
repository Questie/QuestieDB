"""Focused portable runner tests. Run with uv run tools/cli/questiedb.test.py.

All writes and child programs belong to disposable fixtures, never generated databases.
"""
import contextlib
import importlib.util
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import patch, Mock

ROOT = Path(__file__).resolve().parents[2]
FIXTURES = Path(__file__).with_name("fixtures")
SPEC = importlib.util.spec_from_file_location("questiedb_cli", ROOT / "tools/cli/questiedb.py")
cli = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = cli
SPEC.loader.exec_module(cli)


class ParsingTest(unittest.TestCase):
    def test_bundles_deduplicate_without_changing_order(self):
        options = cli.parse_args(["check", "verify", "Vanilla", "Vanilla", "TBC", "--budget-mb=02000"])
        self.assertEqual(list(cli.CHECKS), options.tasks)
        self.assertEqual(["Vanilla", "TBC"], options.flavors)
        self.assertEqual(2000, options.budget)
        self.assertEqual(["generate", *cli.CHECKS, "golden", "test"], cli.parse_args(["all"]).tasks)

    def test_invalid_selections_fail_before_tool_discovery(self):
        cases = [([], "no task"), (["Vanilla"], "no task"),
                 (["all", "verify"], "cannot be combined"),
                 (["generate", "--budget-mb=0"], "positive decimal"),
                 (["generate", "--budget-mb=18446744073709551617"], "must not exceed"),
                 (["generate", "--budget-mb=no"], "positive decimal"),
                 (["generate", "Vanilla", "--flavors=TBC"], "cannot be combined"),
                 (["generate", "--flavors=Vanilla,"], "empty values"),
                 (["freeze", "TBC"], "only Vanilla and Mists"),
                 (["generate", "--flavors=Vanilla", "--flavors=TBC"], "only once"),
                 (["unknown"], "unknown")]
        for args, message in cases:
            with self.subTest(args=args), self.assertRaisesRegex(ValueError, message):
                cli.parse_args(args)


class SchedulerTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb scheduler ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / ".out/checks").mkdir(parents=True)

    def test_priority_memory_fit_and_failure_results(self):
        launched = []

        class Process:
            def __init__(self, command, **kwargs):
                launched.append(command[0])
                self.remaining = 5 if command[0] == "test" else 1
                self.code = 7 if command[0] == "small" else 0
                kwargs["stdout"].write(b"[PASS] fixture\n")

            def poll(self):
                self.remaining -= 1
                return self.code if self.remaining <= 0 else None

            def wait(self, timeout=None):
                return self.code

        jobs = [cli.Job("big", ["big"], 1750), cli.Job("small", ["small"], 450),
                cli.Job("test", ["test"], 650, priority=100)]
        with patch.object(cli.subprocess, "Popen", Process), patch.object(cli.time, "sleep"), \
                contextlib.redirect_stdout(io.StringIO()) as output:
            passed = cli.run_jobs(jobs, "checks", self.root, {}, 2000, False)
        self.assertFalse(passed)
        self.assertEqual(["test", "small", "big"], launched)
        self.assertIn("1 of 3 failed", output.getvalue())

    def test_sequential_mode_allows_an_oversized_job_alone(self):
        jobs = [cli.Job("first", [sys.executable, "-c", "print('first')"], 3000),
                cli.Job("second", [sys.executable, "-c", "print('second')"], 450)]
        with contextlib.redirect_stdout(io.StringIO()) as output:
            passed = cli.run_jobs(jobs, "checks", self.root, dict(os.environ), 2000, True)
        self.assertTrue(passed)
        self.assertNotIn("2 in flight", output.getvalue())
        self.assertEqual("first\n", (self.root / ".out/checks/first.log").read_text())

    def test_cancellation_stops_a_grandchild_that_ignores_sigterm(self):
        ready, release = self.root / "ready", self.root / "release"
        command = [sys.executable, str(FIXTURES / "process-tree.py"), str(ready), str(release)]
        process = cli.start_process(command, stdout=subprocess.PIPE)
        try:
            deadline = time.monotonic() + 5
            while not ready.exists() and time.monotonic() < deadline:
                time.sleep(0.01)
            self.assertTrue(ready.exists(), "grandchild must start before cancellation")
            cli.stop_process(process)
            release.touch()
            output, _ = process.communicate(timeout=5)
            self.assertEqual(b"", output, "a surviving descendant would report escape after release")
            self.assertIsNotNone(process.returncode)
        finally:
            release.touch()
            cli.stop_process(process)
            process.stdout.close()

    def test_launch_error_reaps_previous_child(self):
        process = Mock()
        process.poll.return_value = None
        process.wait.return_value = -15
        with patch.object(cli.subprocess, "Popen", side_effect=[process, OSError("launch failed")]), \
                patch.object(cli, "stop_process") as stop, \
                contextlib.redirect_stdout(io.StringIO()), self.assertRaisesRegex(OSError, "launch failed"):
            cli.run_jobs([cli.Job("active", ["fake"], 1), cli.Job("broken", ["missing"], 1)],
                         "checks", self.root, {}, 2000, False)
        stop.assert_called_once_with(process)


class CommandFlowTest(unittest.TestCase):
    def setUp(self):
        self.lua = None
        for name in ([os.environ["LUA"]] if os.environ.get("LUA") else ["lua5.1", "lua"]):
            candidate = shutil.which(name)
            if candidate:
                result = subprocess.run([candidate, "-e", "io.write(_VERSION)"], capture_output=True, text=True)
                if result.returncode == 0 and result.stdout == "Lua 5.1":
                    self.lua = candidate
                    break
        if not self.lua:
            self.skipTest("Lua 5.1 is required for tiny command fixtures")
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb commands ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for directory in ("tools/cli", "tools/distribution", "tools/differential", "generator", "validators"):
            (self.root / directory).mkdir(parents=True)
        shutil.copy(ROOT / "tools/cli/questiedb.py", self.root / "tools/cli/questiedb.py")
        shutil.copy(ROOT / "questiedb.sh", self.root / "questiedb.sh")
        shutil.copy(ROOT / "questiedb.ps1", self.root / "questiedb.ps1")
        shutil.copy(ROOT / "tools/cli/run-python.ps1", self.root / "tools/cli/run-python.ps1")
        self.env = dict(os.environ, LUA=self.lua, QUESTIEDB_TEST_EXIT="0")
        self.env.pop("FAIL_GENERATE", None)
        self.env.pop("CHANGE_ARTIFACT", None)
        self.env.pop("FAIL_READ", None)
        shutil.copyfile(FIXTURES / "generate.lua", self.root / "generate.lua")
        shutil.copyfile(FIXTURES / "questie-pin.lua", self.root / "generator/lib.lua")
        for script in ("verify.lua", "equivalence.lua", "reconstruct.lua", "validators/run.lua", "test.lua"):
            shutil.copyfile(FIXTURES / "read.lua", self.root / script)
        for script in ("tools/differential/compiler_diff.py", "tools/differential/golden.py",
                       "tools/cli/questiedb.test.py"):
            shutil.copyfile(FIXTURES / "read.py", self.root / script)

    def run_cli(self, *args):
        return subprocess.run([sys.executable, str(self.root / "tools/cli/questiedb.py"), *args],
                              cwd=self.root.parent, env=self.env, capture_output=True, text=True, timeout=30)

    def test_all_finishes_every_generation_before_readers(self):
        result = self.run_cli("all", "Vanilla", "Mists", "--budget-mb=2000", "--questie=path with spaces; literal")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        events = (self.root / "events.log").read_text().splitlines()
        self.assertEqual("pin:path with spaces; literal", events[0])
        self.assertEqual(1, events.count("generate:Vanilla"))
        self.assertEqual(1, events.count("generate:Mists"))
        last_generation = max(events.index("generate:Vanilla"), events.index("generate:Mists"))
        reads = [index for index, event in enumerate(events) if event.startswith("read:")]
        self.assertEqual(14, len(reads))
        self.assertTrue(all(index > last_generation for index in reads))
        self.assertFalse((self.root / ".out/dist").exists())

    def test_generation_failure_blocks_later_phases(self):
        self.env["FAIL_GENERATE"] = "Vanilla"
        result = self.run_cli("all", "Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertNotIn("read:", (self.root / "events.log").read_text())

    def test_determinism_compares_actual_bytes_without_external_hash_tools(self):
        result = self.run_cli("generate", "determinism", "Vanilla")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        self.assertIn("identical bytes", (self.root / ".out/checks/determinism_Vanilla.log").read_text())
        self.env["CHANGE_ARTIFACT"] = "1"
        changed = self.run_cli("determinism", "Vanilla")
        self.assertNotEqual(0, changed.returncode)
        self.assertIn("checksum differs", (self.root / ".out/checks/determinism_Vanilla.log").read_text())

    def test_invalid_selection_and_missing_lua_preserve_logs(self):
        logdir = self.root / ".out/checks"
        logdir.mkdir(parents=True)
        (logdir / "previous.log").write_text("previous")
        invalid = self.run_cli("generate", "--budget-mb=0", "--lua=absent")
        self.assertEqual(2, invalid.returncode)
        self.assertIn("positive decimal", invalid.stderr)
        missing = self.run_cli("generate", "--lua=absent")
        self.assertNotEqual(0, missing.returncode)
        self.assertEqual("previous", (logdir / "previous.log").read_text())
        self.assertFalse((self.root / "events.log").exists())

    def test_default_freeze_and_duplicate_jobs(self):
        result = self.run_cli("freeze", "freeze", "--sequential")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        self.assertIn("all 2 checks jobs passed", result.stdout)
        self.env["FAIL_READ"] = "1"
        failed = self.run_cli("verify", "verify", "Vanilla", "Vanilla")
        self.assertNotEqual(0, failed.returncode)
        self.assertIn("1 of 1 failed", failed.stdout)

    @unittest.skipIf(os.name == "nt", "POSIX launcher test")
    def test_posix_launcher_finds_python_alias_and_reports_missing_python(self):
        shell = shutil.which("sh")
        if not shell:
            self.skipTest("POSIX launcher requires sh")
        bin_dir = self.root / "bin"
        bin_dir.mkdir()
        (bin_dir / "python").symlink_to(sys.executable)
        (bin_dir / "dirname").symlink_to(shutil.which("dirname"))
        env = dict(self.env, PATH=str(bin_dir), QUESTIEDB_TEST_EXIT="7")
        shutil.copyfile(FIXTURES / "arguments.py", self.root / "tools/distribution/package.py")
        command = [shell, str(self.root / "questiedb.sh"), "package", "argument with spaces"]
        result = subprocess.run(command, env=env, capture_output=True, text=True, timeout=30)
        self.assertEqual(7, result.returncode, result.stderr)
        self.assertEqual(["argument with spaces"], json.loads(result.stdout))
        (bin_dir / "python").unlink()
        missing = subprocess.run(command, env=env, capture_output=True, text=True, timeout=30)
        self.assertEqual(2, missing.returncode)
        self.assertIn("Python 3.8+", missing.stderr)

    def test_help_and_standalone_dispatch_need_no_lua_and_forward_argv_and_exit_code(self):
        self.env["LUA"] = "missing-lua"
        help_result = self.run_cli("--help")
        self.assertEqual(0, help_result.returncode)
        self.assertIn("questiedb.sh", help_result.stdout)
        for task, code, args in (("package", "7", ["Vanilla", "argument with spaces"]),
                                 ("bootstrap", "3", ["AddOns path with spaces", "preview"])):
            with self.subTest(task=task):
                self.env["QUESTIEDB_TEST_EXIT"] = code
                shutil.copyfile(FIXTURES / "arguments.py", self.root / "tools/distribution" / (task + ".py"))
                result = self.run_cli(task, *args)
                self.assertEqual(int(code), result.returncode)
                self.assertEqual(args, json.loads(result.stdout))
        self.assertFalse((self.root / "events.log").exists())

    def test_lua_process_helper_forwards_a_posix_argument_with_spaces_and_backslashes(self):
        argument = "C:\\Addon Folder\\"
        env = dict(self.env, QUESTIEDB_PYTHON=sys.executable,
                   PROBE_LIB=str(ROOT / "generator/lib.lua"), PROBE_ARGUMENT=argument)
        command = [self.lua, str(FIXTURES / "lua-argv.lua"), str(FIXTURES / "arguments.py")]
        result = subprocess.run(command, env=env, capture_output=True, text=True, timeout=30)
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual([argument], json.loads(result.stdout))

    def test_powershell_launcher_forwards_arguments(self):
        powershell = shutil.which("pwsh") or shutil.which("powershell")
        if not powershell:
            self.skipTest("PowerShell is not installed")
        self.env["QUESTIEDB_TEST_EXIT"] = "7"
        shutil.copyfile(FIXTURES / "arguments.py", self.root / "tools/distribution/package.py")
        fixture = self.root / "invoke.ps1"
        fixture.write_text("& (Join-Path $PSScriptRoot 'questiedb.ps1') package '' 'argument \"with quotes\"' 'C:\\Addon Folder\\'\n"
                           "exit $LASTEXITCODE\n")
        result = subprocess.run([powershell, "-NoProfile", "-File", str(fixture)],
                                env=self.env, capture_output=True, text=True, timeout=30)
        self.assertEqual(7, result.returncode, result.stdout + result.stderr)
        self.assertEqual(["", 'argument "with quotes"', "C:\\Addon Folder\\"], json.loads(result.stdout))


if __name__ == "__main__":
    unittest.main()
