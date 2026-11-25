#!/usr/bin/env python3
"""Generate the pet food support files from wago.tools DB2 exports.

Usage: questiedb.sh food-type [Vanilla TBC Wrath Forever] [--build FLAVOR=VERSION]

Three facts make up the output: which food type an item is, which food types a pet family eats, and
what the client calls each food type. Families and names come from each flavor's own tables. Among
these flavors only Forever's client says which food type an item is, so the others take its values. For
items Forever does not have, they use the values of a retail test realm (PTR) build, saved beside this
file. See README.md there.
"""
from __future__ import annotations

import argparse
import csv
from dataclasses import dataclass
from functools import lru_cache
from http.client import HTTPException
import io
import json
from pathlib import Path
import sys
from typing import Optional
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[2]
BUILDS_URL = "https://wago.tools/api/builds"
FOOD_COLUMN = "ItemPetFoodID"
MASK_COLUMN = "PetFoodMask"

# ItemPetFood IDs; PetFoodMask bit N-1 stands for food type N.
FOOD_TYPES = {1: "Meat", 2: "Fish", 3: "Cheese", 4: "Bread", 5: "Fungus", 6: "Fruit",
              7: "Raw Meat", 8: "Raw Fish"}
# The PTR's type for mechanical pets, which none of the generated flavors have.
MECHANICAL_BITS = 9
TRANSLATED_LOCALES = ("deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW")

# Every item this build calls food. Live retail 12.1.5 does not have the column, and wago.tools may stop
# offering the build, so the values are kept in version control instead of downloaded.
PTR_BUILD = "12.1.7.71087"
PTR_FILE = Path(__file__).with_name("ptr-item-pet-food.%s.csv" % PTR_BUILD)


@dataclass(frozen=True)
class Flavor:
    """One file to generate. The prefix keeps it on its expansion when wago.tools' product moves on."""

    name: str
    product: str
    prefix: str
    output: str


# Cata and Mists are absent on purpose: patch 4.1.0 removed pet happiness, so nobody has to feed a pet.
FLAVORS = {flavor.name: flavor for flavor in (
    Flavor("Vanilla", "wow_classic_era", "1.15.", "support/PetFood/petFoodClassic.lua"),
    Flavor("TBC", "wow_anniversary", "2.5.", "support/PetFood/petFoodTBC.lua"),
    Flavor("Wrath", "wow_classic_titan", "3.80.", "support/PetFood/petFoodWotlk.lua"),
    Flavor("Forever", "wowf", "1.60.", "support/Forever/PetFood/petFoodForever.lua"),
)}


def table_url(table: str, build: str, locale: str = "enUS") -> str:
    url = "https://wago.tools/db2/%s/csv?build=%s" % (table, build)
    return url if locale == "enUS" else url + "&locale=" + locale


@lru_cache(maxsize=None)
def fetch(url: str) -> bytes:
    """Download one resource once per run, naming it in the error because urllib's message does not."""
    request = Request(url, headers={"User-Agent": "QuestieDB-foodType"})
    try:
        with urlopen(request, timeout=120) as response:
            return response.read()
    except (OSError, HTTPException) as error: # HTTPException covers a truncated body
        raise ValueError("Download failed for %s: %s" % (url, error)) from error


def parse_version(version: str) -> tuple[int, ...]:
    parts = version.split(".")
    if len(parts) != 4 or not all(part.isdigit() for part in parts):
        raise ValueError("Not a full build version such as 1.60.1.71091: " + version)
    return tuple(int(part) for part in parts)


def newest_build(builds: dict, flavor: Flavor) -> str:
    """Pick the numerically newest build of a flavor's product on its own expansion."""
    versions = [entry["version"] for entry in builds.get(flavor.product, ())
                if entry["version"].startswith(flavor.prefix)]
    if not versions:
        raise ValueError("%s: no build starting with '%s' in %s; pin one with --build %s=VERSION"
                         % (flavor.name, flavor.prefix, flavor.product, flavor.name))
    return max(versions, key=parse_version)


def parse_rows(text: str, name: str, columns: tuple[str, ...]) -> list[dict[str, str]]:
    """Read CSV rows, rejecting a table that is incomplete instead of generating shorter lists from it."""
    reader = csv.DictReader(io.StringIO(text))
    missing = [column for column in columns if column not in (reader.fieldnames or ())]
    if missing:
        raise ValueError("%s has no column %s" % (name, ", ".join(missing)))
    rows = list(reader)
    if not rows:
        raise ValueError("%s has no rows" % name)
    if any(None in row or None in row.values() for row in rows):
        raise ValueError("%s has a row of the wrong length" % name)
    return rows


