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
from parents import REVIEWED_PARENT_SCOPE, extend_parents
from source import read_table
from spatial import SpatialLookup, resolve_areas, route_records
from support_lua import SupportTable, read_support_tables

ROOT = Path(__file__).resolve().parents[2]
CANDIDATES = ROOT / ".out/forever-support"
TOOL = "QuestieDB dbc-support"
MANIFEST = "report.json"
FORWARD_SOURCE = "support/Forever/Zones/areaIdToUiMapId.lua"
REVERSE_SOURCE = "support/Forever/Zones/uiMapIdToAreaId.lua"
PARENT_SOURCE = "support/Forever/Zones/subZoneToParentZone.lua"
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


def build_candidate(database: Path, build: str) -> SupportCandidate:
    """Derive DBC candidates while preserving policy from current owned Lua overrides.

    Every selected table requires recorded coverage. Hashes identify the actual
    inputs in the report, not a second configuration to update for each snapshot.
    No cache acquisition, Lua execution, conversion or runtime writes occur.
    """
    if not re.fullmatch(r"1\.60\.\d+\.\d+", build):
        raise ValueError("An explicit Forever 1.60.x build is required")
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

    lookup = resolve_areas(area_rows, map_rows, assignments, ui_maps)
    owned = {path: (ROOT / path).read_bytes() for path in (FORWARD_SOURCE, REVERSE_SOURCE, PARENT_SOURCE)}
    overrides, reverse_overrides, records = _owned_overrides(owned, lookup)
    parent_output, parent_report = extend_parents(owned[PARENT_SOURCE], lookup, REVIEWED_PARENT_SCOPE)
    report = {
        "format": 1, "tool": TOOL, "flavor": "Forever", "build": build,
        "candidate_only": True,
        "ownership": "Owned Forever Lua remains authoritative. Candidates are generated proposals, not runtime inputs.",
        "source_tables": metadata, "source_projections": projections,
        "owned_overrides": {"area_to_ui_map": records, "ui_map_to_area": reverse_overrides.values},
        "owned_inputs": {path: {"sha256": digest(data)} for path, data in owned.items()},
        "parent_support": parent_report,
        "native_ui_maps": [{"id": i, "name": name} for i, name in sorted(ui_maps.items())],
        "areas": area_rows, "world_maps": map_rows, "assignments": assignments,
        "routes": route_records(lookup), "canonical_reverse": lookup.reverse,
        "unresolved_real_areas": lookup.unresolved,
        "unresolved_ui_maps": sorted(set(ui_maps) - set(lookup.reverse) - set(reverse_overrides.values)),
        "diagnostics": lookup.diagnostics,
        "parent_routing_differences": lookup.parent_routing_differences,
        "limitations": [
            "Map selection does not establish an authored point's coordinate frame.",
            "Owned overrides are policy, not DBC-derived relationships or proof of supported geometry.",
            "Legacy compatibility targets absent from the snapshot are not native maps; resolve instances before UiMap operations.",
            "Only reviewed zone-child parent additions are proposed; other authored navigation relationships are preserved.",
            "No entrances, entity positions or instance tables are generated or changed.",
            "Consumer sentinel ordering, version-skew protection and client placement remain release gates.",
        ],
        "summary": {"direct": len(lookup.direct), "inherited": len(lookup.resolved) - len(lookup.direct),
                    "resolved": len(lookup.resolved), "canonical_reverse": len(lookup.reverse),
                    "unresolved_real_areas": len(lookup.unresolved),
                    "compatibility_pairs": sum(r["kind"] == "legacy_map_compatibility" for r in records),
                    "parent_additions": parent_report["added"]},
    }
    outputs = {
        "Zones/areaIdToUiMapId.lua": _render_forward(lookup, overrides, build),
        "Zones/uiMapIdToAreaId.lua": _render_reverse(lookup, reverse_overrides, build),
        "Zones/subZoneToParentZone.lua": parent_output,
    }
    report["files"] = {name: {"output_sha256": digest(data)} for name, data in outputs.items()}
    outputs[MANIFEST] = json_bytes(report)
    return SupportCandidate(outputs, report)


