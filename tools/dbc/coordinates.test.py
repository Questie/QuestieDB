from dataclasses import asdict
import math
from pathlib import Path
import sqlite3
import tempfile
import unittest

from maps import ASSIGNMENT_FIELDS, build_report, convert_points
from coordinates import Bounds, Transform, compare_maps, derive_transform
from source import read_table


def assignment(**changes):
    row = {
        "ID": 7, "UiMapID": 1412, "MapID": 1, "AreaID": 215, "OrderIndex": 0,
        "WMODoodadPlacementID": 0, "WMOGroupID": 0,
        "UiMin_0": 0.0, "UiMin_1": 0.0, "UiMax_0": 1.0, "UiMax_1": 1.0,
        "Region_0": 200.0, "Region_1": 0.0, "Region_2": -1000000,
        "Region_3": 300.0, "Region_4": 200.0, "Region_5": 1000000,
    }
    return {**row, **changes}


class TransformTests(unittest.TestCase):
    def test_world_axis_orientation_and_percentage_offsets(self):
        old = assignment()
        new = assignment(Region_0=200.0, Region_1=-100.0, Region_3=400.0, Region_4=300.0)
        transform, _, _ = derive_transform(old, new)
        self.assertEqual(asdict(transform), {"scale_x": 0.5, "offset_x": 25.0, "scale_y": 0.5, "offset_y": 50.0})
        self.assertEqual(transform.apply(0, 0), (25, 50))
        self.assertEqual(transform.apply(100, 100), (75, 100))
        reverse, _, _ = derive_transform(new, old)
        restored_x, restored_y = reverse.apply(*transform.apply(44.18, 76.06))
        self.assertAlmostEqual(restored_x, 44.18, places=12)
        self.assertAlmostEqual(restored_y, 76.06, places=12)

    def test_mulgore_bounds_predict_chief_hawkwinds_observed_forever_position(self):
        # DBC snapshots 1.15.9.69722 and 1.60.1.69893, assignment 46722.
        old = assignment(Region_0=-3697.9165039062, Region_1=-3089.5832519531,
                         Region_3=-272.91665649414, Region_4=2047.9166259766)
        new = assignment(Region_0=-3835.416015625, Region_1=-3675.0,
                         Region_3=266.666015625, Region_4=2479.1669921875)
        transform, _, _ = derive_transform(old, new)
        x, y = transform.apply(44.18, 76.06)
        self.assertAlmostEqual(x, 43.8889, places=4)
        self.assertAlmostEqual(y, 76.6595, places=4)
        self.assertEqual((round(x, 1), round(y, 1)), (43.9, 76.7))

    def test_identity_and_instance_sentinels(self):
        transform, _, _ = derive_transform(assignment(), assignment())
        self.assertEqual(transform.apply(44.18, 76.06), (44.18, 76.06))
        self.assertEqual(Transform(0.5, 25, 0.5, 50).apply(-1, -1), (-1, -1))
        with self.assertRaisesRegex(ValueError, "Partial instance sentinel"):
            transform.apply(-1, 30)
        with self.assertRaisesRegex(ValueError, "finite"):
            transform.apply(math.nan, 30)

    def test_changed_identity_or_conditional_geometry_is_not_guessed(self):
        cases = [
            ({"MapID": 0}, "MapID changed"),
            ({"AreaID": 216}, "AreaID changed"),
            ({"UiMapID": 1413}, "UiMapID changed"),
            ({"OrderIndex": 1}, "nonprimary"),
            ({"WMOGroupID": 5}, "WMO-restricted"),
            ({"WMODoodadPlacementID": 5}, "WMO-restricted"),
            ({"UiMin_0": 0.2}, "partial UI"),
            ({"Region_2": 0}, "altitude-restricted"),
            ({"Region_4": 0}, "degenerate"),
            ({"Region_4": math.inf}, "nonfinite"),
            ({"uninterpreted_fields": {"UnknownSelector": 2}}, "uninterpreted"),
        ]
        for changes, message in cases:
            with self.subTest(changes=changes), self.assertRaisesRegex(ValueError, message):
                derive_transform(assignment(), assignment(**changes))
        with self.assertRaisesRegex(ValueError, "no explicit zone"):
            Bounds.from_assignment(assignment(AreaID=0))

    def test_ambiguous_maps_and_added_maps_are_reported_not_matched_by_name(self):
        old = [assignment(), assignment(ID=8)]
        new = [assignment(), assignment(ID=9, UiMapID=2665)]
        report = compare_maps(old, new, {1412: "Mulgore"}, {1412: "Mulgore", 2665: "Mulgore"})
        self.assertEqual(report["transforms"], [])
        self.assertIn("multiple assignments", report["unsupported"][0]["reason"])
        self.assertEqual(report["added_maps"][0]["ui_map_id"], 2665)
        self.assertEqual(report, compare_maps(old[::-1], new[::-1], {1412: "Mulgore"}, {1412: "Mulgore", 2665: "Mulgore"}))
        with self.assertRaisesRegex(ValueError, "no matched source"):
            convert_points(report, 2665, [[50, 50]])

    def test_out_of_bounds_coordinates_are_exposed_without_clamping(self):
        report = compare_maps([assignment()], [assignment(Region_4=100, Region_1=-100)],
                              {1412: "Mulgore"}, {1412: "Mulgore"})
        point = convert_points(report, 1412, [[0, 0]])[0]
        self.assertEqual(point["target"], [-50.0, 0.0])
        self.assertTrue(point["target_out_of_bounds"])
        self.assertFalse(point["source_out_of_bounds"])
        sentinel = convert_points(report, 1412, [[-1, -1]])[0]
        self.assertFalse(sentinel["target_out_of_bounds"])
        self.assertTrue(sentinel["instance_sentinel"])


class SnapshotTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / "source.db"
        self.old, self.new = "1.15.9.69722", "1.60.1.69893"
        self.conn = sqlite3.connect(self.path)
        self.conn.row_factory = sqlite3.Row
        self.addCleanup(self.conn.close)
        self.conn.executescript('''
            CREATE TABLE _build (build);
            INSERT INTO _build VALUES ('1.15.9.69722'), ('1.60.1.69893');
            CREATE TABLE _table_build (table_name,build,locale,status,error);
            INSERT INTO _table_build VALUES ('ui_map','1.60.1.69893','','ok','');
            INSERT INTO _table_build VALUES ('ui_map_assignment','1.60.1.69893','','ok','');
            CREATE TABLE ui_map (ID,Name_lang,_first_seen,_last_seen);
            INSERT INTO ui_map VALUES (1412,'Mulgore','1.15.9.69722','1.60.1.69893');
        ''')
        columns = list(ASSIGNMENT_FIELDS) + ["UnknownSelector", "_first_seen", "_last_seen"]
        self.conn.execute(f"CREATE TABLE ui_map_assignment ({','.join(columns)})")
        row = assignment()
        self.conn.execute(f"INSERT INTO ui_map_assignment VALUES ({','.join('?' for _ in columns)})",
                          [*row.values(), 0, self.old, self.new])
        self.conn.commit()

    def test_untracked_source_requires_consent_and_is_recorded(self):
        with self.assertRaisesRegex(ValueError, "untracked"):
            build_report(self.path, self.old, self.new)
        before = self.path.read_bytes()
        report = build_report(self.path, self.old, self.new, allow_untracked_source=True)
        self.assertEqual(report["source_tables"]["ui_map_assignment"]["coverage"], "untracked")
        self.assertEqual(report["target_tables"]["ui_map_assignment"]["coverage"], "ok")
        self.assertEqual(report["summary"]["unchanged_maps"], 1)
        self.assertEqual(self.path.read_bytes(), before)
        self.assertEqual(report, build_report(self.path, self.old, self.new, allow_untracked_source=True))

    def test_consent_never_bypasses_recorded_failure_or_untracked_target(self):
        self.conn.execute("INSERT INTO _table_build VALUES ('ui_map_assignment',?,'','failed','bad CSV')", (self.old,))
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "failed: bad CSV"):
            build_report(self.path, self.old, self.new, allow_untracked_source=True)
        self.conn.execute("DELETE FROM _table_build")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "1.60.1.69893: snapshot untracked"):
            build_report(self.path, self.old, self.new, allow_untracked_source=True)

    def test_nonzero_unknown_fields_block_conversion_but_remain_visible(self):
        self.conn.execute("UPDATE ui_map_assignment SET UnknownSelector=12")
        self.conn.commit()
        report = build_report(self.path, self.old, self.new, allow_untracked_source=True)
        self.assertEqual(report["transforms"], [])
        self.assertIn("UnknownSelector", report["unsupported"][0]["reason"])

    def test_nonfinite_geometry_is_rejected_even_with_ok_coverage(self):
        self.conn.execute("UPDATE ui_map_assignment SET Region_4=?", (math.inf,))
        with self.assertRaisesRegex(ValueError, "invalid Region_4"):
            read_table(self.conn, "ui_map_assignment", self.new, ASSIGNMENT_FIELDS)


if __name__ == "__main__":
    unittest.main()
