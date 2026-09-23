#!/usr/bin/env python3
"""Create separate Forever Lua inputs from Era without changing Era or runtime routing."""
from __future__ import annotations

import argparse
from collections import Counter
from dataclasses import asdict, dataclass
import json
import math
import os
from pathlib import Path
import re
import signal
import sqlite3
import subprocess
import sys
import tempfile

from coordinates import Transform, compare_maps
from download import DEFAULT_DATABASE, ensure_database
from files import MANIFEST, TOOL, digest, install_outputs
from maps import read_snapshot
from rewrite import Coordinate, read_zone_ids, rewrite
from runtime_helper import HELPER, require_matching_helper

ROOT = Path(__file__).resolve().parents[2]
# Reuse the contributor launcher's Lua discovery and cancellation ownership.
sys.path.insert(0, str(ROOT / "tools/cli"))
from questiedb import find_lua, interrupt


@dataclass(frozen=True)
class Input:
    source: str
    output: str
    entity: str
    raw: bool
    module: str = ""
    methods: tuple[str, ...] = ()


INPUTS = (
    Input("data/Classic/classicItemDB.lua", "data/Forever/foreverItemDB.lua", "Item", True),
    Input("data/Classic/classicNpcDB.lua", "data/Forever/foreverNpcDB.lua", "Npc", True),
    Input("data/Classic/classicObjectDB.lua", "data/Forever/foreverObjectDB.lua", "Object", True),
    Input("data/Classic/classicQuestDB.lua", "data/Forever/foreverQuestDB.lua", "Quest", True),
    Input("src/corrections/Era/classicItemFixes.lua", "src/corrections/Forever/legacy/classicItemFixes.lua",
          "Item", False, "QuestieItemFixes", ("Load", "LoadFactionFixes")),
    Input("src/corrections/Era/classicNPCFixes.lua", "src/corrections/Forever/legacy/classicNPCFixes.lua",
          "Npc", False, "QuestieNPCFixes", ("Load", "LoadFactionFixes")),
    Input("src/corrections/Era/classicObjectFixes.lua", "src/corrections/Forever/legacy/classicObjectFixes.lua",
          "Object", False, "QuestieObjectFixes", ("Load", "LoadFactionFixes")),
    Input("src/corrections/Era/classicQuestFixes.lua", "src/corrections/Forever/legacy/classicQuestFixes.lua",
          "Quest", False, "QuestieQuestFixes", ("Load", "LoadFactionFixes")),
    Input("src/corrections/Era/classicQuestReputationFixes.lua", "src/corrections/Forever/legacy/classicQuestReputationFixes.lua",
          "Quest", False, "QuestieClassicQuestReputationFixes", ("Load",)),
    Input("src/corrections/Shared/itemStartFixes.lua", "src/corrections/Forever/legacy/itemStartFixes.lua",
          "Item", False, "QuestieItemStartFixes", ("LoadAutomaticQuestStarts",)),
)


def geometry(database: Path, source_build: str, target_build: str,
             allow_untracked: bool) -> tuple[dict[int, Transform], dict]:
    """Use only direct, unambiguous AreaID mappings shared by both snapshots.

    No parent, synthetic-area, or cross-map frame is guessed. Those coordinates
    are refused or explicitly retained by --keep-unmapped, with file/line evidence.
    """
    conn = sqlite3.connect(database.resolve().as_uri() + "?mode=ro", uri=True)
    conn.row_factory = sqlite3.Row
    try:
        conn.execute("PRAGMA query_only=ON")
        conn.execute("BEGIN")
        old, old_names, old_meta = read_snapshot(conn, source_build, allow_untracked)
        new, new_names, new_meta = read_snapshot(conn, target_build, False)
    finally:
        conn.close()
    report = compare_maps(old, new, old_names, new_names)
    transforms = {row["area_id"]: Transform(**row["coefficients"])
                  for row in report["transforms"] if row["area_transform_supported"]}
    report.update(source_build=source_build, target_build=target_build,
                  source_tables=old_meta, target_tables=new_meta,
                  area_coefficients={str(area): asdict(value) for area, value in sorted(transforms.items())})
    return transforms, report


def round_coordinate(value: float) -> float:
    """Round converted output to hundredths, with halfway values away from zero."""
    scaled = abs(value) * 100
    if not math.isfinite(scaled):
        raise ValueError("Coordinate is too large to round safely")
    rounded = math.floor(scaled + 0.5) / 100
    return math.copysign(rounded, value) if rounded else 0.0


