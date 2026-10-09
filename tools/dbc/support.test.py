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
from parents import extend_parents
from instances import extend_instances
from rewrite import read_zone_ids
import support
from support import build_candidate, write_candidate
from support_lua import read_instance_table, read_support_tables

BUILD = "1.60.1.69893"
ROOT = Path(__file__).resolve().parents[2]
LUA = os.environ.get("LUA") or shutil.which("lua5.1")
FIXTURES = Path(__file__).with_name("fixtures")
PARENT_SCOPE = {"id": "fixture-zone-parents", "parent_area_ids": [215],
                "reason": "Reviewed child relationships", "evidence": "Independent fixture"}


def area(area_id, parent=0, map_id=0, name="Fixture"):
    return {"ID": area_id, "AreaName_lang": name, "ParentAreaID": parent,
            "ContinentID": map_id, "Flags_0": 0}


def assignment(area_id=215, ui=1412, assignment_id=46722, **changes):
    return {"ID": assignment_id, "UiMapID": ui, "MapID": 0, "AreaID": area_id, "OrderIndex": 0,
            "WMODoodadPlacementID": 0, "WMOGroupID": 0,
            "UiMin_0": 0.0, "UiMin_1": 0.0, "UiMax_0": 1.0, "UiMax_1": 1.0,
            "Region_0": 0.0, "Region_1": 0.0, "Region_2": -1000000.0,
            "Region_3": 100.0, "Region_4": 100.0, "Region_5": 1000000.0, **changes}


WORLD_MAPS = [{"ID": 0, "MapName_lang": "Eastern Kingdoms", "AreaTableID": 0, "InstanceType": 0}]


def world_map(map_id, explicit=0, instance_type=1):
    return {"ID": map_id, "MapName_lang": "Fixture map", "AreaTableID": explicit,
            "InstanceType": instance_type}


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

    def test_incomplete_parent_chains_on_absent_world_maps_stay_unresolved(self):
        areas = [area(215), area(17845, 16597, 2981), area(17846, 17845, 2981)]
        lookup = resolve_areas(areas, WORLD_MAPS, [assignment()], {1412: "Mulgore"})
        self.assertEqual([17845, 17846], lookup.unresolved)
        self.assertEqual({215}, set(lookup.resolved))
        self.assertEqual([
            {"kind": "missing_parent_without_world_map", "area_id": i,
             "parent_id": 16597, "map_id": 2981} for i in (17845, 17846)
        ], [row for row in lookup.diagnostics if row["kind"] == "missing_parent_without_world_map"])
        with self.assertRaisesRegex(ValueError, "missing parent 16597"):
            resolve_areas(areas, WORLD_MAPS + [world_map(2981)], [assignment()], {1412: "Mulgore"})
        with self.assertRaisesRegex(ValueError, "missing Map 2981"):
            resolve_areas(areas, WORLD_MAPS, [assignment(17845, MapID=2981)], {1412: "Mulgore"})


