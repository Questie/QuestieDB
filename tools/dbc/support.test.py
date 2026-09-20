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
import support
from support import build_candidate, write_candidate
from support_lua import read_support_tables

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
                          "parent_additions": 1}, candidate.report["summary"])
        self.assertEqual([2257], candidate.report["unresolved_real_areas"])
        self.assertNotIn(235, [r["id"] for r in candidate.report["native_ui_maps"]])
        self.assertIn(b"[10022] = 235", candidate.outputs["Zones/areaIdToUiMapId.lua"])
        self.assertEqual(4, len(write_candidate(self.output, candidate)))
        self.assertEqual([], write_candidate(self.output, candidate))

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
        self.assertEqual(65, len(parents["relationships"]))
        self.assertIsNotNone(LUA, "Lua 5.1 is required for real snapshot acceptance")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "subZoneToParentZone.lua"
            path.write_bytes(candidate.outputs["Zones/subZoneToParentZone.lua"])
            command = [LUA, str(FIXTURES / "parents-compare.lua"), str(path),
                       str(ROOT / support.PARENT_SOURCE), str(FIXTURES / "forever-reviewed-parents.lua")]
            result = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertEqual(0, result.returncode, result.stdout + result.stderr)
            self.assertIn("reviewed relationships match", result.stdout)
            # Dropping just one new relationship must fail despite preserving old data.
            path.write_bytes(path.read_bytes().replace(b"    [16607] = 16606,\n", b""))
            failed = subprocess.run(command, capture_output=True, text=True, timeout=10)
            self.assertNotEqual(0, failed.returncode)
            self.assertIn("16607", failed.stderr)

    def test_exact_current_lua_tables_derivations_and_unresolved_inventory(self):
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