class ConvertPoints:
    """Count every recognized coordinate and keep unresolved cases visible."""

    def __init__(self, transforms: dict[int, Transform]):
        self.transforms = transforms
        self.counts = Counter()
        self.by_area = Counter()
        self.unmapped = {}
        self.out_of_bounds = []

    def __call__(self, point: Coordinate) -> tuple[float, float]:
        if point.x == -1 or point.y == -1:
            if point.x != point.y:
                raise ValueError("line %d: partial instance sentinel" % point.line)
            self.counts["instance_sentinels"] += 1
            return point.x, point.y
        transform = self.transforms.get(point.area_id)
        if transform is None:
            self.counts["unmapped"] += 1
            entry = self.unmapped.setdefault(str(point.area_id), {"count": 0, "samples": []})
            entry["count"] += 1
            if len(entry["samples"]) < 5:
                entry["samples"].append(asdict(point))
            return point.x, point.y
        new_x, new_y = transform.apply(point.x, point.y)
        changed = (new_x, new_y) != (point.x, point.y)
        self.counts["converted" if changed else "unchanged"] += 1
        if changed:
            self.by_area[str(point.area_id)] += 1
        # Diagnose the unrounded result so rounding cannot conceal an off-map point.
        if not (0 <= new_x <= 100 and 0 <= new_y <= 100):
            self.counts["out_of_bounds"] += 1
            if len(self.out_of_bounds) < 10:
                self.out_of_bounds.append({**asdict(point), "target": [new_x, new_y]})
        if changed:
            new_x, new_y = round_coordinate(new_x), round_coordinate(new_y)
            if new_x == -1 or new_y == -1:
                raise ValueError("line %d: rounding would create an instance sentinel" % point.line)
        return new_x, new_y


def prepare(root: Path, transforms: dict[int, Transform], map_report: dict,
            keep_unmapped: bool) -> tuple[dict[str, bytes], dict]:
    """Always read Era originals; preserve all bytes outside converted number tokens."""
    zones_path = "support/Zones/zoneIds.lua"
    zones_bytes = (root / zones_path).read_bytes()
    zones = read_zone_ids(zones_bytes.decode("utf-8"))
    outputs = {}
    report = {
        "tool": TOOL, "format": 1, "geometry": map_report,
        "keep_unmapped": keep_unmapped,
        "coordinate_rounding": {"decimal_places": 2, "halfway": "away from zero",
                                "scope": "transformed pairs only; calculations retain full precision"},
        "assumption": "NPC/terrain world positions remain unchanged; this is a converted Era baseline, not complete Forever content.",
        "zone_symbols_sha256": digest(zones_bytes), "files": {},
        "not_converted": ["Questie-owned runtime corrections", "support/Zones/dungeons.lua entrances",
                          "Forever race/class restrictions and new content", "subzone or synthetic map routing"],
    }
    for spec in INPUTS:
        original = (root / spec.source).read_bytes()
        if b"QuestieDB convert-forever" in original[:300]:
            raise ValueError("Input looks already converted: " + spec.source)
        converter = ConvertPoints(transforms)
        try:
            text, count = rewrite(original.decode("utf-8"), entity=spec.entity, raw=spec.raw,
                                  zone_ids=zones, transform=converter)
        except ValueError as error:
            raise ValueError(spec.source + ": " + str(error)) from error
        outputs[spec.output] = text.encode("utf-8")
        report["files"][spec.output] = {
            "source": spec.source, "source_sha256": digest(original),
            "output_sha256": digest(outputs[spec.output]), "coordinate_pairs": count,
            "counts": dict(sorted(converter.counts.items())),
            "converted_by_area": dict(sorted(converter.by_area.items())),
            "unmapped": converter.unmapped, "out_of_bounds_samples": converter.out_of_bounds,
        }
    return outputs, report


def lua_value(value) -> str:
    """Serialize the small trusted validation plan, not entity/correction source files."""
    if isinstance(value, str):
        pieces = []
        for char in value:
            if char in ('"', "\\"):
                pieces.append("\\" + char)
            elif ord(char) < 32 or ord(char) == 127:
                pieces.append("\\%03d" % ord(char))
            else:
                pieces.append(char)
        return '"' + ''.join(pieces) + '"'
    if type(value) is bool:
        return "true" if value else "false"
    if type(value) in (int, float) and math.isfinite(value):
        return repr(value)
    if isinstance(value, (list, tuple)):
        return "{" + ",".join(lua_value(item) for item in value) + "}"
    if isinstance(value, dict):
        return "{" + ",".join("[%s]=%s" % (lua_value(key), lua_value(item)) for key, item in value.items()) + "}"
    raise ValueError("Unsupported validation plan value: " + repr(value))


