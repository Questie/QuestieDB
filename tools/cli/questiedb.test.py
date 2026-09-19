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
        self.assertEqual(["generate", *cli.CHECKS, "test"], cli.parse_args(["all"]).tasks)

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
                 (["generate", "Camelot"], "unknown"),
                 (["unknown"], "unknown")]
        for args, message in cases:
            with self.subTest(args=args), self.assertRaisesRegex(ValueError, message):
                cli.parse_args(args)


class LuaSelectionTest(unittest.TestCase):
    def test_matching_bundles_and_explicit_overrides_take_precedence(self):
        with tempfile.TemporaryDirectory(prefix="lua selection ") as directory:
            root = Path(directory)
            bundled = root / "tools/lua-binary/lua.exe"
            bundled.parent.mkdir(parents=True)
            bundled.touch()
            linux_bundle = root / "tools/lua-binary/linux-x64/lua"
            linux_bundle.parent.mkdir()
            linux_bundle.touch()
            process = Mock(returncode=0)
            process.communicate.return_value = ("Lua 5.1", "")
            cases = [("win32", "AMD64", None, bundled),
                     ("win32", "x86", None, root / "lua5.1"),
                     ("win32", "ARM64", None, root / "lua5.1"),
                     ("linux", "x86_64", None, linux_bundle),
                     ("linux", "aarch64", None, root / "lua5.1"),
                     ("darwin", "arm64", None, root / "lua5.1"),
                     ("win32", "AMD64", "custom", root / "custom"),
                     ("linux", "x86_64", "custom", root / "custom")]
            for platform, machine, explicit, expected in cases:
                with self.subTest(platform=platform, machine=machine, explicit=explicit), \
                        patch.object(cli.sys, "platform", platform), \
                        patch.object(cli.platform, "machine", return_value=machine), \
                        patch.object(cli.shutil, "which", side_effect=lambda name: str(root / name)), \
                        patch.object(cli, "start_process", return_value=process) as start:
                    self.assertEqual(str(expected.resolve()), cli.find_lua(explicit, root))
                    self.assertEqual(str(expected), start.call_args.args[0][0])
            with patch.object(cli.sys, "platform", "win32"), \
                    patch.object(cli.shutil, "which", return_value=None), \
                    self.assertRaisesRegex(ValueError, "Lua 5.1 is required"):
                cli.find_lua("missing-override", root)


