"""Real Forever Generation, stripping, and archive reads in a disposable fixture."""
import contextlib
import importlib.util
import io
from pathlib import Path
import shutil
import subprocess
import sys
import unittest
from unittest.mock import patch
import zipfile


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools/validation"))
from fixture import LuaFixture

SPEC = importlib.util.spec_from_file_location("bootstrap", ROOT / "tools/distribution/bootstrap.py")
bootstrap = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(bootstrap)


class ForeverDistributionTest(LuaFixture):
    def test_generated_forever_alias_loads_stripped_owned_providers(self):
        self.copy_inputs("Forever")
        (self.root / "icons").mkdir()
        shutil.copyfile(ROOT / "icons/QuestieTDB_64x64.png", self.root / "icons/QuestieTDB_64x64.png")
        for expansion in ("Classic", "TBC", "Wotlk", "Cata", "MoP"):
            shutil.copytree(ROOT / "data" / expansion, self.root / "data" / expansion)
        shutil.copytree(ROOT / "emulator", self.root / "emulator")
        shutil.copytree(ROOT / "tools/distribution", self.root / "tools/distribution",
                        ignore=shutil.ignore_patterns("__pycache__"))
        self.write("QuestieDB.toc", "## Version: 1.2.3\n")
        self.assert_success(self.run_lua("generate.lua", "all", "--no-l10n", "--no-base-toc",
                                         "--types=Quest", "--fields=name", "--quiet"))
        primary = self.root / "QuestieDB_Forever.toc"
        alias = self.root / "QuestieDB_Camelot.toc"
        self.assertEqual(primary.read_bytes(), alias.read_bytes())
        generated = primary.read_bytes()
        self.assert_success(self.run_lua("generate.lua", "Forever", "--no-l10n", "--no-base-toc",
                                         "--types=Quest", "--fields=name", "--quiet"))
        self.assertEqual(generated, primary.read_bytes())
        self.assertEqual(generated, alias.read_bytes())
        alias.write_bytes(b"stale workspace alias")
        result = subprocess.run([sys.executable, "tools/distribution/package.py", "all"],
                                cwd=self.root, env=self.env, capture_output=True, text=True, timeout=120)
        self.assert_success(result)
        stage = self.temp / "staged addon"
        stage.mkdir()
        archive = self.root / ".out/dist/QuestieDB-Forever.zip"
        bootstrap.stage_archive(archive, stage)
        self.assertEqual((stage / primary.name).read_bytes(), (stage / alias.name).read_bytes())
        with zipfile.ZipFile(archive) as packaged:
            providers = [name for name in packaged.namelist()
                         if name.startswith("QuestieDB/src/corrections/Forever/") and name.endswith(".lua")]
            # Static-only providers are folded into Generation and omitted from Baked lists.
            self.assertEqual(8, len(providers))
            self.assertTrue(any("QuestieDB/support/Forever/" in name for name in packaged.namelist()))
            for name in providers:
                self.assertIn(b"Static body stripped at package time", packaged.read(name))
        # Exercise the real checksum/preflight/install path using only local release assets.
        addons = self.temp / "Interface" / "AddOns"
        addons.mkdir(parents=True)

        def download(url, destination):
            shutil.copyfile(self.root / ".out/dist" / url.rsplit("/", 1)[-1], destination)

        with patch.object(bootstrap, "download", side_effect=download), contextlib.redirect_stdout(io.StringIO()):
            installed = bootstrap.install(addons)
            # Replacing an existing pair must clean up each suffixed TOC only once.
            self.assertEqual(installed, bootstrap.install(addons))
        for toc in (primary.name, alias.name):
            self.assertEqual((stage / toc).read_bytes(), (installed / toc).read_bytes())
            self.assert_success(self.run_lua("tools/distribution/fixtures/forever-read.lua", str(installed), toc))

        # A combined stage can contain mutually exclusive providers sharing module names.
        # Each parity observation must still load a fresh sandbox for that file's flavor.
        both = self.temp / "combined corrections"
        for folder in ("Era", "Forever"):
            shutil.copytree(self.root / "src/corrections" / folder, both / "src/corrections" / folder)
        self.assert_success(self.run_lua("tools/distribution/strip-static.lua", str(both), "--quiet"))
        for folder in ("Era", "Forever"):
            self.assertTrue(any(b"Static body stripped at package time" in path.read_bytes()
                                for path in (both / "src/corrections" / folder).glob("*.lua")))


if __name__ == "__main__":
    unittest.main()
