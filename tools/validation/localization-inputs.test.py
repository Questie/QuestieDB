"""Local Generation/Reconstruction without Questie. Run: uv run tools/validation/localization-inputs.test.py."""
import json
import unittest

from fixture import LuaFixture


class LocalizationInputsTest(LuaFixture):
    def test_local_inputs_and_missing_input_protection(self):
        self.copy_inputs("TBC")
        trace = self.temp / "git-trace.json"
        self.env["GIT_TRACE2_EVENT"] = str(trace)
        source = self.write("QuestieDB.toc", "## Version: 1.2.3\n")
        locales = self.run_lua("-e", 'print(table.concat(dofile("src/config.lua").locales, " "))')
        self.assert_success(locales)
        lookup = "l10n/TBC/lookupQuests/"
        for locale in locales.stdout.split():
            self.write(lookup + locale + ".lua",
                       'QuestieLoader:ImportModule("l10n").questLookup["%s"] = function()\n' % locale +
                       'return { [2] = { "Owned translation", { "Owned objective" } } } end\n')
        override = self.write("l10n/lookupOverrides.lua",
                              'QuestieLoader:ImportModule("l10n").questLookupOverrides = function()\n'
                              'return { [2] = { "Owned override" } } end\n')
        generate = ("generate.lua", "TBC", "--types=Quest", "--quiet")
        reconstruct = ("reconstruct.lua", "TBC", "--types=Quest", "--quiet")
        self.assert_success(self.run_lua(*generate))
        baked = self.root / "QuestieDB_TBC.toc"
        source_bytes, baked_bytes = source.read_bytes(), baked.read_bytes()
        self.assertIn(b"## X-l10n-deDE-Quest:", baked_bytes)
        self.assert_success(self.run_lua(*reconstruct))
        # Real Git traces expose attempts to inspect/fetch external state without fake shell
        # executables. Only the producer commit lookup in this disposable root is permitted.
        calls = [json.loads(line)["argv"] for line in trace.read_text(encoding="utf-8").splitlines()
                 if json.loads(line).get("event") == "start"]
        self.assertTrue(calls, "Git tracing must observe the producer provenance lookup")
        for argv in calls:
            self.assertEqual(["rev-parse", "HEAD"], argv[1:])

        missing = self.root / (lookup + "deDE.lua")
        translation = missing.read_bytes()
        missing.unlink()
        result = self.run_lua(*generate)
        self.assertNotEqual(0, result.returncode)
        self.assertIn("deDE.lua", result.stderr)
        self.assertEqual(source_bytes, source.read_bytes())
        self.assertEqual(baked_bytes, baked.read_bytes())
        self.assertNotEqual(0, self.run_lua(*reconstruct).returncode)
        missing.write_bytes(translation)

        override.unlink()
        result = self.run_lua(*generate)
        self.assertNotEqual(0, result.returncode)
        self.assertIn("lookupOverrides.lua", result.stderr)
        self.assertEqual(source_bytes, source.read_bytes())
        self.assertEqual(baked_bytes, baked.read_bytes())
        self.assertNotEqual(0, self.run_lua(*reconstruct).returncode)


if __name__ == "__main__":
    unittest.main()
