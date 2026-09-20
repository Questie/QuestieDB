"""Offline spatial fixtures; optional real snapshot acceptance uses FOREVER_DBC_DATABASE."""
from copy import deepcopy
import json
import os
import re
import shutil
from pathlib import Path
import sqlite3
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from spatial import InstancePresence, LegacyPoint, legacy_position, resolve_areas
import support
from support import build_candidate, projection_hash, write_candidate

BUILD = "1.60.1.69893"
ROOT = Path(__file__).resolve().parents[2]
LUA = os.environ.get("LUA") or shutil.which("lua5.1")


def area(area_id, parent=0, map_id=0, name="Fixture"):
    return {"ID": area_id, "AreaName_lang": name, "ParentAreaID": parent,
            "ContinentID": map_id, "Flags_0": 0}


def assignment(area_id=215, ui=1412, assignment_id=46722, **changes):
    return {"ID": assignment_id, "UiMapID": ui, "MapID": 0, "AreaID": area_id, "OrderIndex": 0,
            "WMODoodadPlacementID": 0, "WMOGroupID": 0,
            "UiMin_0": 0.0, "UiMin_1": 0.0, "UiMax_0": 1.0, "UiMax_1": 1.0,
            "Region_0": 0.0, "Region_1": 0.0, "Region_2": -1000000.0,
            "Region_3": 100.0, "Region_4": 100.0, "Region_5": 1000000.0, **changes}


WORLD_MAPS = [{"ID": 0, "MapName_lang": "Eastern Kingdoms", "AreaTableID": 0}]


class SpatialMeaningTests(unittest.TestCase):
    def test_parent_routing_does_not_establish_a_point_frame(self):
        lookup = resolve_areas([area(215), area(220, 215), area(222, 215)], WORLD_MAPS,
                               [assignment()], {1412: "Mulgore"})
        self.assertEqual({215: 1412, 220: 1412, 222: 1412},
                         {i: r.ui_map_id for i, r in lookup.resolved.items()})
        self.assertEqual((220, 215), lookup.resolved[220].parent_chain)
        self.assertEqual(46722, lookup.resolved[222].assignment_id)
        self.assertEqual({1412: 215}, lookup.reverse)
        point = legacy_position(220, 0, 0, "Npc:2981:spawns:220:1", phase=3)
        self.assertEqual(LegacyPoint(220, 0, 0, "Npc:2981:spawns:220:1", 3), point)
        self.assertIsNone(point.ui_map_id)
        self.assertEqual(0, lookup.areas[215].map_id)

    def test_highest_mapped_ancestor_wins_but_direct_routes_are_preserved(self):
        lookup = resolve_areas([area(1), area(2, 1), area(3, 2)], WORLD_MAPS,
                               [assignment(1, 101, 1), assignment(2, 102, 2)], {101: "Root", 102: "Child"})
        self.assertEqual(102, lookup.resolved[2].ui_map_id)
        self.assertEqual(101, lookup.resolved[3].ui_map_id)
        self.assertEqual((3, 2, 1), lookup.resolved[3].parent_chain)
        self.assertEqual({101: 1, 102: 2}, lookup.reverse)
        self.assertEqual([{"area_id": 2, "direct_ui_map_id": 102,
                           "parent_id": 1, "parent_ui_map_id": 101}], lookup.parent_routing_differences)

    def test_prince_and_object_instance_markers_are_not_geometry(self):
        prince = legacy_position(10022, -1, -1, "Npc:11486:Static:spawns:10022:1")
        safe = legacy_position(10032, -1, -1, "Object:142477:Static:spawns:10032:1")
        self.assertEqual(InstancePresence(10022, "Npc:11486:Static:spawns:10022:1"), prince)
        self.assertIsInstance(safe, InstancePresence)
        with self.assertRaisesRegex(ValueError, "Partial instance"):
            legacy_position(10022, -1, 50, "partial")
        with self.assertRaisesRegex(ValueError, "no coordinate frame"):
            legacy_position(10022, -1, -1, "sentinel", declared_ui_map=235)
        with self.assertRaisesRegex(ValueError, "UiMap 0"):
            legacy_position(215, 0, 0, "point", declared_ui_map=0)
        self.assertEqual(123.456789, legacy_position(215, 123.456789, 50, "outside").x)

    def test_unsupported_assignments_and_ambiguity_cannot_be_hidden_by_parent_fallback(self):
        cases = [({"WMOGroupID": 1}, "WMO-restricted"),
                 ({"UiMax_0": 0.5}, "partial UI"),
                 ({"Region_2": 0}, "altitude-restricted"),
                 ({"Region_4": 0}, "degenerate"),
                 ({"uninterpreted_fields": {"Selector": 1}}, "uninterpreted")]
        for changes, reason in cases:
            with self.subTest(reason=reason):
                lookup = resolve_areas([area(1), area(215, 1)], WORLD_MAPS,
                                       [assignment(1, 100, 1), assignment(**changes)], {100: "Root", 1412: "Mulgore"})
                self.assertEqual([215], lookup.unresolved)
                self.assertIn(reason, lookup.diagnostics[0]["reason"])
        ambiguous = resolve_areas([area(1), area(215, 1)], WORLD_MAPS,
                                  [assignment(1, 100, 1), assignment(), assignment(ui=2665, assignment_id=2)],
                                  {100: "Root", 1412: "Same name", 2665: "Same name"})
        self.assertEqual([215], ambiguous.unresolved)
        self.assertEqual({100: 1}, ambiguous.reverse)

    def test_broken_references_and_parent_cycles_fail(self):
        cases = [([area(215, 99)], [assignment()], "missing parent"),
                 ([area(215, 220), area(220, 215)], [assignment()], "parent cycle"),
                 ([area(215)], [assignment(ui=999)], "missing UiMap"),
                 ([area(215)], [assignment(area_id=999)], "missing AreaTable"),
                 ([area(215)], [assignment(MapID=999)], "missing Map")]
        for areas, assignments, message in cases:
            with self.subTest(message=message), self.assertRaisesRegex(ValueError, message):
                resolve_areas(areas, WORLD_MAPS, assignments, {1412: "Mulgore"})

    def test_missing_world_map_is_visible_without_fabricating_it(self):
        lookup = resolve_areas([area(215), area(999, map_id=17)], WORLD_MAPS,
                               [assignment()], {1412: "Mulgore"})
        self.assertEqual([999], lookup.unresolved)
        self.assertEqual([{"kind": "area_without_world_map", "area_id": 999, "map_id": 17}], lookup.diagnostics)


class CandidateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.database = self.root / "source.db"
        self.exceptions = self.root / "exceptions.json"
        self.output = self.root / ".out/forever-support/review"
        self.tables = {
            "area_table": [area(215), area(220, 215), area(2257)],
            "map": WORLD_MAPS,
            "ui_map": [{"ID": 1412, "Name_lang": "Mulgore"}, {"ID": 1414, "Name_lang": "Kalimdor"}],
            "ui_map_assignment": [assignment(), assignment(0, 1414, 46725)],
        }
        self.conn = sqlite3.connect(self.database)
        self.addCleanup(self.conn.close)
        self.conn.executescript("CREATE TABLE _build(build); CREATE TABLE _table_build(table_name,build,locale,status,error);")
        self.conn.execute("INSERT INTO _build VALUES (?)", (BUILD,))
        for name, rows in self.tables.items():
            fields = list(rows[0])
            self.conn.execute(f"CREATE TABLE {name} ({','.join(fields)},_first_seen,_last_seen)")
            self.conn.execute("INSERT INTO _table_build VALUES (?,?,'','ok','')", (name, BUILD))
            for row in rows:
                self.conn.execute(f"INSERT INTO {name} VALUES ({','.join('?' for _ in range(len(fields)+2))})",
                                  [row[f] for f in fields] + [BUILD, BUILD])
        self.conn.commit()
        self.policy = {"format": 1, "flavor": "Forever", "build": BUILD,
                       "source_projections": {name: projection_hash([{f: row[f] for f in fields} for row in self.tables[name]])
                                              for name, fields in support.PROJECTION_FIELDS.items()},
                       "entries": [
                           self.exception("suppress-tram", "suppression", 2257, 0, "real"),
                           self.exception("kalimdor", "native_alias", 10073, 1414, "synthetic"),
                           self.exception("prince", "retired_map_compatibility", 10022, 235, "synthetic"),
                       ]}
        self.save_policy()
        self.addCleanup(patch.stopall)
        patch.object(support, "ROOT", self.root).start()
        patch.object(support, "CANDIDATES", self.root / ".out/forever-support").start()

    def exception(self, identity, kind, area_id, ui_map, area_kind):
        return {"id": identity, "kind": kind, "area_id": area_id, "ui_map_id": ui_map,
                "area_kind": area_kind, "reason": "Fixture policy", "evidence": "independent fixture",
                "retire_when": "Review fixture policy"}

    def save_policy(self):
        self.exceptions.write_text(json.dumps(self.policy))

    def build(self):
        return build_candidate(self.database, BUILD, self.exceptions)

    def test_candidate_is_deterministic_and_keeps_native_inventory_separate(self):
        before = self.database.read_bytes()
        candidate = self.build()
        self.assertEqual(candidate.outputs, self.build().outputs)
        self.assertEqual(before, self.database.read_bytes())
        self.assertEqual({"direct": 1, "inherited": 1, "resolved": 2, "canonical_reverse": 1,
                          "unresolved_real_areas": 1, "compatibility_pairs": 1}, candidate.report["summary"])
        self.assertEqual([2257], candidate.report["unresolved_real_areas"])
        self.assertNotIn(235, [r["id"] for r in candidate.report["native_ui_maps"]])
        self.assertIn(b"[10022] = 235", candidate.outputs["Zones/areaIdToUiMapId.lua"])
        self.assertEqual(3, len(write_candidate(self.output, candidate)))
        self.assertEqual([], write_candidate(self.output, candidate))

    @unittest.skipUnless(LUA, "Lua 5.1 required to load rendered candidates")
    def test_source_names_cannot_close_the_deferred_lua_string(self):
        name = "Name ]]]\nwith ]] delimiters"
        self.conn.execute("UPDATE area_table SET AreaName_lang=? WHERE ID=215", (name,))
        self.conn.execute("UPDATE ui_map SET Name_lang=? WHERE ID=1412", (name,))
        self.conn.commit()
        self.tables["area_table"][0]["AreaName_lang"] = name
        self.tables["ui_map"][0]["Name_lang"] = name
        for table in ("area_table", "ui_map"):
            fields = support.PROJECTION_FIELDS[table]
            self.policy["source_projections"][table] = projection_hash(
                [{f: row[f] for f in fields} for row in self.tables[table]])
        self.save_policy()
        write_candidate(self.output, self.build())
        result = subprocess.run([LUA, str(Path(__file__).with_name("fixtures") / "support-compare.lua"),
                                 str(self.output / "Zones"), str(self.output / "Zones")],
                                capture_output=True, text=True, timeout=10)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)

    def test_edited_candidates_and_unowned_files_are_protected(self):
        candidate = self.build()
        write_candidate(self.output, candidate)
        output = self.output / "Zones/areaIdToUiMapId.lua"
        output.write_text("manual review edit")
        with self.assertRaisesRegex(ValueError, "hand-edited or unowned"):
            write_candidate(self.output, candidate)
        self.assertEqual("manual review edit", output.read_text())
        report = self.output / "report.json"
        report.write_text('{"format":1,"tool":"another tool"}')
        with self.assertRaisesRegex(ValueError, "Unrecognized"):
            write_candidate(self.output, candidate)

    def test_install_failure_rolls_back_the_candidate_set(self):
        candidate = self.build()
        write_candidate(self.output, candidate)
        changed = deepcopy(candidate)
        changed.outputs["Zones/areaIdToUiMapId.lua"] += b"-- next\n"
        changed.outputs["Zones/uiMapIdToAreaId.lua"] += b"-- next\n"
        import files
        original_replace = files.os.replace
        calls = []

        def fail_second(source, target):
            calls.append(target)
            if len(calls) == 2:
                raise OSError("fixture install failure")
            original_replace(source, target)

        with patch.object(files.os, "replace", side_effect=fail_second), self.assertRaisesRegex(OSError, "fixture"):
            write_candidate(self.output, changed)
        for name, payload in candidate.outputs.items():
            self.assertEqual(payload, (self.output / name).read_bytes())

    def test_active_support_traversal_and_symlink_destinations_are_rejected(self):
        candidate = self.build()
        for path in (self.root / "support/Forever", self.root / ".out/forever-support/../../support"):
            with self.subTest(path=path), self.assertRaisesRegex(ValueError, "Output must"):
                write_candidate(path, candidate)
        target = self.root / "protected"
        target.mkdir()
        self.output.parent.mkdir(parents=True)
        try:
            self.output.symlink_to(target, target_is_directory=True)
        except OSError:
            self.skipTest("symlink creation unavailable")
        with self.assertRaisesRegex(ValueError, "symlink"):
            write_candidate(self.output, candidate)
        self.assertEqual([], list(target.iterdir()))

    def test_failed_missing_or_corrupt_source_cannot_install_outputs(self):
        self.conn.execute("UPDATE _table_build SET status='failed',error='bad CSV' WHERE table_name='area_table'")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "failed: bad CSV"):
            self.build()
        self.conn.execute("DELETE FROM _table_build WHERE table_name='area_table'")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "untracked"):
            self.build()
        with self.assertRaises(sqlite3.OperationalError):
            build_candidate(self.root / "missing.db", BUILD, self.exceptions)
        self.assertFalse((self.root / "missing.db").exists())
        self.assertFalse(self.output.exists())

    def test_changed_projection_build_or_required_fields_fail(self):
        with self.assertRaisesRegex(ValueError, "does not apply"):
            build_candidate(self.database, "1.60.1.69913", self.exceptions)
        self.conn.execute("UPDATE area_table SET AreaName_lang='changed'")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "projections differ"):
            self.build()
        self.conn.execute("UPDATE ui_map_assignment SET Region_4=NULL")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "invalid Region_4"):
            self.build()

    def test_exception_collisions_and_missing_evidence_fail(self):
        invalid = [({"area_id": 215, "area_kind": "real"}, "conflicts with an existing"),
                   ({"ui_map_id": 1412}, "must not claim native"),
                   ({"area_kind": "real"}, "identity changed"),
                   ({"evidence": ""}, "evidence"),
                   ({"kind": "guess"}, "Unknown exception kind")]
        original = deepcopy(self.policy)
        for changes, message in invalid:
            with self.subTest(changes=changes):
                self.policy = deepcopy(original)
                self.policy["entries"][2].update(changes)
                self.save_policy()
                with self.assertRaisesRegex(ValueError, message):
                    self.build()