def validate(root: Path, outputs: dict[str, bytes], transforms: dict[int, Transform], lua: str) -> None:
    """Load staged copies in Lua and compare all values before installing any file."""
    with tempfile.TemporaryDirectory(prefix="questiedb-forever-validate-") as temporary:
        directory = Path(temporary)
        plan = {"files": [], "transforms": {area: asdict(value) for area, value in transforms.items()}}
        for spec in INPUTS:
            staged = directory / spec.output
            staged.parent.mkdir(parents=True, exist_ok=True)
            staged.write_bytes(outputs[spec.output])
            plan["files"].append({**asdict(spec), "output": str(staged)})
        plan_path = directory / "plan.lua"
        plan_path.write_text("return " + lua_value(plan) + "\n", encoding="utf-8")
        # Inherit this tool's process group: launcher cancellation must reach Lua
        # even if the converter cannot finish cleanup. The validator spawns no children.
        child = subprocess.Popen([lua, str(root / "tools/dbc/validate.lua"), str(plan_path)], cwd=root)
        try:
            code = child.wait()
        except BaseException:
            if child.poll() is None:
                child.terminate()
            try:
                child.wait(timeout=2)
            except subprocess.TimeoutExpired:
                child.kill()
                child.wait()
            raise
        if code:
            raise ValueError("Lua semantic validation failed; no Forever outputs installed")


def main() -> int:
    """Generate ten isolated files only after source, coverage and semantic checks."""
    signal.signal(signal.SIGTERM, interrupt)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--from-build", required=True)
    parser.add_argument("--to-build", required=True)
    parser.add_argument("--database", type=Path, default=DEFAULT_DATABASE)
    parser.add_argument("--dbc-tag", help="DBC release tag used only if the database is missing")
    parser.add_argument("--allow-untracked-source", action="store_true")
    parser.add_argument("--keep-unmapped", action="store_true",
                        help="Explicitly retain unsupported coordinates unchanged and record them for review")
    parser.add_argument("--dry-run", action="store_true", help="Convert and validate in temporary files without installing outputs")
    parser.add_argument("--lua", default=os.environ.get("LUA"), help="Lua 5.1 executable for semantic validation")
    args = parser.parse_args()
    if not re.fullmatch(r"1\.15\.\d+\.\d+", args.from_build) or not re.fullmatch(r"1\.60\.\d+\.\d+", args.to_build):
        parser.error("Use explicit Era 1.15.x and Forever 1.60.x build numbers")
    try:
        lua = find_lua(args.lua, ROOT)
        provenance = ensure_database(args.database, args.from_build, args.to_build, tag=args.dbc_tag)
        print("DBC:", provenance["origin"], provenance["path"], flush=True)
        transforms, map_report = geometry(args.database, args.from_build, args.to_build, args.allow_untracked_source)
        helper_check = require_matching_helper(map_report, ROOT / HELPER, lua)
        print(helper_check["details"], flush=True)
        outputs, report = prepare(ROOT, transforms, map_report, args.keep_unmapped)
        unresolved = 0
        for path, info in report["files"].items():
            print(path + ": " + json.dumps(info["counts"], sort_keys=True), flush=True)
            for area, entry in info["unmapped"].items():
                print("  Unmapped AreaID %s: %d points, first at line %d" % (area, entry["count"], entry["samples"][0]["line"]), flush=True)
            unresolved += info["counts"].get("unmapped", 0)
        if unresolved and not args.keep_unmapped:
            raise ValueError("%d coordinates need map review. No outputs installed; use --keep-unmapped only to retain them explicitly." % unresolved)
        validate(ROOT, outputs, transforms, lua)
        report["validation"] = "Lua semantic comparison passed for raw data and all correction personas"
        if args.dry_run:
            print("Dry run passed. No Forever files installed.")
            return 0
        # Detect edits during the read/validate phase rather than publishing stale inputs.
        for info in report["files"].values():
            if digest((ROOT / info["source"]).read_bytes()) != info["source_sha256"]:
                raise ValueError("Era input changed during conversion: " + info["source"])
        if digest((ROOT / "support/Zones/zoneIds.lua").read_bytes()) != report["zone_symbols_sha256"]:
            raise ValueError("Zone symbols changed during conversion")
        outputs[MANIFEST] = (json.dumps(report, ensure_ascii=False, indent=2, allow_nan=False) + "\n").encode("utf-8")
        changed = install_outputs(ROOT, outputs)
        print("Installed %d changed files. Provenance/review: %s" % (len(changed), MANIFEST))
        print("Era unchanged. Existing Forever source registrations now read these outputs; generated TOCs were not rebuilt.")
        return 0
    except KeyboardInterrupt:
        print("Conversion cancelled", file=sys.stderr)
        return 130
    except (ValueError, OSError, sqlite3.Error, RuntimeError) as error:
        print("convert-forever: " + str(error), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