def _owned_overrides(owned: dict[str, bytes], lookup: SpatialLookup) -> tuple[SupportTable, SupportTable, list[dict]]:
    """Validate authored overrides against DBC and each other without inventing policy.

    Zero is explicit display suppression, not a competing DBC relationship. Other
    overrides may repeat a DBC fact but must not replace it with a different target.
    Absence from AreaTable alone does not prove a key is synthetic rather than legacy.
    """
    _, forward = read_support_tables(owned[FORWARD_SOURCE].decode("utf-8"), "areaIdToUiMapId")
    _, reverse = read_support_tables(owned[REVERSE_SOURCE].decode("utf-8"), "uiMapIdToAreaId")
    records = []
    for area, ui in sorted(forward.values.items()):
        if ui < 0 or (area == 0 and ui != 0):
            raise ValueError(f"Invalid owned forward override: {area} -> {ui}")
        route = lookup.resolved.get(area)
        if ui and route and route.ui_map_id != ui:
            raise ValueError(f"Owned forward override {area} -> {ui} conflicts with DBC {route.ui_map_id}")
        kind = "suppression" if ui == 0 else "native_map_override" if ui in lookup.ui_maps else "legacy_map_compatibility"
        records.append({"area_id": area, "ui_map_id": ui, "kind": kind,
                        "area_in_snapshot": area in lookup.areas, "ui_map_in_snapshot": ui in lookup.ui_maps})
    for ui, area in sorted(reverse.values.items()):
        if ui <= 0 or area <= 0:
            raise ValueError(f"Invalid owned reverse override: {ui} -> {area}")
        canonical = lookup.reverse.get(ui)
        if canonical is not None and canonical != area:
            raise ValueError(f"Owned reverse override {ui} -> {area} conflicts with canonical DBC {canonical}")

    # Additional compatibility pairs must agree in both directions. A redundant
    # descendant override keeps DBC's canonical ancestor in the reverse table;
    # never invert the many-to-one map to manufacture a reverse link for it.
    composed_forward = {**{area: route.ui_map_id for area, route in lookup.resolved.items()}, **forward.values}
    composed_reverse = {**lookup.reverse, **reverse.values}
    for area, ui in forward.values.items():
        if ui and area not in lookup.resolved and composed_reverse.get(ui) != area:
            raise ValueError(f"Owned forward/reverse overrides disagree for area {area}, UiMap {ui}")
    for ui, area in reverse.values.items():
        if composed_forward.get(area) != ui:
            raise ValueError(f"Owned reverse/forward overrides disagree for UiMap {ui}, area {area}")
    return forward, reverse, records


def _comment(text: str) -> str:
    # Names are comments inside a Lua long string. Do not let source names close it.
    return text.replace("\r", " ").replace("\n", " ").replace("]", "] ")


def _header(build: str) -> list[str]:
    return [f"-- Generated Forever support candidate for DBC {build}; see report.json.",
            "-- Candidate only. Retired compatibility IDs are not native map geometry.",
            'local ZoneDB = QuestieLoader:ImportModule("ZoneDB")', ""]


def _render_forward(lookup: SpatialLookup, overrides: SupportTable, build: str) -> bytes:
    lines = _header(build) + ["ZoneDB.private.areaIdToUiMapIdOverride = " + overrides.literal,
                              "", "ZoneDB.private.areaIdToUiMapId = [[return {"]
    for area, route in sorted(lookup.resolved.items()):
        name = _comment(lookup.areas[area].name)
        evidence = f"assignment {route.assignment_id}"
        if area != route.ancestor_id:
            evidence += f", via area {route.ancestor_id}"
        lines.append(f"    [{area}] = {route.ui_map_id}, -- {name}; {evidence}")
    return ("\n".join(lines + ["}]]", ""])).encode()


def _render_reverse(lookup: SpatialLookup, overrides: SupportTable, build: str) -> bytes:
    lines = _header(build) + ["ZoneDB.private.uiMapIdToAreaIdOverride = " + overrides.literal,
                              "", "-- Canonical direct assignments, not the inverse of descendant routes.",
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
