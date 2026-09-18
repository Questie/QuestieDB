"""Pinned checkout integration with real Git and a local upstream; no network access.

Run: uv run tools/questie-sync/questie-checkout.test.py
"""
from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "validation"))
from fixture import LuaFixture, ROOT


class QuestieCheckoutTest(LuaFixture):
    def test_cache_lifecycle_explicit_checkout_ownership_and_local_generation(self):
        self.copy_inputs("Classic")
        upstream = self.temp / "upstream"
        (upstream / "Database").mkdir(parents=True)
        (upstream / "Localization/lookups").mkdir(parents=True)
        (upstream / "Textures").mkdir()
        schema = upstream / "Database/questDB.lua"
        schema.write_bytes(b"schema fixture\n")
        (upstream / "Localization/lookups/lookupOverrides.lua").write_bytes(b"lookup fixture\n")
        (upstream / "Textures/texture.txt").write_bytes(b"Full snapshot fixture.\n")
        self.init_git(upstream)
        self.git(upstream, "add", ".")
        self.git(upstream, "commit", "--quiet", "-m", "first")
        first = self.git(upstream, "rev-parse", "HEAD")
        schema.write_bytes(b"pinned schema\n")
        self.git(upstream, "commit", "--quiet", "-am", "pinned")
        pinned = self.git(upstream, "rev-parse", "HEAD")
        schema.write_bytes(b"newer, unreviewed schema\n")
        self.git(upstream, "commit", "--quiet", "-am", "latest")
        latest = self.git(upstream, "rev-parse", "HEAD")
        self.git(upstream, "tag", "latest")
        # Git's normal URL rewrite keeps the actual checkout helper on its production path.
        self.git(upstream, "config", "--file", self.env["GIT_CONFIG_GLOBAL"],
                 "url.%s.insteadOf" % upstream.as_uri(), "https://github.com/Questie/Questie.git")
        pin_file = self.write("QUESTIE_COMMIT", pinned + "\n")
        source = self.write("QuestieDB.toc", "## Version: 1.2.3\nbase canary")
        baked = self.write("QuestieDB_Vanilla.toc", "baked canary")

        # Fake schema data cannot materialize, but resolution must first fetch the pin and
        # must leave both existing TOCs untouched when schema parsing fails.
        result = self.run_lua("generate.lua", "meta", "--quiet")
        self.assertNotEqual(0, result.returncode)
        self.assertEqual(b"## Version: 1.2.3\nbase canary", source.read_bytes())
        self.assertEqual(b"baked canary", baked.read_bytes())
        cache = self.root / ".cache/questie"
        cached = cache / pinned
        self.assertEqual(pinned, self.git(cached, "rev-parse", "HEAD"))
        self.assertEqual("1", self.git(cached, "rev-list", "--count", "HEAD"))
        self.assertEqual("", self.git(cached, "tag", "--list"))
        self.assertEqual("", self.git(cached, "branch", "-r"))
        self.assertEqual(b"pinned schema\n", (cached / "Database/questDB.lua").read_bytes())
        self.assertTrue((cached / "Localization/lookups/lookupOverrides.lua").is_file())
        self.assertEqual(b"Full snapshot fixture.\n", (cached / "Textures/texture.txt").read_bytes())

        resolver = str(ROOT / "tools/questie-sync/fixtures/resolve-checkout.lua")
        offline = upstream.with_name("upstream.offline")
        upstream.rename(offline)
        self.assert_success(self.run_lua(resolver, "cache"))
        pin_file.write_bytes((first + "\n").encode())
        self.assertNotEqual(0, self.run_lua(resolver, "cache").returncode)
        self.assertFalse((cache / first).exists())
        self.assertEqual([pinned], sorted(path.name for path in cache.iterdir()))
        offline.rename(upstream)
        self.assert_success(self.run_lua(resolver, "cache"))
        self.assertEqual(pinned, self.git(cached, "rev-parse", "HEAD"))

        pin_file.write_bytes((pinned + "\n").encode())
        self.assertNotEqual(0, self.run_lua("-e", 'dofile("generator/questie.lua").resolve()',
                                          env={"QUESTIE_PATH": str(upstream)}).returncode)
        self.assertEqual(latest, self.git(upstream, "rev-parse", "HEAD"))
        self.assert_success(self.run_lua(resolver, "explicit", str(cached),
                                        env={"QUESTIE_PATH": str(upstream)}))
        self.assert_success(self.run_lua(resolver, "environment", env={"QUESTIE_PATH": str(cached)}))

        pin_file.write_bytes(b"not-a-sha\n")
        result = self.run_lua(resolver, "cache")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("40-character Git SHA", result.stderr)
        self.assert_success(self.run_lua("generate.lua", "toc", "--quiet"))
        self.assert_success(self.run_lua("generate.lua", "Vanilla", "--types=Object", "--no-l10n",
                                        "--no-base-toc", "--quiet"))
        self.assertIn(("## X-QUESTIE-COMMIT: " + "0" * 40).encode(), baked.read_bytes())


if __name__ == "__main__":
    unittest.main()
