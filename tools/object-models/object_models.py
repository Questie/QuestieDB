#!/usr/bin/env python3
"""Maintain the 3D models of game objects (support/ObjectModels).

Usage: questiedb.sh object-models check [flavor ...]
       questiedb.sh object-models import <source> <file>
       questiedb.sh object-models displays <flavor> <build> <GameObjectDisplayInfo.csv>
       questiedb.sh object-models write
       (questiedb.ps1 takes the same arguments)

check     Offline. Reports objects without a model and writes .out/object-models/report.json.
          Fails only on wrong or unusable data; a missing model is a warning.
import    Merge one source into sources.tsv, then write. Never touches manual.tsv.
displays  Replace one flavor's display table from a client build, then write.
write     Regenerate the shipped Lua, for example after editing manual.tsv.

Sources: wowhead-forever wowhead-classic wowhead-tbc wowhead-wotlk wowhead-cata wowhead-mop
         cmangos-classic cmangos-tbc cmangos-wotlk skyfire att
No command uses the network. See tools/object-models/README.md.
"""
from __future__ import annotations

import json
import os
from pathlib import Path
import sqlite3
import subprocess
import sys

import checking
import importing
import models

# The launcher owns Lua discovery, including the bundled interpreters.
sys.path.insert(0, str(models.ROOT / "tools/cli"))
from questiedb import find_lua  # noqa: E402

OUTPUT = models.ROOT / ".out/object-models"
LISTED = 15


def composed_objects(flavors: list[str]) -> importing.Composed:
    """Run objects.lua, which reads the database as a consumer would."""
    lua = find_lua(os.environ.get("LUA") or None, models.ROOT)
    result = subprocess.run([lua, "tools/object-models/objects.lua", *flavors], cwd=models.ROOT,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding="utf-8")
    if result.returncode != 0:
        raise ValueError("objects.lua failed: " + (result.stderr.strip() or result.stdout[-500:]))
    composed: importing.Composed = {flavor: {} for flavor in flavors}
    # Not splitlines(), which also splits on separators that may occur inside names.
    for line in result.stdout.split("\n"):
        if line:
            flavor, object_id, role, name = line.split("\t")
            composed[flavor][int(object_id)] = importing.ComposedObject(name, role)
    for flavor, objects in composed.items():
        if not objects:
            raise ValueError("objects.lua listed no objects for " + flavor)
    return composed


def run_write() -> None:
    _print_written(models.write_files(models.load(models.DATA), {}, models.DATA))


def run_import(source: str, path: Path) -> None:
    data = models.load(models.DATA)
    claims = importing.read_source(path, source)
    rows, result = importing.merge(data.rows, composed_objects(list(models.FLAVORS)), source, claims)
    updated = models.ModelData(rows, data.manual, data.hidden, data.displays)
    written = models.write_files(updated, {models.DATA / "sources.tsv": models.render_sources(rows)}, models.DATA)

    # The full list is for review; names differ far more often than anyone wants to scroll.
    refused = OUTPUT / ("refused-%s.tsv" % source)
    refused.parent.mkdir(parents=True, exist_ok=True)
    refused.write_text("objectId\tsourceName\tvalue\tourName\n" + "".join(
        "%d\t%s\t%d\t%s\n" % entry for entry in result.refused), encoding="utf-8")

    print("%s: %d objects read, %d values added, %d changed, %d refused because the name differs (%s)" % (
        source, len(claims), len(result.added), len(result.changed), len(result.refused), refused))
    for reason, count in sorted(result.skipped.items()):
        print("  skipped %d: %s" % (count, reason))
    _print_some("changed", ["%d: %d -> %d" % entry for entry in result.changed])
    _print_some("left the database or renamed there, values dropped", ["%d %r" % entry for entry in result.removed])
    _print_some("refused", ["%d: %r says %d, ours is %r" % entry for entry in result.refused])
    _print_written(written)