class ParentCandidateTests(unittest.TestCase):
    def setUp(self):
        self.source = (FIXTURES / "parent-support.lua").read_bytes()
        self.lookup = resolve_areas(
            [area(215), area(220, 215), area(221, 220), area(12), area(13, 12)], WORLD_MAPS,
            [assignment(), assignment(12, 1429, 2)], {1412: "Mulgore", 1429: "Elwynn"})

    def test_only_missing_direct_children_are_added_without_touching_authored_data(self):
        candidate, report = extend_parents(self.source, self.lookup, PARENT_SCOPE)
        self.assertEqual([{"area_id": 220, "parent_id": 215, "disposition": "addition"}], report["relationships"])
        self.assertIn(b"[220] = 215,", candidate)
        self.assertNotIn(b"[221]", candidate)
        self.assertNotIn(b"[13]", candidate)
        inserted = (b"\n    -- DBC direct children of reviewed Forever zones; see candidate report.json.\n"
                    b"    [220] = 215,\n")
        self.assertEqual(self.source, candidate.replace(inserted, b""))
        repeated, next_report = extend_parents(candidate, self.lookup, PARENT_SCOPE)
        self.assertEqual(candidate, repeated)
        self.assertEqual(0, next_report["added"])
        self.assertEqual(1, next_report["already_present"])

    def test_authored_override_wins_and_disagreements_stop_the_candidate(self):
        agreed = self.source.replace(b"[10022] = 2557,", b"[10022] = 2557,\n    [220] = 215,")
        candidate, report = extend_parents(agreed, self.lookup, PARENT_SCOPE)
        self.assertEqual(agreed, candidate)
        self.assertEqual(1, report["already_present"])
        corrected_by_override = agreed.replace(b"[444] = 555,", b"[444] = 555,\n    [220] = 12,")
        candidate, report = extend_parents(corrected_by_override, self.lookup, PARENT_SCOPE)
        self.assertEqual(corrected_by_override, candidate)
        self.assertEqual(1, report["already_present"])
        conflicting = agreed.replace(b"[220] = 215,", b"[220] = 12,")
        conflicting = conflicting.replace(b"[444] = 555,", b"[444] = 555,\n    [220] = 215,")
        with self.assertRaisesRegex(ValueError, "authored parent 12 conflicts with DBC 215"):
            extend_parents(conflicting, self.lookup, PARENT_SCOPE)

    def test_parent_scopes_must_select_reviewed_direct_maps(self):
        for roots in ([215, 215], [999], [220], [True], []):
            with self.subTest(roots=roots), self.assertRaisesRegex(ValueError, "Parent scope"):
                extend_parents(self.source, self.lookup, {**PARENT_SCOPE, "parent_area_ids": roots})

    def test_executable_or_duplicate_source_values_are_rejected(self):
        cases = [self.source + b"\nZoneDB.private.subZoneToParentZone = 'replaced'\n",
                 self.source.replace(b"[444] = 555", b"[444] = 500 + 55"),
                 self.source.replace(b"[444] = 555,", b"[444] = 555, [444] = 556,")]
        for source in cases:
            with self.subTest(source=source), self.assertRaises(ValueError):
                extend_parents(source, self.lookup, PARENT_SCOPE)

    @unittest.skipUnless(LUA, "Lua 5.1 required to load rendered candidates")
    def test_a_missing_trailing_comma_is_added_without_breaking_the_authored_comment(self):
        source = self.source.replace(b"[444] = 555,", b"[444] = 555")
        candidate, _ = extend_parents(source, self.lookup, PARENT_SCOPE)
        self.assertIn(b"[444] = 555, -- Preserve an unrelated authored relationship.", candidate)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "parents.lua"
            path.write_bytes(candidate)
            expected = Path(directory) / "expected.lua"
            expected.write_text("return {[220]=215}\n")
            result = subprocess.run([LUA, str(FIXTURES / "parents-compare.lua"), str(path),
                                     str(FIXTURES / "parent-support.lua"), str(expected)],
                                    capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)