def read_rows(table: str, build: str, columns: tuple[str, ...], locale: str = "enUS") -> list[dict[str, str]]:
    text = fetch(table_url(table, build, locale)).decode("utf-8")
    return parse_rows(text, "%s %s %s" % (table, build, locale), columns)


def to_food_types(rows: list[dict[str, str]], name: str) -> dict[int, int]:
    """Map each item to its food type, 0 when it is not food."""
    types = {int(row["ID"]): int(row[FOOD_COLUMN]) for row in rows}
    unknown = sorted(set(types.values()) - {0, MECHANICAL_BITS} - set(FOOD_TYPES))
    if unknown:
        raise ValueError("%s has unknown food types: %s" % (name, ", ".join(map(str, unknown))))
    return types


def read_food_types(build: str) -> dict[int, int]:
    return to_food_types(read_rows("Item", build, ("ID", FOOD_COLUMN)), "Item " + build)


def read_ptr_food_types() -> dict[int, int]:
    """Read the saved items; unlike a client's table, it holds only those that are food."""
    rows = parse_rows(PTR_FILE.read_text(encoding="utf-8"), PTR_FILE.name, ("ID", FOOD_COLUMN))
    return to_food_types(rows, PTR_FILE.name)


def read_families(build: str) -> dict[int, tuple[str, list[int]]]:
    """Read each family that eats something as its English name and ascending food types."""
    families = {}
    for row in read_rows("CreatureFamily", build, ("ID", "Name_lang", MASK_COLUMN)):
        mask = int(row[MASK_COLUMN])
        if mask >> len(FOOD_TYPES):
            raise ValueError("CreatureFamily %s: %s eats an unknown food type, mask %d"
                             % (build, row["Name_lang"], mask))
        eaten = [food_type for food_type in FOOD_TYPES if mask & (1 << (food_type - 1))]
        if eaten:
            families[int(row["ID"])] = (row["Name_lang"], eaten)
    if not families:
        raise ValueError("CreatureFamily %s has no family that eats anything" % build)
    return families


def read_names(build: str, locale: str) -> dict[int, str]:
    """Read one language's food type names, requiring a different one for every food type."""
    rows = read_rows("ItemPetFood", build, ("ID", "Name_lang"), locale)
    named = [(int(row["ID"]), row["Name_lang"]) for row in rows if int(row["ID"]) in FOOD_TYPES]
    names = dict(named)
    if len(named) != len(FOOD_TYPES) or len(set(names.values()) - {""}) != len(FOOD_TYPES):
        raise ValueError("ItemPetFood %s %s does not name every food type once" % (build, locale))
    return names


def is_translated(names: dict[int, str], english: dict[int, str]) -> bool:
    """Whether the names are translated. wago.tools answers in English for a language an export does not have,
    while a real translation shares only a word or two with English."""
    return sum(names[food_type] == english[food_type] for food_type in FOOD_TYPES) < len(FOOD_TYPES) / 2


def food_type_names(build: str) -> dict[str, int]:
    """Read what the client calls each food type, in every language at once.

    Names are unique across languages, so the consumer does not need to know the client's.
    """
    english = read_names(build, "enUS")
    names = {name: food_type for food_type, name in english.items()}
    for locale in TRANSLATED_LOCALES:
        translation = read_names(build, locale)
        if not is_translated(translation, english):
            raise ValueError("ItemPetFood %s is not translated to %s" % (build, locale))
        for food_type, name in translation.items():
            if names.setdefault(name, food_type) != food_type:
                raise ValueError("ItemPetFood %s: '%s' names two food types" % (build, name))
    return names


def legacy_food_types(build: str, forever_build: str) -> dict[int, int]:
    """Give a flavor's own items Forever's value, or the PTR's for items Forever does not have."""
    values = {**read_ptr_food_types(), **read_food_types(forever_build)}
    own_items = (int(row["ID"]) for row in read_rows("Item", build, ("ID",)))
    return {item_id: values[item_id] for item_id in own_items if item_id in values}


def group_items(types: dict[int, int], build: str) -> dict[int, list[int]]:
    groups = {}
    for item_id, food_type in types.items():
        if food_type in FOOD_TYPES:
            groups.setdefault(food_type, []).append(item_id)
    if not groups:
        raise ValueError("Item %s has no pet food" % build)
    return {food_type: sorted(groups[food_type]) for food_type in sorted(groups)}


