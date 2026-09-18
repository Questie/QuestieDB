"""Version validation and real tracer Generation. Run: uv run tools/validation/version.test.py."""
import shutil
import unittest

from fixture import LuaFixture, ROOT


class VersionTest(LuaFixture):
    def test_version_reader_and_baked_version_contract(self):
        (self.root / "generator").mkdir()
        for filename in ("lib.lua", "version.lua"):
            shutil.copyfile(ROOT / "generator" / filename, self.root / "generator" / filename)
        assertions = str(ROOT / "tools/validation/version.test.lua")
        scratch = self.root / "version-fixture.toc"
        self.assert_success(self.run_lua(assertions, str(scratch)))
        self.assertFalse(scratch.exists())

    def test_generation_preserves_versions_and_rejects_invalid_inputs_before_writes(self):
        self.copy_inputs("Classic")
        source = self.write("QuestieDB.toc", "## Version: 12.34.567\n")
        self.init_git(self.root)
        self.git(self.root, "add", "QuestieDB.toc")
        self.git(self.root, "commit", "--quiet", "-m", "version fixture")
        commit = self.git(self.root, "rev-parse", "HEAD")
        self.assert_success(self.run_lua("generate.lua", "toc", "--quiet"))
        source_bytes = source.read_bytes()
        self.assertIn(b"## Version: 12.34.567\n", source_bytes)
        self.assert_success(self.run_lua("generate.lua", "toc", "--quiet", env={"QUESTIEDB_RELEASE": "true"}))
        self.assertEqual(source_bytes, source.read_bytes())

        args = ("generate.lua", "Vanilla", "--no-l10n", "--no-base-toc", "--types=Quest", "--fields=name", "--quiet")
        baked = self.root / "QuestieDB_Vanilla.toc"
        self.assert_success(self.run_lua(*args))
        self.assertIn(("## Version: 12.34.567-dev.%s\n" % commit[:7]).encode(), baked.read_bytes())
        self.assert_success(self.run_lua(*args, env={"QUESTIEDB_RELEASE": "true"}))
        self.assertIn(b"## Version: 12.34.567\n", baked.read_bytes())
        self.assertEqual(source_bytes, source.read_bytes())
        baked_bytes = baked.read_bytes()

        invalid_flag = self.run_lua(*args, env={"QUESTIEDB_RELEASE": "yes"})
        self.assertNotEqual(0, invalid_flag.returncode)
        self.assertIn("QUESTIEDB_RELEASE", invalid_flag.stderr)
        self.assertEqual(baked_bytes, baked.read_bytes())
        self.write("QuestieDB.toc", "## Version: invalid\n")
        invalid_source = self.run_lua("generate.lua", "toc", "--quiet")
        self.assertNotEqual(0, invalid_source.returncode)
        self.assertEqual(b"## Version: invalid\n", source.read_bytes())
        self.assertNotEqual(0, self.run_lua(*args).returncode)
        self.assertEqual(baked_bytes, baked.read_bytes())


if __name__ == "__main__":
    unittest.main()