def run_displays(flavor: str, build: str, path: Path) -> None:
    if flavor not in models.FLAVORS:
        raise ValueError("Unknown flavor: " + flavor)
    data = models.load(models.DATA)
    before, after = data.displays[flavor].by_id, importing.read_display_info(path, build)
    updated = models.ModelData(data.rows, data.manual, data.hidden, {**data.displays, flavor: after})
    target = models.DATA / "displays" / (flavor + ".tsv")
    written = models.write_files(updated, {target: models.render_displays(after)}, models.DATA)
    print("%s: %s -> %s, %d displays added, %d removed, %d changed" % (
        flavor, data.displays[flavor].build, build, len(set(after.by_id) - set(before)),
        len(set(before) - set(after.by_id)),
        sum(after.by_id[i] != display for i, display in before.items() if i in after.by_id)))
    _print_written(written)


def run_check(flavors: list[str]) -> int:
    reports = checking.check(models.load(models.DATA), composed_objects(flavors), models.DATA)
    OUTPUT.mkdir(parents=True, exist_ok=True)
    target = OUTPUT / "report.json"
    target.write_text(json.dumps({flavor: vars(report) for flavor, report in reports.items()}, indent=1) + "\n",
                      encoding="utf-8")

    for flavor, report in reports.items():
        details = report.details
        kinds, missing = details["kinds"], details["missingByGroup"]
        print("%-8s %5d objects, %5d with a model, %4d without one in the game, %3d creature or item, %3d hidden" % (
            flavor, details["objects"], kinds.get("file", 0), kinds.get("none", 0),
            kinds.get("creature", 0) + kinds.get("item", 0), kinds.get("hidden", 0)))
        print("         missing: %s; sources disagree on %d (%d quest)" % (
            ", ".join("%d %s" % (missing[role], role) for role in checking.ROLES),
            len(details["disagreements"]), sum(d["group"] == "quest" for d in details["disagreements"])))
        _print_some("warning", report.warnings)
    for flavor, report in reports.items():
        for error in report.errors:
            print("ERROR: %s: %s" % (flavor, error), file=sys.stderr)
    _annotate(reports)
    errors = sum(len(report.errors) for report in reports.values())
    print("%d errors, %d warnings; details in %s" % (
        errors, sum(len(report.warnings) for report in reports.values()), target))
    return 1 if errors else 0


def _annotate(reports: dict[str, checking.FlavorReport]) -> None:
    """Show warnings where they get seen on GitHub, without failing the job.

    One annotation per flavor: a few old gaps on one flavor must not hide a new one on another.
    """
    if os.environ.get("GITHUB_ACTIONS") != "true":
        return
    summary = []
    for flavor, report in reports.items():
        if report.warnings:
            text = "%d object model warnings: %s" % (len(report.warnings), "; ".join(report.warnings[:LISTED]))
            print("::warning title=Object models (%s)::%s" % (flavor, text.replace("%", "%25")))
            summary += ["", "### Object models: " + flavor, "", *("- " + warning for warning in report.warnings)]
    if summary and os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as opened:
            opened.write("\n".join(summary) + "\n")


def _print_some(title: str, lines: list[str]) -> None:
    for line in lines[:LISTED]:
        print("  %s: %s" % (title, line))
    if len(lines) > LISTED:
        print("  ... and %d more" % (len(lines) - LISTED))


def _print_written(paths: list[Path]) -> None:
    for path in paths:
        print("wrote %s (%d KB)" % (path.name, path.stat().st_size // 1024))


def main(args: list[str]) -> int:
    # Names may hold characters that a piped Windows console cannot encode.
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            stream.reconfigure(errors="backslashreplace")
    if not args or args[0] in ("-h", "--help"):
        print(__doc__)
        return 0
    command, *rest = args
    try:
        if command == "check":
            unknown = [flavor for flavor in rest if flavor not in models.FLAVORS]
            if unknown:
                raise ValueError("Unknown flavor: " + unknown[0])
            return run_check(rest or list(models.FLAVORS))
        if command == "import" and len(rest) == 2:
            run_import(rest[0], Path(rest[1]))
        elif command == "displays" and len(rest) == 3:
            run_displays(rest[0], rest[1], Path(rest[2]))
        elif command == "write" and not rest:
            run_write()
        else:
            raise ValueError("invalid arguments; see --help")
    except (OSError, ValueError, sqlite3.Error) as error:
        print("object-models: %s" % error, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
