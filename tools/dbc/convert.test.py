"""Conversion policy and output ownership tests; all filesystem writes use fixtures."""
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

from convert import ConvertPoints, lua_value, round_coordinate
from coordinates import Transform
from files import MANIFEST, TOOL, digest, install_outputs
import files
from rewrite import Coordinate, rewrite

ROOT = Path(__file__).resolve().parents[2]
FIXTURES = Path(__file__).with_name("fixtures")


def outputs_with_manifest(values):
    outputs = {name: value.encode() for name, value in values.items()}
    report = {"tool": TOOL, "format": 1,
              "files": {name: {"output_sha256": digest(value)} for name, value in outputs.items()}}
    outputs[MANIFEST] = json.dumps(report, sort_keys=True).encode()
    return outputs


class CoordinatePolicyTests(unittest.TestCase):
    def test_chief_hawkwind_is_written_at_43_89_76_66(self):
        # Mulgore bounds, Era 1.15.9.69722 -> Forever 1.60.1.69893.
        convert = ConvertPoints({215: Transform(
            0.8348002068275978, 7.007453108736848,
            0.8349418225477033, 13.15387327724201,
        )})
        source = (FIXTURES / "validation-npc.lua").read_text()
        result, count = rewrite(source, entity="Npc", raw=True, zone_ids={}, transform=convert)
        self.assertEqual(count, 1)
        self.assertIn('{[215]={{43.89,76.66,42}}}', result)
        self.assertIn('"Chief Hawkwind"', result)

    def test_rounding_is_half_away_from_zero_without_touching_preserved_coordinates(self):
        self.assertEqual(round_coordinate(1.125), 1.13)
        self.assertEqual(round_coordinate(-1.125), -1.13)
        convert = ConvertPoints({12: Transform(1, 0, 1, 0)})
        self.assertEqual(convert(Coordinate(12, 44.1234, 76.5678, 1, "spawns", 1)), (44.1234, 76.5678))
        self.assertEqual(convert(Coordinate(10089, 44.1234, 76.5678, 2, "spawns", 1)), (44.1234, 76.5678))

    def test_rounding_does_not_hide_out_of_bounds_or_create_instance_sentinels(self):
        convert = ConvertPoints({44: Transform(1, -0.001, 1, 0)})
        self.assertEqual(convert(Coordinate(44, 0, 0, 1, "spawns", 1)), (0, 0))
        self.assertEqual(convert.out_of_bounds[0]["target"], [-0.001, 0])
        self.assertEqual(convert.counts["out_of_bounds"], 1)
        sentinel = ConvertPoints({44: Transform(1, -1.004, 1, 0)})
        with self.assertRaisesRegex(ValueError, "rounding would create an instance sentinel"):
            sentinel(Coordinate(44, 0, 20, 1, "spawns", 1))

    def test_changed_identity_unmapped_and_sentinel_points_have_separate_counts(self):
        convert = ConvertPoints({215: Transform(0.5, 25, 0.5, 50), 12: Transform(1, 0, 1, 0)})
        self.assertEqual(convert(Coordinate(215, 0, 0, 1, "spawns", 2981)), (25, 50))
        self.assertEqual(convert(Coordinate(12, 20, 30, 2, "spawns", 1)), (20, 30))
        self.assertEqual(convert(Coordinate(10089, 29, 89, 3, "spawns", None)), (29, 89))
        self.assertEqual(convert(Coordinate(99999, -1, -1, 4, "spawns", None)), (-1, -1))
        self.assertEqual(dict(convert.counts), {"converted": 1, "unchanged": 1, "unmapped": 1, "instance_sentinels": 1})
        self.assertEqual(convert.unmapped["10089"]["samples"][0]["line"], 3)
        with self.assertRaisesRegex(ValueError, "partial instance sentinel"):
            convert(Coordinate(215, -1, 20, 5, "spawns", None))

    def test_out_of_bounds_are_reported_not_clamped(self):
        convert = ConvertPoints({44: Transform(1, -5, 1, 0)})
        self.assertEqual(convert(Coordinate(44, 0, 0, 1, "waypoints", 1)), (-5, 0))
        self.assertEqual(convert.counts["out_of_bounds"], 1)
        self.assertEqual(convert.out_of_bounds[0]["target"], [-5, 0])

    def test_validation_plan_preserves_boolean_and_windows_path_strings(self):
        self.assertEqual(lua_value(True), "true")
        self.assertEqual(lua_value("C:\\Addon Folder\\\n"), '"C:\\\\Addon Folder\\\\\\010"')
        self.assertEqual(lua_value({215: {"scale_x": 0.5}}), '{[215]={["scale_x"]=0.5}}')


class OutputInstallationTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.npc = "data/Forever/foreverNpcDB.lua"
        self.fixes = "src/corrections/Forever/legacy/classicNPCFixes.lua"

    def test_repeat_generation_is_noop_and_updates_only_owned_files(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        self.assertEqual(len(install_outputs(self.root, first)), 3)
        self.assertEqual(install_outputs(self.root, first), [])
        second = outputs_with_manifest({self.npc: "new NPC", self.fixes: "old fixes"})
        self.assertEqual(install_outputs(self.root, second), [self.npc, MANIFEST])
        self.assertEqual((self.root / self.fixes).read_text(), "old fixes")

    def test_hand_edited_output_blocks_the_entire_install(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        install_outputs(self.root, first)
        (self.root / self.fixes).write_text("David's correction")
        second = outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"})
        with self.assertRaisesRegex(ValueError, "hand-edited"):
            install_outputs(self.root, second)
        self.assertEqual((self.root / self.npc).read_bytes(), first[self.npc])
        self.assertEqual((self.root / MANIFEST).read_bytes(), first[MANIFEST])
        self.assertEqual((self.root / self.fixes).read_text(), "David's correction")

    def test_existing_file_without_provenance_is_not_overwritten(self):
        (self.root / self.npc).parent.mkdir(parents=True)
        (self.root / self.npc).write_text("existing")
        with self.assertRaisesRegex(ValueError, "unowned"):
            install_outputs(self.root, outputs_with_manifest({self.npc: "new"}))
        self.assertEqual((self.root / self.npc).read_text(), "existing")

    def test_symlinked_forever_directory_cannot_write_into_era(self):
        era = self.root / "data/Classic"
        era.mkdir(parents=True)
        (era / "foreverNpcDB.lua").write_text("must not change")
        try:
            (self.root / "data/Forever").symlink_to(era, target_is_directory=True)
        except OSError:
            self.skipTest("Creating symlinks is not permitted on this platform")
        with self.assertRaisesRegex(ValueError, "symlinked"):
            install_outputs(self.root, outputs_with_manifest({self.npc: "new"}))
        self.assertEqual((era / "foreverNpcDB.lua").read_text(), "must not change")

    def test_mid_install_error_restores_previous_outputs_and_manifest(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        install_outputs(self.root, first)
        real_replace = files.os.replace
        calls = []

        def fail_second_replace(source, target):
            calls.append(target)
            if len(calls) == 2:
                raise OSError("fixture install failure")
            return real_replace(source, target)

        with patch.object(files.os, "replace", side_effect=fail_second_replace):
            with self.assertRaisesRegex(OSError, "fixture install failure"):
                install_outputs(self.root, outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"}))
        for name, expected in first.items():
            self.assertEqual((self.root / name).read_bytes(), expected)
        self.assertEqual(list(self.root.glob(".forever-conversion-*")), [])

    def test_rollback_preserves_concurrent_edits_and_recovery_backups(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        install_outputs(self.root, first)
        real_replace = files.os.replace
        calls = []

        def concurrent_edit_then_fail(source, target):
            calls.append(target)
            if len(calls) == 2:
                (self.root / self.npc).write_text("concurrent manual edit")
                raise OSError("fixture failure")
            return real_replace(source, target)

        with patch.object(files.os, "replace", side_effect=concurrent_edit_then_fail):
            with self.assertRaisesRegex(RuntimeError, "Rollback incomplete"):
                install_outputs(self.root, outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"}))
        self.assertEqual((self.root / self.npc).read_text(), "concurrent manual edit")
        self.assertEqual((self.root / self.fixes).read_text(), "old fixes")
        recovery, = self.root.glob(".forever-conversion-*")
        self.assertEqual((recovery / "0.old").read_text(), "old NPC")
        self.assertEqual(json.loads((recovery / "recovery.json").read_text())["0"]["destination"], self.npc)

    def test_cancellation_rolls_back_installation(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        install_outputs(self.root, first)
        real_replace = files.os.replace
        calls = []

        def cancel_second_replace(source, target):
            calls.append(target)
            if len(calls) == 2:
                raise KeyboardInterrupt
            return real_replace(source, target)

        with patch.object(files.os, "replace", side_effect=cancel_second_replace), self.assertRaises(KeyboardInterrupt):
            install_outputs(self.root, outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"}))
        for name, expected in first.items():
            self.assertEqual((self.root / name).read_bytes(), expected)

    def test_cancellation_immediately_after_replace_restores_published_file(self):
        first = outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"})
        install_outputs(self.root, first)
        real_replace = files.os.replace
        calls = []

        def cancel_after_first_replace(source, target):
            real_replace(source, target)
            calls.append(target)
            if len(calls) == 1:
                raise KeyboardInterrupt

        with patch.object(files.os, "replace", side_effect=cancel_after_first_replace), self.assertRaises(KeyboardInterrupt):
            install_outputs(self.root, outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"}))
        for name, expected in first.items():
            self.assertEqual((self.root / name).read_bytes(), expected)
        self.assertEqual(list(self.root.glob(".forever-conversion-*")), [])

    def test_second_cancellation_during_rollback_keeps_backups(self):
        install_outputs(self.root, outputs_with_manifest({self.npc: "old NPC", self.fixes: "old fixes"}))
        real_replace = files.os.replace
        calls = []

        def cancel_install_and_rollback(source, target):
            calls.append(target)
            if len(calls) == 1:
                real_replace(source, target)
            raise KeyboardInterrupt

        with patch.object(files.os, "replace", side_effect=cancel_install_and_rollback), self.assertRaises(KeyboardInterrupt):
            install_outputs(self.root, outputs_with_manifest({self.npc: "new NPC", self.fixes: "new fixes"}))
        recovery, = self.root.glob(".forever-conversion-*")
        self.assertEqual((self.root / self.npc).read_text(), "new NPC")
        self.assertEqual((recovery / "0.old").read_text(), "old NPC")


class SemanticValidationTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which("lua5.1"), "Lua 5.1 required for semantic validation")
    def test_validator_accepts_transformed_copy_and_rejects_coordinate_phase_and_name_corruption(self):
        source = FIXTURES / "validation-npc.lua"
        converter = ConvertPoints({215: Transform(0.513, 25.0001, 0.517, 50.0001)})
        converted, _ = rewrite(source.read_text(), entity="Npc", raw=True, zone_ids={}, transform=converter)
        self.assertIn('{47.66,89.32,42}', converted)
        with tempfile.TemporaryDirectory() as temporary:
            directory = Path(temporary)
            output = directory / "npc.lua"
            plan = {"files": [{"source": str(source), "output": str(output), "entity": "Npc", "raw": True}],
                    "transforms": {215: {"scale_x": 0.513, "offset_x": 25.0001, "scale_y": 0.517, "offset_y": 50.0001}}}
            plan_path = directory / "plan.lua"
            plan_path.write_text("return " + lua_value(plan))
            command = [shutil.which("lua5.1"), "tools/dbc/validate.lua", str(plan_path)]
            output.write_text(converted)
            good = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
            self.assertEqual(good.returncode, 0, good.stdout + good.stderr)
            for before, after in (("47.66", "47.67"), (",42", ",43"), ("Chief Hawkwind", "Wrong NPC")):
                with self.subTest(corruption=before):
                    self.assertIn(before, converted)
                    output.write_text(converted.replace(before, after))
                    bad = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
                    self.assertNotEqual(bad.returncode, 0, "validator accepted corrupted " + before)


@unittest.skipIf(os.name == "nt", "POSIX SIGTERM cleanup test")
class CancellationTests(unittest.TestCase):
    def run_cancelled(self, phase, root):
        process = subprocess.Popen([sys.executable, str(FIXTURES / "cancel.py"), phase, str(root)],
                                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
                                   start_new_session=True)
        try:
            ready = root / "ready.json"
            deadline = time.monotonic() + 10
            while not ready.exists() and process.poll() is None and time.monotonic() < deadline:
                time.sleep(0.02)
            self.assertTrue(ready.exists(), "fixture did not reach cancellation boundary")
            info = json.loads(ready.read_text())
            process.terminate()
            stdout, stderr = process.communicate(timeout=8)
            self.assertEqual(process.returncode, 130, stdout + stderr)
            return info
        finally:
            if process.poll() is None:
                process.kill()
                process.wait()
            try:
                os.killpg(process.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            process.stdout.close()
            process.stderr.close()

    def test_cancelled_validation_reaps_child_and_removes_temporary_files(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "tools/dbc").mkdir(parents=True)
            shutil.copyfile(FIXTURES / "validation-child.py", root / "tools/dbc/validate.lua")
            info = self.run_cancelled("validation", root)
            self.assertFalse(Path(info["temporary"]).exists())
            with self.assertRaises(ProcessLookupError):
                os.kill(info["pid"], 0)

    def test_cancelled_download_removes_partial_cache(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            self.run_cancelled("download", root)
            self.assertFalse((root / "cache/dbc-source.db").exists())
            self.assertEqual(list((root / "cache").glob(".dbc-download-*")), [])


if __name__ == "__main__":
    unittest.main()
