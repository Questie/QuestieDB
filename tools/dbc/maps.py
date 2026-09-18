#!/usr/bin/env python3
"""Inspect Era-to-Forever coordinate transforms without rewriting entity data."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import signal
import sqlite3
import sys

from coordinates import Transform, compare_maps
from source import read_table
from download import DEFAULT_DATABASE, ensure_database

ASSIGNMENT_FIELDS = {
    "ID": int, "UiMapID": int, "MapID": int, "AreaID": int, "OrderIndex": int,
    "WMODoodadPlacementID": int, "WMOGroupID": int,
    "UiMin_0": float, "UiMin_1": float, "UiMax_0": float, "UiMax_1": float,
    **{f"Region_{index}": float for index in range(6)},
}
MAP_FIELDS = {"ID": int, "Name_lang": str}


def read_snapshot(conn: sqlite3.Connection, build: str, allow_untracked: bool) -> tuple[list[dict], dict, dict]:
    """Read named geometry and retain unknown nonzero fields as conversion blockers."""
    if not conn.execute("SELECT 1 FROM _build WHERE build = ?", (build,)).fetchone():
        raise ValueError(f"Build {build} is not registered")
    assignments = read_table(conn, "ui_map_assignment", build, ASSIGNMENT_FIELDS,
                             allow_untracked=allow_untracked)
    maps = read_table(conn, "ui_map", build, MAP_FIELDS, allow_untracked=allow_untracked)

    # Schema evolution must not silently hide a newly meaningful assignment selector.
    raw_rows = [
        {key: row[key] for key in row.keys() if not key.startswith("_")}
        for row in conn.execute(
            "SELECT * FROM ui_map_assignment WHERE _first_seen <= ? AND _last_seen >= ? ORDER BY ID",
            (build, build),
        )
    ]
    extras = {
        row["ID"]: {key: value for key, value in row.items()
                    if key not in ASSIGNMENT_FIELDS and value not in (None, 0)}
        for row in raw_rows
    }
    for row in assignments:
        if extras[row["ID"]]:
            row["uninterpreted_fields"] = extras[row["ID"]]
    metadata = {}
    for table, rows in (("ui_map_assignment", raw_rows), ("ui_map", maps)):
        coverage = conn.execute(
            "SELECT status FROM _table_build WHERE table_name = ? AND build = ? AND locale = ''",
            (table, build),
        ).fetchone()
        payload = json.dumps(rows, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
        metadata[table] = {
            "coverage": coverage["status"] if coverage else "untracked",
            "rows": len(rows), "snapshot_sha256": hashlib.sha256(payload.encode()).hexdigest(),
        }
    return assignments, {row["ID"]: row["Name_lang"] for row in maps}, metadata


def build_report(database: Path, source_build: str, target_build: str,
                 allow_untracked_source: bool = False) -> dict:
    """Read both builds in one read-only transaction; target coverage remains strict."""
    conn = sqlite3.connect(database.resolve().as_uri() + "?mode=ro", uri=True)
    conn.row_factory = sqlite3.Row
    try:
        conn.execute("PRAGMA query_only = ON")
        conn.execute("BEGIN")
        source, source_names, source_metadata = read_snapshot(conn, source_build, allow_untracked_source)
        target, target_names, target_metadata = read_snapshot(conn, target_build, False)
    finally:
        conn.close()
    return {
        "source_build": source_build, "target_build": target_build,
        "units": "map percentages (0–100)",
        "assumption": "World positions and world coordinate frame remain unchanged; DBC identity alone does not prove this.",
        "source_tables": source_metadata, "target_tables": target_metadata,
        **compare_maps(source, target, source_names, target_names),
    }


def convert_points(report: dict, ui_map: int, points: list[list[float]]) -> list[dict]:
    """Transform supplied points only for a supported map; expose out-of-bounds results."""
    entry = next((row for row in report["transforms"] if row["ui_map_id"] == ui_map), None)
    if entry is None:
        reason = next((row["reason"] for row in report["unsupported"] if row["ui_map_id"] == ui_map),
                      "no matched source and target zone assignment")
        raise ValueError(f"UiMap {ui_map}: {reason}")
    transform = Transform(**entry["coefficients"])
    result = []
    for x, y in points:
        new_x, new_y = transform.apply(x, y)
        sentinel = x == y == -1
        result.append({
            "ui_map_id": ui_map, "source": [x, y], "target": [new_x, new_y],
            "instance_sentinel": sentinel,
            "source_out_of_bounds": not sentinel and not (0 <= x <= 100 and 0 <= y <= 100),
            "target_out_of_bounds": not sentinel and not (0 <= new_x <= 100 and 0 <= new_y <= 100),
        })
    return result


def interrupt(_signal: int, _frame: object) -> None:
    """Unwind download temporary files when the contributor launcher cancels this tool."""
    raise KeyboardInterrupt


def main() -> int:
    """Print coefficients or points, downloading the source cache only when missing."""
    signal.signal(signal.SIGTERM, interrupt)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--from-build", required=True, help="Explicit Era build, e.g. 1.15.9.69722")
    parser.add_argument("--to-build", required=True, help="Explicit Forever build, e.g. 1.60.1.69893")
    parser.add_argument("--database", type=Path, default=DEFAULT_DATABASE)
    parser.add_argument("--allow-untracked-source", action="store_true",
                        help="Accept legacy source snapshots lacking coverage records, but never recorded failures")
    parser.add_argument("--ui-map", type=int, help="UiMapID for supplied points, not AreaID or instance MapID")
    parser.add_argument("--point", type=float, nargs=2, action="append", metavar=("X", "Y"),
                        help="Era percentages; repeat for multiple points on the same map")
    parser.add_argument("--dbc-tag", help="Release tag used only when the DBC cache is missing")
    parser.add_argument("--json", action="store_true", help="Print the complete coefficient report as JSON")
    args = parser.parse_args()
    if not re.fullmatch(r"1\.15\.\d+\.\d+", args.from_build):
        parser.error("--from-build must be an explicit Era 1.15.x build")
    if not re.fullmatch(r"1\.60\.\d+\.\d+", args.to_build):
        parser.error("--to-build must be an explicit Forever 1.60.x build")
    if (args.ui_map is None) != (args.point is None):
        parser.error("--ui-map and --point must be supplied together")
    try:
        database_provenance = ensure_database(args.database, args.from_build, args.to_build, tag=args.dbc_tag)
        report = build_report(args.database, args.from_build, args.to_build, args.allow_untracked_source)
        report["database"] = database_provenance
        points = convert_points(report, args.ui_map, args.point) if args.point else []
    except KeyboardInterrupt:
        print("Coordinate comparison cancelled", file=sys.stderr)
        return 130
    except (ValueError, OSError, sqlite3.Error) as error:
        parser.exit(1, f"Coordinate comparison failed: {error}\n")

    if args.json:
        print(json.dumps({**report, "points": points}, ensure_ascii=False, indent=2, allow_nan=False))
        return 0

    print(f"{args.from_build} -> {args.to_build}; percentages, not normalized coordinates")
    if any(row["coverage"] == "untracked" for row in report["source_tables"].values()):
        print("WARNING: Era source coverage is untracked; accepted explicitly, not verified complete.")
    print("Changed maps: x' = scale_x * x + offset_x; y' = scale_y * y + offset_y")
    for row in report["transforms"]:
        if row["changed"]:
            coeff = row["coefficients"]
            print(f"  {row['target_name']} (UiMap {row['ui_map_id']}, Area {row['area_id']}): "
                  f"X {coeff['scale_x']:.12f}, {coeff['offset_x']:+.12f}; "
                  f"Y {coeff['scale_y']:.12f}, {coeff['offset_y']:+.12f}")
    print("Summary:", json.dumps(report["summary"], sort_keys=True))
    for point in points:
        print(json.dumps(point, allow_nan=False))
    print("No entity data rewritten. Assumes unchanged world positions; validate landmarks before bulk conversion.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
