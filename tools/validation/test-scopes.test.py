"""Test scope selection and fail-closed artifact admission without generating databases.

Run with uv run tools/validation/test-scopes.test.py.
"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
LUA = shutil.which(os.environ.get("LUA", "lua5.1"))


class TestScopes(unittest.TestCase):
    def run_test(self, *args, root=ROOT):
        return subprocess.run([LUA, "test.lua", *args], cwd=root,
                              capture_output=True, text=True, timeout=15)

    def selected(self, *args):
        result = self.run_test(*args, "--list")
        self.assertEqual(result.returncode, 0, result.stderr)
        return set(result.stdout.splitlines())

    def test_scopes_cover_every_suite_without_cross_flavor_ownership(self):
        shared = self.selected("--shared")
        flavors = {flavor: self.selected("--flavor=" + flavor)
                   for flavor in ("Vanilla", "TBC", "Wrath", "Cata", "Mists")}
        forever = self.selected("--flavor=Forever")
        self.assertEqual(forever, {"artifact-lines", "artifact-wire", "artifact-types",
                                   "forever-delta-base-baked"})
        self.assertFalse(shared & forever)
        self.assertIn("forever-data", shared)
        self.assertIn("validator-diagnostics", shared)
        self.assertIn("native-toc", shared)
        self.assertEqual(self.selected(), shared.union(forever, *flavors.values()))
        for suites in flavors.values():
            self.assertFalse(shared & suites)
            self.assertTrue({"artifact-lines", "artifact-wire", "artifact-types"} <= suites)
        self.assertIn("personas", flavors["Vanilla"])
        self.assertNotIn("personas-titan", flavors["Vanilla"])
        self.assertIn("personas-titan", flavors["Wrath"])
        self.assertNotIn("personas", flavors["Wrath"])
        self.assertIn("sod-required-races-baked", flavors["Vanilla"])
        self.assertIn("titan-translations-baked", flavors["Wrath"])

    def test_invalid_arguments_fail_instead_of_passing_zero_checks(self):
        for args in (("typo",), ("--flavor=Unknown",), ("--flavor=",),
                     ("--shared", "--flavor=Wrath"), ("--shared", "cbor"),
                     ("cbor", "--shared"), ("--shared", "--shared")):
            with self.subTest(args=args):
                result = self.run_test(*args)
                self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
                self.assertNotIn("[PASS]", result.stdout)

    def test_legacy_names_keep_split_assertions(self):
        self.assertEqual(self.selected("personas"), {"personas", "personas-titan"})
        self.assertEqual(self.selected("chunking"), {"chunking", "artifact-lines"})
        self.assertEqual(self.selected("lua-types"), {"lua-types", "artifact-types"})

    def copy_harness(self, root):
        """Copy artifact-scope dependencies, without shared-only validators or entity data."""
        for path in ("generator", "src", "emulator"):
            shutil.copytree(ROOT / path, root / path)
        for path in ("test.lua", "tools/validation/test-files.lua",
                     "tools/validation/storage-fixture.lua",
                     "tools/validation/test-scopes-fixture.lua",
                     "tools/validation/forever-delta-base.test.lua"):
            target = root / path
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(ROOT / path, target)

    def test_unselected_diagnostic_fixtures_are_not_startup_dependencies(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.copy_harness(root)
            self.assertFalse((root / "validators").exists())
            for args in (("--list",), ("--shared", "--list"),
                         ("--flavor=Forever", "--list"), ("base64",)):
                with self.subTest(args=args):
                    result = self.run_test(*args, root=root)
                    self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

            # Missing selected fixtures must fail, not silently remove diagnostics coverage.
            selected = self.run_test("validator-diagnostics", root=root)
            self.assertNotEqual(selected.returncode, 0)
            self.assertIn("validators/diagnostics.test.lua", selected.stderr)

    def test_forever_artifact_scope_runs_without_entity_payloads(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.copy_harness(root)
            # The flavor scope now includes readable entity witnesses, not just headers.
            fixture = subprocess.run(
                [LUA, "tools/validation/test-scopes-fixture.lua", str(root)], cwd=root,
                capture_output=True, text=True, timeout=15)
            self.assertEqual(fixture.returncode, 0, fixture.stdout + fixture.stderr)
            self.assertFalse((root / "data").exists())
            self.assertFalse((root / "validators").exists())
            result = self.run_test("--flavor=Forever", root=root)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("[PASS] forever-delta-base-baked", result.stdout)
            self.assertIn("4 checks, 0 failed", result.stdout)
            self.assertNotIn("SKIP", result.stdout)

    def test_missing_and_partial_artifacts_fail_before_running_suites(self):
        # Only the harness's startup dependencies are copied. No owned data or real TOCs
        # are needed, and the caller's generated artifacts are never renamed or removed.
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.copy_harness(root)
            toc = root / "QuestieDB_TBC.toc"
            for content in (None, "## X-Flavor: Wrath\n",
                            "## X-Flavor: TBC\n",
                            "## X-Flavor: TBC\n## X-l10n-Version: 1\n"):
                with self.subTest(content=content):
                    if content is not None:
                        toc.write_text(content)
                    result = self.run_test("--flavor=TBC", root=root)
                    self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
                    self.assertIn("Artifact preflight failed", result.stderr)
                    self.assertNotIn("[PASS]", result.stdout)


if __name__ == "__main__":
    unittest.main()
