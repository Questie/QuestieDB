"""Portable, isolated source-tree fixtures shared by offline integration tests."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]


class LuaFixture(unittest.TestCase):
    """Copy only the selected expansion and real tooling into a disposable checkout."""

    def setUp(self):
        self.lua = None
        for name in ([os.environ["LUA"]] if os.environ.get("LUA") else ["lua5.1", "lua"]):
            executable = shutil.which(name)
            if executable:
                result = subprocess.run([executable, "-e", "io.write(_VERSION)"], capture_output=True, text=True)
                if result.returncode == 0 and result.stdout == "Lua 5.1":
                    self.lua = str(Path(executable).resolve())
                    break
        if not self.lua or not shutil.which("git"):
            self.skipTest("Lua 5.1 and Git are required for offline integration tests")
        self.temporary = tempfile.TemporaryDirectory(prefix="questiedb fixture ")
        self.addCleanup(self.temporary.cleanup)
        self.temp = Path(self.temporary.name)
        self.root = self.temp / "work tree's inputs"
        self.root.mkdir()
        config = self.temp / "gitconfig"
        config.write_bytes(b"")
        # Ignore the caller's repositories/configuration and prohibit network Git protocols.
        self.env = {key: value for key, value in os.environ.items() if not key.startswith("GIT_")}
        self.env.pop("QUESTIE_PATH", None)
        self.env.update(GIT_CONFIG_GLOBAL=str(config), GIT_CONFIG_NOSYSTEM="1", GIT_CONFIG_COUNT="0",
                        GIT_ALLOW_PROTOCOL="file", QUESTIEDB_PYTHON=sys.executable, LUA=self.lua,
                        QUESTIEDB_RELEASE="false", SOURCE_DATE_EPOCH="1700000000")

    def copy_inputs(self, expansion):
        """No symlink privileges or full localization tree are needed for a tracer artifact."""
        for directory in ("generator", "src", "support"):
            shutil.copytree(ROOT / directory, self.root / directory, ignore=shutil.ignore_patterns("__pycache__"))
        shutil.copytree(ROOT / "data" / expansion, self.root / "data" / expansion)
        for filename in ("generate.lua", "reconstruct.lua"):
            shutil.copyfile(ROOT / filename, self.root / filename)
        target = self.root / "tools/questie-sync"
        target.mkdir(parents=True)
        shutil.copyfile(ROOT / "tools/questie-sync/checkout.py", target / "checkout.py")

    def write(self, relative, content):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode("utf-8"))
        return path

    def run_lua(self, *arguments, env=None):
        return subprocess.run([self.lua, *arguments], cwd=self.root,
                              env=dict(self.env, **(env or {})), capture_output=True, text=True, timeout=60)

    def git(self, directory, *arguments):
        result = subprocess.run(["git", "-C", str(directory), *arguments], env=self.env,
                                capture_output=True, text=True, timeout=30)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        return result.stdout.strip()

    def init_git(self, directory):
        self.git(directory, "init", "--quiet")
        self.git(directory, "config", "user.name", "Fixture")
        self.git(directory, "config", "user.email", "fixture@example.invalid")
        self.git(directory, "config", "commit.gpgsign", "false")
        self.git(directory, "config", "core.autocrlf", "false")

    def assert_success(self, result):
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