def wrap(entries: list[str], width: int = 110) -> list[str]:
    lines = [""]
    for entry in entries:
        piece = entry + ","
        if lines[-1] and len(lines[-1]) + 1 + len(piece) > width:
            lines.append("")
        lines[-1] += (" " if lines[-1] else "") + piece
    return lines


def render(provenance: str, items: dict[int, list[int]], families: dict[int, tuple[str, list[int]]],
           names: dict[str, int]) -> str:
    lines = [
        "-- GENERATED by `questiedb.sh food-type`. Do not edit; rerun the tool instead.",
        *("-- " + line for line in provenance.splitlines()),
        "",
        "---@type QuestieDBPetFood",
        'local PetFood = QuestieLoader:ImportModule("PetFood")',
        "",
        "-- Food type to ascending item IDs.",
        "PetFood.itemIdsByFoodType = {",
    ]
    for food_type, ids in items.items():
        lines.append("    [%d] = { -- %s" % (food_type, FOOD_TYPES[food_type]))
        lines += ["        " + line for line in wrap([str(item_id) for item_id in ids])]
        lines.append("    },")
    lines += ["}", "",
              "-- Creature family ID to the food types its pets eat.",
              "PetFood.foodTypesByFamily = {"]
    for family_id in sorted(families):
        name, eaten = families[family_id]
        lines.append("    [%d] = {%s}, -- %s" % (family_id, ", ".join(map(str, eaten)), name))
    lines += ["}", "",
              "-- Food type name as the client gives it, in any language, to food type. No name means two things.",
              "PetFood.foodTypesByName = {"]
    for food_type in FOOD_TYPES:
        own = sorted(name for name, named_type in names.items() if named_type == food_type)
        # A JSON string is also a Lua string for these names.
        lines += ["    " + line for line in wrap(["[%s] = %d" % (json.dumps(name, ensure_ascii=False), food_type)
                                                  for name in own])]
    lines += ["}", ""]
    return "\n".join(lines)


def generate(name: str, builds: dict[str, str]) -> str:
    build = builds[name]
    if name == "Forever":
        types = read_food_types(build)
        provenance = "Food types: Item %s." % build
    else:
        types = legacy_food_types(build, builds["Forever"])
        provenance = ("Items: Item %s.\nFood types: Item %s (Forever), or Item %s (retail PTR) for items missing there."
                      % (build, builds["Forever"], PTR_BUILD))
    provenance += "\nFamilies: CreatureFamily %s. Names: ItemPetFood %s." % (build, build)
    return render(provenance, group_items(types, build), read_families(build), food_type_names(build))


def parse_pin(value: str) -> tuple[str, str]:
    name, _, version = value.partition("=")
    if name not in FLAVORS:
        raise argparse.ArgumentTypeError("no pet food for %s; use %s" % (name, ", ".join(FLAVORS)))
    try:
        parse_version(version)
    except ValueError as error:
        raise argparse.ArgumentTypeError(str(error)) from error
    if not version.startswith(FLAVORS[name].prefix):
        raise argparse.ArgumentTypeError("%s builds start with %s, not %s" % (name, FLAVORS[name].prefix, version))
    return name, version


def main(argv: Optional[list[str]] = None) -> int:
    parser = argparse.ArgumentParser(prog="questiedb.sh food-type", description=__doc__.splitlines()[0])
    parser.add_argument("flavors", nargs="*", metavar="FLAVOR",
                        help="flavors to generate, default all: " + ", ".join(FLAVORS))
    parser.add_argument("--build", action="append", default=[], type=parse_pin, metavar="FLAVOR=VERSION",
                        help="use this build instead of the flavor's newest")
    options = parser.parse_args(argv)
    unknown = [name for name in options.flavors if name not in FLAVORS]
    if unknown:
        parser.error("no pet food for %s; use %s" % (", ".join(unknown), ", ".join(FLAVORS)))
    names = list(dict.fromkeys(options.flavors or FLAVORS))

    try:
        builds = dict(options.build)
        # Every flavor takes food types from Forever's client.
        unpinned = [name for name in dict.fromkeys(names + ["Forever"]) if name not in builds]
        if unpinned:
            published = json.loads(fetch(BUILDS_URL))
            builds.update({name: newest_build(published, FLAVORS[name]) for name in unpinned})
        # Render everything first, so a bad table never leaves the flavors at different builds.
        outputs = {FLAVORS[name].output: generate(name, builds) for name in names}
    except ValueError as error:
        print("food-type: %s" % error, file=sys.stderr)
        return 1

    for relative, text in outputs.items():
        path = ROOT / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(text.encode("utf-8"))
        print("Wrote " + relative)
    return 0


if __name__ == "__main__":
    sys.exit(main())