@unittest.skipIf(os.name == "nt", "POSIX shell routing fixtures")
class ShellGeneratorTest(unittest.TestCase):
    def setUp(self):
        self.bash = shutil.which("bash")
        if not self.bash:
            self.skipTest("Bash is required")
        try:
            self.lua = cli.find_lua(os.environ.get("LUA") or None, ROOT)
        except ValueError:
            self.skipTest("Lua 5.1 is required")
        self.temp = tempfile.TemporaryDirectory(prefix="shell generation ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.outside = self.root / "outside"
        self.outside.mkdir()
        shutil.copyfile(ROOT / "generate.sh", self.root / "generate.sh")
        shutil.copyfile(FIXTURES / "batch-generate.lua", self.root / "generate.lua")
        for path in ("tools/lua-binary/lua.exe", "tools/lua-binary/linux-x64/lua"):
            target = self.root / path
            target.parent.mkdir(parents=True, exist_ok=True)
            target.symlink_to(self.lua)
        (self.bin / "dirname").symlink_to(shutil.which("dirname"))
        self.stub("uname", 'case "$1" in -s) echo "$TEST_OS";; -m) echo "$TEST_ARCH";; esac')
        self.stub("cygpath", 'case "$1" in -u) printf "%s\\n" "$2";; -w) printf "WIN:%s\\n" "$2";; esac')
        self.env = dict(os.environ, PATH=str(self.bin), TEST_OS="Linux", TEST_ARCH="x86_64",
                        QUESTIEDB_TEST_EXIT="0")
        self.env.pop("LUA", None)

    def stub(self, name, body):
        path = self.bin / name
        path.write_text("#!/bin/sh\n" + body + "\n")
        path.chmod(0o755)

    def run_generator(self, *args):
        return subprocess.run([self.bash, str(self.root / "generate.sh"), *args],
                              cwd=self.outside, env=self.env, capture_output=True, text=True, timeout=10)

    def test_linux_bundle_preserves_arguments_cwd_default_and_failure_status(self):
        result = self.run_generator("argument with spaces", "", "--quiet")
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertIn("argument with spaces||--quiet", result.stdout)
        self.assertIn("LUA=" + str(self.root / "tools/lua-binary/linux-x64/lua"), result.stdout)
        self.assertEqual("checkout", (self.root / "batch-result.txt").read_text())
        self.assertFalse((self.outside / "batch-result.txt").exists())
        self.env["QUESTIEDB_TEST_EXIT"] = "7"
        failed = self.run_generator()
        self.assertEqual(7, failed.returncode, failed.stderr)
        self.assertIn("default: all", failed.stdout)

    def test_git_bash_selects_windows_binary_and_exports_native_path(self):
        for system in ("MINGW64_NT-10.0", "MSYS_NT-10.0"):
            with self.subTest(system=system):
                self.env["TEST_OS"] = system
                result = self.run_generator("Vanilla")
                self.assertEqual(0, result.returncode, result.stderr)
                self.assertIn("LUA=WIN:" + str(self.root / "tools/lua-binary/lua.exe"), result.stdout)

    def test_macos_uses_compatible_installed_lua_and_rejects_missing_or_wrong_version(self):
        self.env["TEST_OS"] = "Darwin"
        missing = self.run_generator()
        self.assertEqual(2, missing.returncode)
        self.assertIn("brew install luajit", missing.stderr)
        self.stub("lua", 'printf "Lua 5.4"')
        wrong = self.run_generator()
        self.assertEqual(2, wrong.returncode)
        (self.bin / "luajit").symlink_to(self.lua)
        found = self.run_generator("Vanilla")
        self.assertEqual(0, found.returncode, found.stderr)
        self.assertIn("LUA=" + str(self.bin / "luajit"), found.stdout)

    def test_override_wins_and_unsupported_architecture_never_runs_x64_bundle(self):
        self.env["TEST_ARCH"] = "aarch64"
        unsupported = self.run_generator()
        self.assertEqual(2, unsupported.returncode)
        self.assertIn("architecture", unsupported.stderr)
        self.env["LUA"] = self.lua
        overridden = self.run_generator("Vanilla")
        self.assertEqual(0, overridden.returncode, overridden.stderr)
        self.assertIn("LUA=" + self.lua, overridden.stdout)
        self.env.update(TEST_ARCH="x86_64", LUA="missing-override")
        self.assertEqual(2, self.run_generator().returncode)
        self.stub("wrong-lua", 'printf "Lua 5.4"')
        self.env["LUA"] = "wrong-lua"
        self.assertEqual(2, self.run_generator().returncode)


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
        try:
            self.lua = cli.find_lua(os.environ.get("LUA") or None, ROOT)
        except ValueError:
            self.skipTest("Lua 5.1 is required for tiny command fixtures")
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb commands ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for directory in ("tools/cli", "tools/distribution", "tools/validation", "tools/dbc", "validators"):
            (self.root / directory).mkdir(parents=True)
        shutil.copy(ROOT / "tools/cli/questiedb.py", self.root / "tools/cli/questiedb.py")
        shutil.copy(ROOT / "questiedb.sh", self.root / "questiedb.sh")
        shutil.copy(ROOT / "questiedb.ps1", self.root / "questiedb.ps1")
        shutil.copy(ROOT / "tools/cli/run-python.ps1", self.root / "tools/cli/run-python.ps1")
        self.env = dict(os.environ, LUA=self.lua, QUESTIEDB_TEST_EXIT="0")
        self.env.pop("FAIL_GENERATE", None)
        self.env.pop("CHANGE_ARTIFACT", None)
        self.env.pop("CHANGE_ALIAS", None)
        self.env.pop("FAIL_READ", None)
        shutil.copyfile(FIXTURES / "generate.lua", self.root / "generate.lua")
        for script in ("verify.lua", "equivalence.lua", "reconstruct.lua", "validators/run.lua", "test.lua"):
            shutil.copyfile(FIXTURES / "read.lua", self.root / script)
        for script in ("tools/cli/questiedb.test.py", "tools/validation/test-scopes.test.py",
                       "tools/dbc/coordinates.test.py", "tools/dbc/download.test.py",
                       "tools/dbc/rewrite.test.py", "tools/dbc/convert.test.py"):
            shutil.copyfile(FIXTURES / "read.py", self.root / script)

    def run_cli(self, *args):
        return subprocess.run([sys.executable, str(self.root / "tools/cli/questiedb.py"), *args],
                              cwd=self.root.parent, env=self.env, capture_output=True, text=True, timeout=30)

    def test_all_finishes_every_generation_before_readers(self):
        result = self.run_cli("all", "Vanilla", "Mists", "--budget-mb=2000")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        events = (self.root / "events.log").read_text().splitlines()
        self.assertEqual(1, events.count("generate:Vanilla"))
        self.assertEqual(1, events.count("generate:Mists"))
        last_generation = max(events.index("generate:Vanilla"), events.index("generate:Mists"))
        reads = [index for index, event in enumerate(events) if event.startswith("read:")]
        self.assertEqual(17, len(reads))
        self.assertTrue(all(index > last_generation for index in reads))
        self.assertFalse((self.root / ".out/dist").exists())

    def test_test_task_selects_shared_and_only_requested_artifact_suites(self):
        options = cli.parse_args(["test", "Wrath", "TBC", "Forever"])
        with patch.object(cli, "find_lua", return_value=self.lua), \
                patch.object(cli, "run_jobs", return_value=True) as run_jobs, \
                contextlib.redirect_stdout(io.StringIO()):
            self.assertEqual(0, cli.execute(options, self.root))
        jobs = run_jobs.call_args.args[0]
        lua_tests = [job.command for job in jobs if job.command[1] == "test.lua"]
        self.assertEqual([
            [self.lua, "test.lua", "--shared"],
            [self.lua, "test.lua", "--flavor=Wrath"],
            [self.lua, "test.lua", "--flavor=TBC"],
            [self.lua, "test.lua", "--flavor=Forever"],
        ], lua_tests)
        self.assertEqual(len(jobs), len({job.label for job in jobs}))

    def test_default_check_includes_six_flavors(self):
        result = self.run_cli("check")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        events = (self.root / "events.log").read_text().splitlines()
        self.assertEqual(24, sum(event.startswith("read:") for event in events))
        self.assertIn("all 24 checks jobs passed", result.stdout)

    def test_forever_determinism_checks_both_tocs_and_pair_equality(self):
        result = self.run_cli("generate", "determinism", "Forever")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        self.env["CHANGE_ALIAS"] = "1"
        changed = self.run_cli("determinism", "Forever")
        self.assertNotEqual(0, changed.returncode)
        self.assertIn("checksum differs", (self.root / ".out/checks/determinism_Forever.log").read_text())
        mismatched = self.run_cli("determinism", "Forever")
        self.assertNotEqual(0, mismatched.returncode)
        self.assertIn("TOCs differ before regeneration", mismatched.stderr)

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
                                 ("bootstrap", "3", ["AddOns path with spaces", "preview"]),
                                 ("dbc-coordinates", "4", ["--database", "path with spaces"]),
                                 ("convert-forever", "5", ["--dry-run"])):
            with self.subTest(task=task):
                self.env["QUESTIEDB_TEST_EXIT"] = code
                shutil.copyfile(FIXTURES / "arguments.py", self.root / ({"dbc-coordinates": "tools/dbc/maps.py",
                                   "convert-forever": "tools/dbc/convert.py"}.get(task, "tools/distribution/" + task + ".py")))
                result = self.run_cli(task, *args)
                self.assertEqual(int(code), result.returncode)
                self.assertEqual(args, json.loads(result.stdout))
        for task, script in (("dbc-coordinates", "maps.py"), ("convert-forever", "convert.py")):
            with self.subTest(task=task):
                self.env["QUESTIEDB_TEST_EXIT"] = "4"
                shutil.copyfile(FIXTURES / "arguments.py", self.root / "tools/dbc" / script)
                args = ["--database", "path with spaces/source.db", "--help"]
                result = self.run_cli(task, *args)
                self.assertEqual(4, result.returncode)
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

    @unittest.skipUnless(os.name == "nt", "Native Git Bash launcher test")
    def test_native_git_bash_uses_windows_bundle_and_preserves_override_and_status(self):
        git = shutil.which("git")
        git_root = Path(git).parent.parent if git else None
        bash = git_root / "bin/bash.exe" if git_root else None
        if not bash or not bash.is_file():
            self.skipTest("Git for Windows with bin/bash.exe is required")
        bundled = self.root / "tools/lua-binary/lua.exe"
        bundled.parent.mkdir(parents=True)
        shutil.copyfile(ROOT / "tools/lua-binary/lua.exe", bundled)
        shutil.copyfile(ROOT / "generate.sh", self.root / "generate.sh")
        shutil.copyfile(FIXTURES / "batch-generate.lua", self.root / "generate.lua")
        outside = self.root / "outside"
        outside.mkdir()
        env = dict(self.env, MSYSTEM="MINGW64", PATH=str(git_root / "usr/bin"))
        env.pop("LUA", None)
        command = [str(bash), "--noprofile", "--norc", (self.root / "generate.sh").as_posix(),
                   "argument with spaces", "", "--quiet"]
        result = subprocess.run(command, cwd=outside, env=env,
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        self.assertIn("argument with spaces||--quiet", result.stdout)
        self.assertIn("LUA=" + str(bundled), result.stdout)
        self.assertEqual("checkout", (self.root / "batch-result.txt").read_text())
        env.update(LUA=str(bundled), QUESTIEDB_TEST_EXIT="7")
        overridden = subprocess.run(command, cwd=outside, env=env,
                                    capture_output=True, text=True, timeout=30)
        self.assertEqual(7, overridden.returncode, overridden.stdout + overridden.stderr)

    @unittest.skipUnless(os.name == "nt", "Windows batch launcher test")
    def test_batch_generator_uses_bundle_without_python_and_preserves_exit_status(self):
        bundled = self.root / "tools/lua-binary/lua.exe"
        bundled.parent.mkdir(parents=True)
        shutil.copyfile(ROOT / "tools/lua-binary/lua.exe", bundled)
        shutil.copyfile(ROOT / "generate.cmd", self.root / "generate.cmd")
        shutil.copyfile(FIXTURES / "batch-generate.lua", self.root / "generate.lua")
        outside = self.root / "outside"
        outside.mkdir()
        env = dict(self.env, PATH=str(self.root / "no-tools"))
        env.pop("LUA", None)
        comspec = os.environ.get("COMSPEC", "cmd.exe")
        batch = self.root / "generate.cmd"
        # cmd /s /c strips an outer quote pair; CRT list quoting alone loses a spaced path.
        command = '"{}" /d /s /c ""{}" "argument with spaces" --quiet"'.format(comspec, batch)
        result = subprocess.run(command, cwd=outside, env=env,
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        self.assertIn("argument with spaces|--quiet", result.stdout)
        self.assertFalse((outside / "batch-result.txt").exists())
        self.assertEqual("checkout", (self.root / "batch-result.txt").read_text())
        env["QUESTIEDB_TEST_EXIT"] = "7"
        failed = subprocess.run(command, cwd=outside, env=env,
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(7, failed.returncode, failed.stdout + failed.stderr)
        # No arguments models a double-click; a newline dismisses the final pause.
        default_command = '"{}" /d /s /c ""{}""'.format(comspec, batch)
        default = subprocess.run(default_command, cwd=outside, env=env, input="\n",
                                 capture_output=True, text=True, timeout=30)
        self.assertEqual(7, default.returncode, default.stdout + default.stderr)
        self.assertIn("default: all", default.stdout)
        env.update(LUA="missing-override", QUESTIEDB_TEST_EXIT="0")
        overridden = subprocess.run(command, cwd=outside, env=env,
                                    capture_output=True, text=True, timeout=30)
        self.assertNotEqual(0, overridden.returncode, "an explicit override must not fall back to bundled Lua")

    def test_powershell_launcher_forwards_arguments(self):
        powershell = shutil.which("pwsh") or shutil.which("powershell")
        if not powershell:
            self.skipTest("PowerShell is not installed")
        self.env["QUESTIEDB_TEST_EXIT"] = "7"
        shutil.copyfile(FIXTURES / "arguments.py", self.root / "tools/distribution/package.py")
        fixture = self.root / "invoke.ps1"
        fixture.write_text("& (Join-Path $PSScriptRoot 'questiedb.ps1') package '' 'argument \"with quotes\"' 'C:\\Addon Folder\\'\n"
                           "exit $LASTEXITCODE\n")
        # Allow only this trusted fixture process; leave the machine's execution policy unchanged.
        result = subprocess.run([powershell, "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(fixture)],
                                env=self.env, capture_output=True, text=True, timeout=30)
        self.assertEqual(7, result.returncode, result.stdout + result.stderr)
        self.assertEqual(["", 'argument "with quotes"', "C:\\Addon Folder\\"], json.loads(result.stdout))


if __name__ == "__main__":
    unittest.main()
