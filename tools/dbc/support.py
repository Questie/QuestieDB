#!/usr/bin/env python3
"""Generate candidate Forever map support from an existing explicit DBC snapshot."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import json
from pathlib import Path
import re
import signal
import sqlite3
import sys

from files import destination, digest, install_outputs
from maps import read_snapshot, interrupt
from source import read_table
from spatial import SpatialLookup, resolve_areas, route_records

ROOT = Path(__file__).resolve().parents[2]
EXCEPTIONS = Path(__file__).with_name("forever-spatial-exceptions.json")
CANDIDATES = ROOT / ".out/forever-support"
TOOL = "QuestieDB dbc-support"
MANIFEST = "report.json"
AREA_FIELDS = {"ID": int, "AreaName_lang": str, "ContinentID": int,
               "ParentAreaID": int, "Flags_0": int}
WORLD_MAP_FIELDS = {"ID": int, "MapName_lang": str, "AreaTableID": int}
PROJECTION_FIELDS = {
    "area_table": tuple(AREA_FIELDS), "map": tuple(WORLD_MAP_FIELDS),
    "ui_map": ("ID", "Name_lang"),
    "ui_map_assignment": ("ID", "UiMapID", "AreaID", "MapID", "OrderIndex"),
}


def json_bytes(value: object) -> bytes:
    """Stable report bytes; no timestamps or machine-dependent absolute paths."""
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2, allow_nan=False) + "\n").encode()


def projection_hash(rows: list[dict]) -> str:
    """Use the reviewed handoff's canonical selected-field fingerprint."""
    return digest(json.dumps(rows, ensure_ascii=False, sort_keys=True,
                             separators=(",", ":"), allow_nan=False).encode())


@dataclass
class SupportCandidate:
    """Candidate bytes and evidence, without any runtime installation authority."""

    outputs: dict[str, bytes]
    report: dict


def build_candidate(database: Path, build: str, exceptions: Path = EXCEPTIONS) -> SupportCandidate:
    """Read one strict Forever snapshot, resolve maps, then apply reviewed policy.

    No cache acquisition, Lua entity loading, conversion or runtime writes occur.
    Exception applicability is pinned to exact build and reviewed source projections.
    """
    if not re.fullmatch(r"1\.60\.\d+\.\d+", build):
        raise ValueError("An explicit Forever 1.60.x build is required")
    policy_bytes = exceptions.read_bytes()
    policy = json.loads(policy_bytes)
    if not isinstance(policy, dict) or policy.get("format") != 1 or policy.get("flavor") != "Forever" or policy.get("build") != build:
        raise ValueError("Exception input does not apply to this Forever build")
    conn = sqlite3.connect(database.resolve().as_uri() + "?mode=ro", uri=True)
    conn.row_factory = sqlite3.Row
    try:
        conn.execute("PRAGMA query_only = ON")
        conn.execute("BEGIN")
        assignments, ui_maps, metadata = read_snapshot(conn, build, False)
        area_rows = read_table(conn, "area_table", build, AREA_FIELDS)
        map_rows = read_table(conn, "map", build, WORLD_MAP_FIELDS)
    finally:
        conn.close()
    tables = {"area_table": area_rows, "map": map_rows, "ui_map_assignment": assignments,
              "ui_map": [{"ID": i, "Name_lang": name} for i, name in sorted(ui_maps.items())]}
    projections = {}
    for table, fields in PROJECTION_FIELDS.items():
        rows = [{field: row[field] for field in fields} for row in tables[table]]
        projections[table] = {"columns": fields, "rows": len(rows),
                              "projection_sha256": projection_hash(rows)}
        if table not in metadata:
            metadata[table] = {"coverage": "ok", "rows": len(rows),
                               "snapshot_sha256": projection_hash(rows)}
    expected = policy.get("source_projections")
    actual = {name: row["projection_sha256"] for name, row in projections.items()}
    if expected != actual:
        raise ValueError("Exception source projections differ from the reviewed snapshot; review applicability")

    lookup = resolve_areas(area_rows, map_rows, assignments, ui_maps)
    overrides, reverse_overrides, records = _policy_overrides(policy, lookup)
    report = {
        "format": 1, "tool": TOOL, "flavor": "Forever", "build": build,
        "candidate_only": True,
        "ownership": "Owned Forever Lua remains authoritative. Candidates are generated proposals, not runtime inputs.",
        "source_tables": metadata, "reviewed_projections": projections,
        "exception_input_sha256": digest(policy_bytes), "exceptions": records,
        "native_ui_maps": [{"id": i, "name": name} for i, name in sorted(ui_maps.items())],
        "areas": area_rows, "world_maps": map_rows, "assignments": assignments,
        "routes": route_records(lookup), "canonical_reverse": lookup.reverse,
        "unresolved_real_areas": lookup.unresolved,
        "unresolved_ui_maps": sorted(set(ui_maps) - set(lookup.reverse) - set(reverse_overrides)),
        "diagnostics": lookup.diagnostics,
        "parent_routing_differences": lookup.parent_routing_differences,
        "limitations": [
            "Map selection does not establish an authored point's coordinate frame.",
            "Retired compatibility targets are not native map geometry; resolve instances before UiMap operations.",
            "No entrances, entity positions, subzone tables or instance tables are generated or changed.",
            "Consumer sentinel ordering, version-skew protection and client placement remain release gates.",
        ],
        "summary": {"direct": len(lookup.direct), "inherited": len(lookup.resolved) - len(lookup.direct),
                    "resolved": len(lookup.resolved), "canonical_reverse": len(lookup.reverse),
                    "unresolved_real_areas": len(lookup.unresolved),
                    "compatibility_pairs": sum(r["kind"] == "retired_map_compatibility" for r in records)},
    }
    outputs = {
        "Zones/areaIdToUiMapId.lua": _render_forward(lookup, overrides, build),
        "Zones/uiMapIdToAreaId.lua": _render_reverse(lookup, reverse_overrides, build),
    }
    report["files"] = {name: {"output_sha256": digest(data)} for name, data in outputs.items()}
    outputs[MANIFEST] = json_bytes(report)
    return SupportCandidate(outputs, report)