class InstanceCandidateTests(unittest.TestCase):
    def setUp(self):
        self.source = (FIXTURES / "instance-support.lua").read_bytes()
        self.zones = read_zone_ids((FIXTURES / "zone-enum.lua").read_text())

    def test_no_ui_map_roots_explicit_priority_and_full_instance_parent_edges(self):
        maps = WORLD_MAPS + [world_map(33, 209), world_map(2998), world_map(2999),
                             world_map(44, 215), world_map(55, 700, 0)]
        areas = [area(215), area(220, 215), area(221, 220), area(209, map_id=33),
                 area(210, map_id=33), area(16732, map_id=2998), area(16877, 16732, 2998),
                 area(16878, 16877, 2998), area(16611, map_id=2999), area(16612, 16611, 2999),
                 area(600, map_id=44), area(601, 600, 44), area(700, map_id=55), area(701, 700, 55)]
        lookup = resolve_areas(areas, maps, [assignment()], {1412: "Mulgore"})
        output, links, report = extend_instances(self.source, self.zones, lookup, maps)
        self.assertEqual({33: 209, 2998: 16732, 2999: 16611, 44: 215, 55: 700}, links)
        self.assertNotIn(16732, lookup.resolved)
        records = {r["map_id"]: r for r in report["relationships"]}
        self.assertEqual("existing", records[33]["disposition"])
        self.assertEqual([209, 210], records[33]["root_area_ids"])
        self.assertEqual("explicit_area_table_id", records[33]["method"])
        self.assertEqual("unique_instance_root", records[2998]["method"])
        self.assertEqual(215, records[44]["area_id"])
        self.assertEqual("addition", records[55]["disposition"])
        self.assertEqual([{"map_id": 999, "area_id": 9000,
                           "disposition": "preserved_absent_map"}], report["preserved_absent_maps"])
        self.assertIn(b"[33] = ZoneDB.zoneIDs.SHADOWFANG_KEEP, -- Authored symbolic identity.", output)
        self.assertIn(b"[999] = 9000, -- Absent legacy Map and Area, preserved verbatim.", output)
        repeated, _, next_report = extend_instances(output, self.zones, lookup, maps)
        self.assertEqual(output, repeated)
        self.assertEqual(0, next_report["added"])

        parents, parent_report = extend_parents((FIXTURES / "parent-support.lua").read_bytes(),
                                                lookup, PARENT_SCOPE,
                                                instance_maps=frozenset({33, 44, 2998, 2999}))
        base, _ = read_support_tables(parents.decode(), "subZoneToParentZone")
        self.assertEqual({220: 215, 601: 600, 16612: 16611, 16877: 16732, 16878: 16877},
                         {r["area_id"]: r["parent_id"] for r in parent_report["relationships"]})
        self.assertEqual(16877, base.values[16878])
        self.assertNotIn(221, base.values)  # Outdoor grandchildren are still outside scope.
        self.assertNotIn(701, base.values)  # Explicit non-instance maps do not broaden parents.
        conflicting = parents.replace(b"[16878] = 16877", b"[16878] = 16732")
        with self.assertRaisesRegex(ValueError, "Area 16878: authored parent 16732 conflicts with DBC 16877"):
            extend_parents(conflicting, lookup, PARENT_SCOPE, instance_maps=frozenset({2998}))

    def test_ambiguous_missing_and_outdoor_roots_remain_evidence_not_guesses(self):
        maps = WORLD_MAPS + [world_map(33), world_map(101), world_map(102), world_map(103, 9999),
                             world_map(104, instance_type=0)]
        areas = [area(215), area(209, map_id=33), area(210, map_id=33),
                 area(1001, map_id=101), area(1002, map_id=101), area(1003, 1001, 101),
                 area(1004, map_id=104)]
        lookup = resolve_areas(areas, maps, [assignment()], {1412: "Mulgore"})
        output, links, report = extend_instances(self.source, self.zones, lookup, maps)
        self.assertEqual(self.source, output)
        self.assertEqual({33: 209}, links)  # Authored identity resolves ambiguous roots.
        records = {r["map_id"]: r for r in report["relationships"]}
        self.assertEqual("authored_resolution", records[33]["disposition"])
        self.assertEqual("multiple_instance_roots", records[101]["reason"])
        self.assertEqual([1001, 1002], records[101]["root_area_ids"])
        self.assertEqual("no_instance_root", records[102]["reason"])
        self.assertEqual("explicit_area_absent_from_snapshot", records[103]["reason"])
        self.assertEqual("excluded", records[104]["disposition"])
        self.assertEqual(3, report["unresolved"])
        _, parents = extend_parents((FIXTURES / "parent-support.lua").read_bytes(), lookup,
                                   PARENT_SCOPE, unresolved_instance_maps=frozenset({101, 102, 103}))
        self.assertEqual([{"area_id": 1003, "parent_id": 1001, "map_id": 101,
                           "reason": "unresolved_instance_identity"}], parents["unresolved"])

    def test_all_instance_fallback_types_and_explicit_link_conflicts(self):
        for instance_type in (1, 2, 3, 4):
            with self.subTest(instance_type=instance_type):
                maps = [world_map(33, instance_type=instance_type)]
                lookup = resolve_areas([area(209, map_id=33)], maps, [], {})
                _, links, _ = extend_instances(self.source, self.zones, lookup, maps)
                self.assertEqual({33: 209}, links)
        maps = [world_map(33, 210)]
        lookup = resolve_areas([area(209, map_id=33), area(210, map_id=33)], maps, [], {})
        with self.assertRaisesRegex(ValueError, "Map 33: authored instance area 209 conflicts with DBC area 210"):
            extend_instances(self.source, self.zones, lookup, maps)

    @unittest.skipUnless(LUA, "Lua 5.1 required to load rendered candidates")
    def test_source_preserving_insertions_and_missing_separator_load_with_symbolic_values(self):
        maps = WORLD_MAPS + [world_map(2998)]
        lookup = resolve_areas([area(215), area(16732, map_id=2998)], maps,
                               [assignment()], {1412: "Mulgore"})
        source = self.source.replace(b"[999] = 9000,", b"[999] = 9000")
        output, _, _ = extend_instances(source, self.zones, lookup, maps)
        block = (b"\n    -- DBC world Map identities; not an active-instance allowlist. See candidate report.json.\n"
                 b"    [2998] = 16732,\n")
        self.assertEqual(source, output.replace(block, b"").replace(b"[999] = 9000,", b"[999] = 9000"))
        self.assertIn(b"[999] = 9000, -- Absent legacy", output)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "instances.lua"
            path.write_bytes(output)
            expected = Path(directory) / "expected.lua"
            expected.write_text("return {[2998]=16732}\n")
            command = [LUA, str(FIXTURES / "instances-compare.lua"), str(path),
                       str(FIXTURES / "instance-support.lua"), str(FIXTURES / "zone-enum.lua"), str(expected)]
            result = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            path.write_bytes(output.replace(b"[2998] = 16732", b"[2998] = 9999"))
            failed = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertNotEqual(0, failed.returncode)
            self.assertIn("2998", failed.stderr)

    def test_instance_parser_rejects_executable_computed_duplicate_and_unknown_values(self):
        cases = [self.source + b"\nZoneDB.instanceIdToAreaId = {}\n",
                 self.source.replace(b"ZoneDB.zoneIDs.SHADOWFANG_KEEP", b"ZoneDB.zoneIDs.UNKNOWN"),
                 self.source.replace(b"ZoneDB.zoneIDs.SHADOWFANG_KEEP", b"chooseArea()"),
                 self.source.replace(b"ZoneDB.zoneIDs.SHADOWFANG_KEEP", b"ZoneDB.zoneIDs.SHADOWFANG_KEEP + 1"),
                 self.source.replace(b"[999] = 9000,", b"[999] = 9000, [999] = 9001,"),
                 self.source.replace(b"[999] = 9000,", b"[999] = 0,")]
        lookup = resolve_areas([area(215)], WORLD_MAPS, [assignment()], {1412: "Mulgore"})
        for source in cases:
            with self.subTest(source=source), self.assertRaises(ValueError):
                extend_instances(source, self.zones, lookup, WORLD_MAPS)


class CandidateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.database = self.root / "source.db"
        self.output = self.root / ".out/forever-support/review"
        parent_source = self.root / support.PARENT_SOURCE
        parent_source.parent.mkdir(parents=True)
        parent_source.write_bytes((FIXTURES / "parent-support.lua").read_bytes())
        self.instance_source = self.root / support.INSTANCE_SOURCE
        self.instance_source.write_bytes((FIXTURES / "instance-support.lua").read_bytes())
        enum_source = self.root / support.ZONE_ENUM_SOURCE
        enum_source.parent.mkdir(parents=True)
        enum_source.write_bytes((FIXTURES / "zone-enum.lua").read_bytes())
        self.forward_source = self.root / support.FORWARD_SOURCE
        self.reverse_source = self.root / support.REVERSE_SOURCE
        self.forward_source.write_bytes((FIXTURES / "forward-support.lua").read_bytes())
        self.reverse_source.write_bytes((FIXTURES / "reverse-support.lua").read_bytes())
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
        self.addCleanup(patch.stopall)
        patch.object(support, "ROOT", self.root).start()
        patch.object(support, "CANDIDATES", self.root / ".out/forever-support").start()
        patch.object(support, "REVIEWED_PARENT_SCOPE", PARENT_SCOPE).start()

    def build(self):
        return build_candidate(self.database, BUILD)

    def test_candidate_is_deterministic_and_keeps_native_inventory_separate(self):
        before = self.database.read_bytes()
        candidate = self.build()
        self.assertEqual(candidate.outputs, self.build().outputs)
        self.assertEqual(before, self.database.read_bytes())
        self.assertEqual({"direct": 1, "inherited": 1, "resolved": 2, "canonical_reverse": 1,
                          "unresolved_real_areas": 1, "compatibility_pairs": 1,
                          "parent_additions": 1, "instance_additions": 0,
                          "unresolved_instance_maps": 0}, candidate.report["summary"])
        self.assertEqual([2257], candidate.report["unresolved_real_areas"])
        self.assertNotIn(235, [r["id"] for r in candidate.report["native_ui_maps"]])
        self.assertIn(b"[10022] = 235", candidate.outputs["Zones/areaIdToUiMapId.lua"])
        self.assertEqual(5, len(write_candidate(self.output, candidate)))
        self.assertEqual([], write_candidate(self.output, candidate))

    def test_sqlite_no_ui_map_instances_are_fingerprinted_and_parented(self):
        old = self.build()
        for row in [world_map(2998), world_map(2999)]:
            self.conn.execute("INSERT INTO map VALUES (?,?,?,?,?,?)", list(row.values()) + [BUILD, BUILD])
        for row in [area(16732, map_id=2998), area(16877, 16732, 2998), area(16878, 16877, 2998),
                    area(16611, map_id=2999), area(16612, 16611, 2999)]:
            self.conn.execute("INSERT INTO area_table VALUES (?,?,?,?,?,?,?)", list(row.values()) + [BUILD, BUILD])
        self.conn.commit()
        candidate = self.build()
        self.assertEqual(2, candidate.report["summary"]["instance_additions"])
        self.assertEqual(4, candidate.report["summary"]["parent_additions"])
        instances = read_instance_table(candidate.outputs["Zones/instanceIdToAreaId.lua"].decode(),
                                        {"SHADOWFANG_KEEP": 209})
        self.assertEqual(16732, instances.values[2998])
        self.assertEqual(16611, instances.values[2999])
        forward, _ = read_support_tables(candidate.outputs["Zones/areaIdToUiMapId.lua"].decode(), "areaIdToUiMapId")
        self.assertNotIn(16732, forward.values)
        self.assertNotIn(16611, forward.values)
        for path in (support.INSTANCE_SOURCE, support.ZONE_ENUM_SOURCE):
            self.assertEqual(support.digest((self.root / path).read_bytes()),
                             candidate.report["owned_inputs"][path]["sha256"])
        self.assertEqual(support.digest(candidate.outputs["Zones/instanceIdToAreaId.lua"]),
                         candidate.report["files"]["Zones/instanceIdToAreaId.lua"]["output_sha256"])
        self.conn.execute("UPDATE map SET InstanceType=0 WHERE ID=2998")
        self.conn.commit()
        changed = self.build()
        self.assertEqual(candidate.report["source_projections"]["map"], changed.report["source_projections"]["map"])
        self.assertNotEqual(candidate.report["source_tables"]["map"], changed.report["source_tables"]["map"])
        self.assertEqual(1, changed.report["summary"]["instance_additions"])
        self.assertEqual(2, changed.report["summary"]["parent_additions"])
        self.assertEqual(old.report["owned_inputs"], changed.report["owned_inputs"])

    @unittest.skipUnless(LUA, "Lua 5.1 required to load rendered candidates")
    def test_source_names_cannot_close_the_deferred_lua_string(self):
        name = "Name ]]]\nwith ]] delimiters"
        self.conn.execute("UPDATE area_table SET AreaName_lang=? WHERE ID=215", (name,))
        self.conn.execute("UPDATE ui_map SET Name_lang=? WHERE ID=1412", (name,))
        self.conn.commit()
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
            build_candidate(self.root / "missing.db", BUILD)
        self.assertFalse((self.root / "missing.db").exists())
        self.assertFalse(self.output.exists())

    def test_another_covered_build_needs_no_parallel_policy_or_hash_edits(self):
        original = self.build()
        new_build = "1.60.1.69913"
        self.conn.execute("INSERT INTO _build VALUES (?)", (new_build,))
        self.conn.execute("INSERT INTO _table_build SELECT table_name,?,locale,status,error FROM _table_build", (new_build,))
        for table in self.tables:
            self.conn.execute(f"UPDATE {table} SET _last_seen=?", (new_build,))
        self.conn.execute("UPDATE area_table SET AreaName_lang='New source name' WHERE ID=215")
        self.conn.commit()
        candidate = build_candidate(self.database, new_build)
        self.assertEqual(new_build, candidate.report["build"])
        self.assertNotEqual(original.report["source_projections"]["area_table"],
                            candidate.report["source_projections"]["area_table"])
        self.assertEqual(original.report["owned_inputs"], candidate.report["owned_inputs"])
        self.assertEqual(original.report["owned_overrides"], candidate.report["owned_overrides"])
        self.conn.execute("UPDATE _table_build SET status='failed' WHERE build=?", (new_build,))
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "snapshot failed"):
            build_candidate(self.database, new_build)

    def test_missing_build_and_invalid_required_fields_still_fail(self):
        with self.assertRaisesRegex(ValueError, "not registered"):
            build_candidate(self.database, "1.60.1.69913")
        self.conn.execute("UPDATE ui_map_assignment SET Region_4=NULL")
        self.conn.commit()
        with self.assertRaisesRegex(ValueError, "invalid Region_4"):
            self.build()

    def test_owned_overrides_and_their_comments_are_the_only_policy_input(self):
        original = self.build()
        self.forward_source.write_bytes(self.forward_source.read_bytes().replace(b"[10022] = 235", b"[10022] = 236"))
        self.reverse_source.write_bytes(self.reverse_source.read_bytes().replace(b"[235] = 10022", b"[236] = 10022"))
        candidate = self.build()
        _, authored = read_support_tables(self.forward_source.read_text(), "areaIdToUiMapId")
        _, emitted = read_support_tables(candidate.outputs["Zones/areaIdToUiMapId.lua"].decode(), "areaIdToUiMapId")
        self.assertEqual(authored.literal, emitted.literal)
        self.assertEqual(236, emitted.values[10022])
        self.assertIn("Retain the pre-entrance dungeon lookup", emitted.literal)
        self.assertNotEqual(original.report["owned_inputs"], candidate.report["owned_inputs"])
        self.assertEqual((FIXTURES / "parent-support.lua").read_bytes(), (self.root / support.PARENT_SOURCE).read_bytes())

    def test_redundant_direct_and_descendant_overrides_keep_the_canonical_reverse(self):
        self.forward_source.write_bytes(self.forward_source.read_bytes().replace(
            b"[0] = 0,", b"[0] = 0, [215] = 1412, [220] = 1412,"))
        candidate = self.build()
        _, overrides = read_support_tables(candidate.outputs["Zones/areaIdToUiMapId.lua"].decode(), "areaIdToUiMapId")
        reverse, _ = read_support_tables(candidate.outputs["Zones/uiMapIdToAreaId.lua"].decode(), "uiMapIdToAreaId")
        self.assertEqual(1412, overrides.values[215])
        self.assertEqual(1412, overrides.values[220])
        self.assertEqual(215, reverse.values[1412])
        self.forward_source.write_bytes(self.forward_source.read_bytes().replace(b"[215] = 1412", b"[215] = 9999"))
        with self.assertRaisesRegex(ValueError, "forward override.*conflicts with DBC"):
            self.build()

    def test_reverse_override_cannot_replace_a_canonical_dbc_area(self):
        self.reverse_source.write_bytes(self.reverse_source.read_bytes().replace(b"[235] = 10022,", b"[235] = 10022, [1412] = 220,"))
        with self.assertRaisesRegex(ValueError, "conflicts with canonical DBC"):
            self.build()

    def test_inconsistent_or_missing_owned_inputs_fail_before_output(self):
        self.reverse_source.write_bytes(self.reverse_source.read_bytes().replace(b"[235] = 10022", b"[235] = 10023"))
        with self.assertRaisesRegex(ValueError, "overrides disagree"):
            self.build()
        self.reverse_source.unlink()
        with self.assertRaises(FileNotFoundError):
            self.build()
        self.assertFalse(self.output.exists())

    def test_malformed_owned_overrides_are_not_executed_or_ignored(self):
        original = self.forward_source.read_bytes()
        cases = [original.replace(b"[0] = 0,", b"[0] = -1,"),
                 original.replace(b"[10022] = 235,", b"[10022] = 235, [10022] = 236,"),
                 original.replace(b"[10022] = 235,", b"[10022] = chooseMap(),"),
                 original + b"\nZoneDB.private.areaIdToUiMapIdOverride = nil\n"]
        for content in cases:
            with self.subTest(content=content):
                self.forward_source.write_bytes(content)
                with self.assertRaises(ValueError):
                    self.build()
        self.assertFalse(self.output.exists())