@unittest.skipUnless(os.environ.get("FOREVER_DBC_DATABASE"), "set FOREVER_DBC_DATABASE for pinned snapshot acceptance")
class ReviewedSnapshotTests(unittest.TestCase):
    def test_exact_current_lua_tables_derivations_and_unresolved_inventory(self):
        candidate = build_candidate(Path(os.environ["FOREVER_DBC_DATABASE"]), BUILD)
        provenance = json.loads((ROOT / "support/Forever/provenance.json").read_text())["local_map_refresh"]
        report = candidate.report
        self.assertEqual(provenance["manual_completion"]["unresolved_real_areas"], report["unresolved_real_areas"])
        self.assertEqual([1463, 1464, 2665], report["unresolved_ui_maps"])
        routes = {r["area_id"]: r for r in report["routes"]}
        self.assertEqual((1412, 215, 46722), (routes[220]["ui_map_id"], routes[220]["ancestor_id"], routes[220]["assignment_id"]))
        self.assertEqual(215, routes[222]["ancestor_id"])
        self.assertEqual(2652, routes[2657]["ui_map_id"])
        self.assertEqual(2482, routes[616]["ui_map_id"])
        self.assertEqual([], report["parent_routing_differences"])
        self.assertEqual(24, sum(r["kind"] == "area_without_world_map" for r in report["diagnostics"]))
        self.assertEqual(1064, len(routes))
        names = {row["ID"]: row["AreaName_lang"] for row in report["areas"]}
        authored = (ROOT / "support/Forever/Zones/areaIdToUiMapId.lua").read_text()
        comments = {int(key): comment for key, comment in re.findall(r"^    \[(\d+)\] = \d+, -- (.*)$", authored, re.M)}
        for area_id, route in routes.items():
            expected = names[area_id]
            if route["ancestor_id"] != area_id:
                expected += " -> " + names[route["ancestor_id"]]
            self.assertEqual(expected, comments[area_id], f"area {area_id} derivation")
        self.assertEqual(candidate.outputs, build_candidate(Path(os.environ["FOREVER_DBC_DATABASE"]), BUILD).outputs)
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            for name, data in candidate.outputs.items():
                (output / name).parent.mkdir(parents=True, exist_ok=True)
                (output / name).write_bytes(data)
            self.assertIsNotNone(LUA, "Lua 5.1 is required for real snapshot acceptance")
            lua = LUA
            result = subprocess.run([lua, str(Path(__file__).with_name("fixtures") / "support-compare.lua"),
                                     str(output / "Zones"), str(ROOT / "support/Forever/Zones")],
                                    capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            self.assertIn("All four mapping tables match", result.stdout)
            # Self-proof: correct counts cannot hide a wrong value.
            path = output / "Zones/areaIdToUiMapId.lua"
            path.write_bytes(path.read_bytes().replace(b"[220] = 1412", b"[220] = 9999"))
            failed = subprocess.run([lua, str(Path(__file__).with_name("fixtures") / "support-compare.lua"),
                                     str(output / "Zones"), str(ROOT / "support/Forever/Zones")],
                                    capture_output=True, text=True, timeout=10)
            self.assertNotEqual(0, failed.returncode)
            self.assertIn("220", failed.stderr)


if __name__ == "__main__":
    unittest.main()