def _policy_overrides(policy: dict, lookup: SpatialLookup) -> tuple[dict, dict, list[dict]]:
    """Keep suppression, native aliases and retired consumer lookup keys distinct."""
    records = policy.get("entries")
    if not isinstance(records, list):
        raise ValueError("Exception entries must be a list")
    forward, reverse = {}, {}
    ids = set()
    fields = {"id", "kind", "area_id", "ui_map_id", "area_kind", "reason", "evidence", "retire_when"}
    for row in records:
        if not isinstance(row, dict) or set(row) != fields:
            raise ValueError("Malformed spatial exception record")
        if any(not isinstance(row[k], str) or not row[k].strip()
               for k in ("id", "kind", "area_kind", "reason", "evidence", "retire_when")):
            raise ValueError("Exception identity, reason, evidence and retirement condition are required")
        if row["id"] in ids:
            raise ValueError("Duplicate exception ID: " + row["id"])
        ids.add(row["id"])
        area, ui, kind = row["area_id"], row["ui_map_id"], row["kind"]
        if type(area) is not int or type(ui) is not int or area < 0 or ui < 0:
            raise ValueError("Exception IDs must be nonnegative integers")
        actual_kind = "zero" if area == 0 else "real" if area in lookup.areas else "absent"
        expected_kinds = ("synthetic", "legacy") if actual_kind == "absent" else (actual_kind,)
        if row["area_kind"] not in expected_kinds:
            raise ValueError(f"Exception {row['id']}: area identity changed or collides with a real area")
        if area in forward or area in lookup.resolved:
            raise ValueError(f"Exception {row['id']}: conflicts with an existing area route")
        if kind == "suppression":
            if ui != 0 or actual_kind == "absent":
                raise ValueError("Suppression requires a real area or zero and UiMap 0")
        elif kind == "native_alias":
            if row["area_kind"] != "synthetic" or ui not in lookup.ui_maps:
                raise ValueError("Native aliases require a synthetic area and an actual UiMap")
        elif kind == "retired_map_compatibility":
            if area == 0 or ui == 0 or ui in lookup.ui_maps:
                raise ValueError("Retired compatibility must not claim native map geometry")
        else:
            raise ValueError("Unknown exception kind: " + kind)
        forward[area] = (ui, row["id"])
        if kind != "suppression":
            if ui in reverse or ui in lookup.reverse:
                raise ValueError(f"Exception {row['id']}: conflicts with a canonical reverse mapping")
            reverse[ui] = (area, row["id"])
    return forward, reverse, sorted(records, key=lambda r: r["id"])