@unittest.skipUnless(os.environ.get("FOREVER_DBC_DATABASE"), "set FOREVER_DBC_DATABASE for pinned snapshot acceptance")
class ReviewedSnapshotTests(unittest.TestCase):
    def test_parent_candidate_reproduces_the_old_overlay_and_preserves_owned_navigation(self):
        candidate = build_candidate(Path(os.environ["FOREVER_DBC_DATABASE"]), BUILD)
        parents = candidate.report["parent_support"]
        reviewed = [row for row in parents["relationships"]
                    if row["parent_id"] in support.REVIEWED_PARENT_SCOPE["parent_area_ids"]]
        self.assertEqual(65, len(reviewed))
        # Independently select expected instance edges from SQLite, not report rows.
        conn = sqlite3.connect(Path(os.environ["FOREVER_DBC_DATABASE"]).resolve().as_uri() + "?mode=ro", uri=True)
        try:
            areas = {row[0]: (row[1], row[2]) for row in conn.execute(
                "SELECT ID,ParentAreaID,ContinentID FROM area_table WHERE _first_seen<=? AND _last_seen>=?",
                (BUILD, BUILD))}
            maps = list(conn.execute(
                "SELECT ID,AreaTableID,InstanceType FROM map WHERE _first_seen<=? AND _last_seen>=?",
                (BUILD, BUILD)))
        finally:
            conn.close()
        zones = read_zone_ids((ROOT / support.ZONE_ENUM_SOURCE).read_text())
        authored = read_instance_table((ROOT / support.INSTANCE_SOURCE).read_text(), zones).values
        instance_maps = set()
        expected_instances = {}
        for map_id, explicit, instance_type in maps:
            roots = [area_id for area_id, (parent_id, world_id) in areas.items()
                     if parent_id == 0 and world_id == map_id]
            target = explicit if explicit in areas else None
            if not explicit and instance_type in (1, 2, 3, 4) and len(roots) == 1:
                target = roots[0]
            target = target if target is not None else authored.get(map_id)
            if target is not None:
                expected_instances[map_id] = target
                if instance_type in (1, 2, 3, 4):
                    instance_maps.add(map_id)
        expected_parents = {int(area_id): int(parent_id) for area_id, parent_id in re.findall(
            r"\[(\d+)\] = (\d+)", (FIXTURES / "forever-reviewed-parents.lua").read_text())}
        expected_parents.update({area_id: parent_id for area_id, (parent_id, map_id) in areas.items()
                                 if parent_id and map_id in instance_maps and areas[parent_id][1] == map_id})
        self.assertEqual(len(expected_parents), len(parents["relationships"]))
        self.assertIsNotNone(LUA, "Lua 5.1 is required for real snapshot acceptance")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "subZoneToParentZone.lua"
            path.write_bytes(candidate.outputs["Zones/subZoneToParentZone.lua"])
            expected = Path(directory) / "expected-parents.lua"
            expected.write_text("return {" + ",".join(f"[{key}]={value}" for key, value in sorted(expected_parents.items())) + "}\n")
            command = [LUA, str(FIXTURES / "parents-compare.lua"), str(path),
                       str(ROOT / support.PARENT_SOURCE), str(expected)]
            result = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            self.assertIn("reviewed relationships match", result.stdout)
            # Dropping just one new relationship must fail despite preserving old data.
            damaged, removed = re.subn(rb"(?m)^\s*\[16607\]\s*=\s*16606,[^\n]*\n", b"", path.read_bytes())
            self.assertEqual(1, removed, "Self-proof must remove the reviewed relationship")
            path.write_bytes(damaged)
            failed = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertNotEqual(0, failed.returncode)
            self.assertIn("16607", failed.stderr)
            instance_path = Path(directory) / "instanceIdToAreaId.lua"
            instance_path.write_bytes(candidate.outputs["Zones/instanceIdToAreaId.lua"])
            expected.write_text("return {" + ",".join(f"[{key}]={value}" for key, value in sorted(expected_instances.items())) + "}\n")
            result = subprocess.run([LUA, str(FIXTURES / "instances-compare.lua"), str(instance_path),
                                     str(ROOT / support.INSTANCE_SOURCE), str(ROOT / support.ZONE_ENUM_SOURCE), str(expected)],
                                    capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)

    def test_historical_lua_subset_derivations_and_unresolved_inventory(self):
        candidate = build_candidate(Path(os.environ["FOREVER_DBC_DATABASE"]), BUILD)
        provenance = json.loads((ROOT / "support/Forever/provenance.json").read_text())["local_map_refresh"]
        report = candidate.report
        reference = json.loads((FIXTURES / "forever-spatial-reference.json").read_text())
        self.assertEqual(reference["build"], report["build"])
        self.assertEqual(reference["source_projections"],
                         {name: row["projection_sha256"] for name, row in report["source_projections"].items()})
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
                                     str(output / "Zones"), str(ROOT / "support/Forever/Zones"), "--historical-subset"],
                                    capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            self.assertIn("All four mapping tables match", result.stdout)
            # Self-proof: correct counts cannot hide a wrong value.
            path = output / "Zones/areaIdToUiMapId.lua"
            path.write_bytes(path.read_bytes().replace(b"[220] = 1412", b"[220] = 9999"))
            failed = subprocess.run([lua, str(Path(__file__).with_name("fixtures") / "support-compare.lua"),
                                     str(output / "Zones"), str(ROOT / "support/Forever/Zones"), "--historical-subset"],
                                    capture_output=True, text=True, timeout=10)
            self.assertNotEqual(0, failed.returncode)
            self.assertIn("220", failed.stderr)


if __name__ == "__main__":
    unittest.main()