def _comment(text: str) -> str:
    # Names are comments inside a Lua long string. Do not let source names close it.
    return text.replace("\r", " ").replace("\n", " ").replace("]", "] ")


def _header(build: str) -> list[str]:
    return [f"-- Generated Forever support candidate for DBC {build}; see report.json.",
            "-- Candidate only. Retired compatibility IDs are not native map geometry.",
            'local ZoneDB = QuestieLoader:ImportModule("ZoneDB")', ""]


def _render_forward(lookup: SpatialLookup, overrides: dict, build: str) -> bytes:
    lines = _header(build) + ["ZoneDB.private.areaIdToUiMapIdOverride = [[return {"]
    for area, (ui, exception) in sorted(overrides.items()):
        lines.append(f"    [{area}] = {ui}, -- {_comment(exception)}")
    lines += ["}]]", "", "ZoneDB.private.areaIdToUiMapId = [[return {"]
    for area, route in sorted(lookup.resolved.items()):
        name = _comment(lookup.areas[area].name)
        evidence = f"assignment {route.assignment_id}"
        if area != route.ancestor_id:
            evidence += f", via area {route.ancestor_id}"
        lines.append(f"    [{area}] = {route.ui_map_id}, -- {name}; {evidence}")
    return ("\n".join(lines + ["}]]", ""])).encode()


def _render_reverse(lookup: SpatialLookup, overrides: dict, build: str) -> bytes:
    lines = _header(build) + ["ZoneDB.private.uiMapIdToAreaIdOverride = [[return {"]
    for ui, (area, exception) in sorted(overrides.items()):
        lines.append(f"    [{ui}] = {area}, -- {_comment(exception)}")
    lines += ["}]]", "", "-- Canonical direct assignments, not the inverse of descendant routes.",
              "ZoneDB.private.uiMapIdToAreaId = [[return {"]
    for ui, area in sorted(lookup.reverse.items()):
        lines.append(f"    [{ui}] = {area}, -- {_comment(lookup.ui_maps[ui])}")
    return ("\n".join(lines + ["}]]", ""])).encode()


def write_candidate(output: Path, candidate: SupportCandidate) -> list[str]:
    """Install only under the dedicated candidate root, preserving manual edits.

    Reuse conversion's staged installation/rollback mechanics with separate tool
    ownership. Active support, protected handoffs and arbitrary destinations are
    never accepted, including paths through symlinks.
    """
    output = output.absolute()
    try:
        relative = output.relative_to(ROOT)
        output.relative_to(CANDIDATES)
    except ValueError:
        raise ValueError("Output must be under " + str(CANDIDATES)) from None
    destination(ROOT, str(relative / MANIFEST))
    output.mkdir(parents=True, exist_ok=True)
    return install_outputs(output, candidate.outputs, manifest_name=MANIFEST, tool=TOOL)


def main() -> int:
    """Generate reviewable candidates without downloading sources or touching runtime inputs."""
    signal.signal(signal.SIGTERM, interrupt)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, required=True, help="Existing SQLite database; never downloaded")
    parser.add_argument("--build", required=True, help="Explicit Forever build, e.g. 1.60.1.69893")
    parser.add_argument("--output", type=Path, required=True, help="Directory under QuestieDB/.out/forever-support/")
    args = parser.parse_args()
    try:
        candidate = build_candidate(args.database, args.build)
        changed = write_candidate(args.output, candidate)
    except KeyboardInterrupt:
        print("Support candidate generation cancelled", file=sys.stderr)
        return 130
    except (ValueError, OSError, sqlite3.Error) as error:
        parser.exit(1, f"Support candidate generation failed: {error}\n")
    print(json.dumps(candidate.report["summary"], sort_keys=True))
    print(f"Candidate only: {args.output} ({len(changed)} files changed). Runtime support untouched.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
