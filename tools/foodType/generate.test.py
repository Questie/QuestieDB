#!/usr/bin/env python3
"""Pet food generator tests; every wago.tools response is a fixture, nothing touches the network."""
import io
import json
from pathlib import Path
import tempfile
import unittest
from contextlib import redirect_stderr, redirect_stdout
from http.client import IncompleteRead
from unittest.mock import patch
from urllib.error import HTTPError

import generate

BUILDS_URL = "https://wago.tools/api/builds"
BUILDS = {
    "wow_classic_era": [{"version": "1.15.9.70576"}, {"version": "1.15.10.100"}],
    # Anniversary has moved on to Wrath here, so TBC must stay on its last TBC build.
    "wow_anniversary": [{"version": "3.4.5.80000"}, {"version": "2.5.6.70577"}],
    "wow_classic_titan": [{"version": "3.80.2.70522"}, {"version": "4.80.0.1"}],
    "wowf": [{"version": "1.60.1.71091"}, {"version": "1.60.1.9999"}],
}
FOREVER = "1.60.1.71091"
VANILLA = "1.15.10.100"

TABLES = {
    ("Item", FOREVER): "ID,ItemPetFoodID\n100,1\n101,4\n103,0\n104,3\n107,0\n",
    # Vanilla has no food column. It lacks 105, so the PTR's fruit must not leak in. Nobody knows 106.
    ("Item", VANILLA): "ID,ClassID\n104,0\n100,0\n9,0\n101,0\n102,7\n103,4\n106,0\n107,0\n",
    ("CreatureFamily", VANILLA): "ID,Name_lang,PetFoodMask\n2,Cat,3\n1,Wolf,1\n23,Imp,0\n8,Crab,178\n",
    ("CreatureFamily", FOREVER): "ID,Name_lang,PetFoodMask\n1,Wolf,1\n",
}
# Forever does not have 9, 102 and 105, and disagrees about 101 and 107.
PTR_ITEMS = "ID,ItemPetFoodID\n9,1\n101,2\n102,9\n105,6\n107,1\n"
ENGLISH = {"Meat": 1, "Fish": 2, "Cheese": 3, "Bread": 4, "Fungus": 5, "Fruit": 6, "Raw Meat": 7, "Raw Fish": 8}


# Every client language but English, listed here so that the generator cannot drop one unnoticed.
LANGUAGES = ("deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW")


def names_csv(names):
    return "Name_lang,ID\n" + "".join('"%s",%d\n' % (name, food_type) for name, food_type in names.items())


def translated(locale):
    """Distinct names per language, so a test can tell which export a name came from."""
    return {locale + " " + name: food_type for name, food_type in ENGLISH.items()}


for build in (FOREVER, VANILLA):
    for locale in ("enUS",) + LANGUAGES:
        TABLES[("ItemPetFood", build, locale)] = names_csv(ENGLISH if locale == "enUS" else translated(locale))


def wago_url(table, build, locale="enUS"):
    """The address wago.tools documents, written out here because it answers an unknown parameter with another build."""
    url = "https://wago.tools/db2/%s/csv?build=%s" % (table, build)
    return url if locale == "enUS" else url + "&locale=" + locale


class FakeWago:
    """Stands in for urlopen; records every URL so tests can prove what was fetched."""

    def __init__(self, tables=None, builds=None):
        self.tables = dict(TABLES if tables is None else tables)
        self.builds = BUILDS if builds is None else builds
        self.urls = []

    def __call__(self, request, timeout=None):
        url = request.full_url
        self.urls.append(url)
        if url == BUILDS_URL:
            return io.BytesIO(json.dumps(self.builds).encode())
        for key, text in self.tables.items():
            if url == wago_url(*key):
                return io.BytesIO(text.encode())
        raise HTTPError(url, 404, "not found", {}, None)


class FoodTypeTest(unittest.TestCase):
    def setUp(self):
        generate.fetch.cache_clear()
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.root = Path(temp.name)
        self.ptr_file = self.root / "ptr.csv"
        self.ptr_file.write_text(PTR_ITEMS)

    def use(self, wago):
        transport = patch.object(generate, "urlopen", wago)
        transport.start()
        self.addCleanup(transport.stop)
        return wago

    def run_cli(self, *args):
        out, err = io.StringIO(), io.StringIO()
        with patch.object(generate, "ROOT", self.root), patch.object(generate, "PTR_FILE", self.ptr_file), \
                redirect_stdout(out), redirect_stderr(err):
            code = generate.main(list(args))
        return code, out.getvalue(), err.getvalue()

    def test_build_selection_compares_numbers_and_stays_on_the_flavors_own_expansion(self):
        # 1.15.10 is newer than 1.15.9 and 71091 than 9999, which plain string order gets wrong.
        self.assertEqual(VANILLA, generate.newest_build(BUILDS, generate.FLAVORS["Vanilla"]))
        self.assertEqual("2.5.6.70577", generate.newest_build(BUILDS, generate.FLAVORS["TBC"]))
        self.assertEqual("3.80.2.70522", generate.newest_build(BUILDS, generate.FLAVORS["Wrath"]))
        self.assertEqual(FOREVER, generate.newest_build(BUILDS, generate.FLAVORS["Forever"]))

    def test_build_selection_reports_a_product_without_a_matching_build(self):
        with self.assertRaisesRegex(ValueError, "TBC.*2.5"):
            generate.newest_build({"wow_anniversary": [{"version": "3.4.5.1"}]}, generate.FLAVORS["TBC"])

    def test_legacy_flavor_takes_forevers_values_and_the_ptrs_for_items_forever_does_not_have(self):
        self.use(FakeWago())
        code, _, err = self.run_cli("Vanilla")
        self.assertEqual(0, code, err)
        text = (self.root / "support/PetFood/petFoodClassic.lua").read_text()
        # Only the PTR knows 9. Forever wins for 101, and for 107 by calling it no food. The PTR's
        # 105 is not in this client, and 102 (Mechanical Bits) is not a food any of these pets eats.
        self.assertEqual({1: [9, 100], 3: [104], 4: [101]}, parse_lists(text, "itemIdsByFoodType"))

    def test_family_masks_become_food_type_lists(self):
        self.use(FakeWago())
        self.run_cli("Vanilla")
        text = (self.root / "support/PetFood/petFoodClassic.lua").read_text()
        # 178 is bits 2, 5, 6 and 8: Fish, Fungus, Fruit and Raw Fish. The Imp eats nothing.
        self.assertEqual({1: [1], 2: [1, 2], 8: [2, 5, 6, 8]}, parse_lists(text, "foodTypesByFamily"))

    def test_forever_takes_everything_from_its_own_tables(self):
        wago = self.use(FakeWago())
        self.ptr_file.unlink()
        code, _, err = self.run_cli("Forever")
        self.assertEqual(0, code, err)
        text = (self.root / "support/Forever/PetFood/petFoodForever.lua").read_text()
        self.assertEqual({1: [100], 3: [104], 4: [101]}, parse_lists(text, "itemIdsByFoodType"))
        tables = [url for url in wago.urls if url != BUILDS_URL]
        self.assertTrue(tables)
        self.assertFalse([url for url in tables if FOREVER not in url])

    def test_names_cover_every_language(self):
        self.use(FakeWago())
        self.assertEqual(0, self.run_cli("Vanilla")[0])
        expected = dict(ENGLISH)
        for locale in LANGUAGES:
            expected.update(translated(locale))
        text = (self.root / "support/PetFood/petFoodClassic.lua").read_text(encoding="utf-8")
        self.assertEqual(expected, parse_names(text))

    def test_names_keep_characters_outside_ascii(self):
        chinese = {**translated("zhCN"), "\u8089": 1, "\u9c7c": 2}
        del chinese["zhCN Meat"], chinese["zhCN Fish"]
        self.use(FakeWago({**TABLES, ("ItemPetFood", FOREVER, "zhCN"): names_csv(chinese)}))
        self.assertEqual(0, self.run_cli("Forever")[0])
        names = parse_names((self.root / "support/Forever/PetFood/petFoodForever.lua").read_text(encoding="utf-8"))
        self.assertEqual(1, names["\u8089"])
        self.assertEqual(2, names["\u9c7c"])

    def test_a_language_the_export_does_not_have_is_an_error(self):
        # wago.tools answers in English then, so a table in English is a missing one.
        mostly_english = {**ENGLISH, "Fleisch": 1}
        del mostly_english["Meat"]
        for problem, names in (("English", ENGLISH), ("one row translated", mostly_english)):
            with self.subTest(problem):
                generate.fetch.cache_clear()
                self.use(FakeWago({**TABLES, ("ItemPetFood", FOREVER, "deDE"): names_csv(names)}))
                code, _, err = self.run_cli("Forever")
                self.assertEqual(1, code)
                self.assertIn("deDE", err)

    def test_one_name_for_two_food_types_in_different_languages_is_an_error(self):
        german = {**translated("deDE"), "Cheese": 2}
        del german["deDE Fish"]
        self.use(FakeWago({**TABLES, ("ItemPetFood", FOREVER, "deDE"): names_csv(german)}))
        code, _, err = self.run_cli("Forever")
        self.assertEqual(1, code)
        self.assertIn("Cheese", err)

    def test_a_language_may_share_a_word_with_english(self):
        german = {**translated("deDE"), "Fungus": 5, "Fruit": 6}
        del german["deDE Fungus"], german["deDE Fruit"]
        self.use(FakeWago({**TABLES, ("ItemPetFood", FOREVER, "deDE"): names_csv(german)}))
        self.assertEqual(0, self.run_cli("Forever")[0])
        names = parse_names((self.root / "support/Forever/PetFood/petFoodForever.lua").read_text(encoding="utf-8"))
        self.assertEqual(1, names["deDE Meat"])

    def test_a_language_that_does_not_name_every_food_type_once_is_an_error(self):
        complete = names_csv(translated("deDE"))
        for problem, text in (
            ("no rows", "Name_lang,ID\n"),
            ("one type missing", complete.replace('"deDE Fruit",6\n', "")),
            ("one type twice", complete + '"deDE Apple",6\n'),
            ("one name twice", complete.replace('"deDE Raw Meat",7', '"deDE Meat",7')),
            ("empty name", complete.replace('"deDE Fruit",6', '"",6')),
        ):
            with self.subTest(problem):
                generate.fetch.cache_clear()
                self.use(FakeWago({**TABLES, ("ItemPetFood", FOREVER, "deDE"): text}))
                code, _, err = self.run_cli("Forever")
                self.assertEqual(1, code)
                self.assertIn("deDE", err)

    def test_generated_file_names_its_builds(self):
        self.use(FakeWago())
        self.run_cli("Vanilla")
        header = (self.root / "support/PetFood/petFoodClassic.lua").read_text().split("local PetFood")[0]
        for build in (VANILLA, FOREVER, generate.PTR_BUILD):
            self.assertIn(build, header)

    def test_a_pinned_build_is_used_and_needs_no_build_list(self):
        wago = self.use(FakeWago())
        code, _, err = self.run_cli("Forever", "--build", "Forever=" + FOREVER)
        self.assertEqual(0, code, err)
        self.assertNotIn(BUILDS_URL, wago.urls)

    def test_a_long_list_keeps_every_item_when_it_is_wrapped(self):
        meat = list(range(1000, 1100)) + list(range(200000, 200100))
        tables = dict(TABLES)
        tables[("Item", FOREVER)] = "ID,ItemPetFoodID\n" + "".join("%d,1\n" % item_id for item_id in meat)
        self.use(FakeWago(tables))
        self.assertEqual(0, self.run_cli("Forever")[0])
        text = (self.root / "support/Forever/PetFood/petFoodForever.lua").read_text()
        self.assertEqual({1: meat}, parse_lists(text, "itemIdsByFoodType"))
        self.assertLess(max(map(len, text.splitlines())), 125)

    def test_each_table_is_downloaded_once_per_run(self):
        wago = self.use(FakeWago())
        self.assertEqual(0, self.run_cli("Vanilla", "Forever")[0])
        self.assertEqual(sorted(set(wago.urls)), sorted(wago.urls))

    def test_a_table_without_an_expected_column_stops_before_anything_is_written(self):
        tables = dict(TABLES)
        tables[("CreatureFamily", VANILLA)] = "ID,Name_lang\n1,Wolf\n"
        self.use(FakeWago(tables))
        code, _, err = self.run_cli("Forever", "Vanilla")
        self.assertEqual(1, code)
        self.assertIn("PetFoodMask", err)
        self.assertFalse((self.root / "support").exists(), "Forever must not be written either")

    def test_a_bad_table_is_an_error(self):
        for name, table, text, message in (
            ("error page", "CreatureFamily", "<!doctype html><html></html>", "no column"),
            ("empty", "Item", "ID,ItemPetFoodID\n", "no rows"),
            ("short row", "Item", "ID,ItemPetFoodID\n100,1\n101", "wrong length"),
            ("long row", "Item", "ID,ItemPetFoodID\n100,1\n101,1,1", "wrong length"),
            ("no families", "CreatureFamily", "ID,Name_lang,PetFoodMask\n23,Imp,0\n", "no family"),
            ("diet with Mechanical Bits", "CreatureFamily", "ID,Name_lang,PetFoodMask\n1,Wolf,1\n303,Mechanical,256\n", "Mechanical"),
        ):
            with self.subTest(name):
                generate.fetch.cache_clear()
                self.use(FakeWago({**TABLES, (table, FOREVER): text}))
                code, _, err = self.run_cli("Forever")
                self.assertEqual(1, code)
                self.assertIn(table, err)
                self.assertIn(message, err)
                self.assertFalse((self.root / "support").exists())

    def test_a_damaged_saved_ptr_file_is_an_error(self):
        for problem, text in (("empty", "ID,ItemPetFoodID\n"), ("merge conflict", "<<<<<<< HEAD\n" + PTR_ITEMS),
                              ("unknown food type", PTR_ITEMS + "200,42\n"), ("cut off", PTR_ITEMS + "200")):
            with self.subTest(problem):
                generate.fetch.cache_clear()
                self.ptr_file.write_text(text)
                self.use(FakeWago())
                code, _, err = self.run_cli("Vanilla")
                self.assertEqual(1, code)
                self.assertIn(self.ptr_file.name, err)
                self.assertFalse((self.root / "support").exists())

    def test_the_saved_ptr_file_is_the_whole_download(self):
        self.assertTrue(generate.PTR_FILE.name.endswith(generate.PTR_BUILD + ".csv"))
        types = generate.read_ptr_food_types()
        self.assertEqual(1859, len(types))
        # Dried Mushroom Rations, Salted Venison, Steaming Chicken Soup, Bronze Tube (Mechanical Bits)
        self.assertEqual([5, 1, 4, 9], [types[item_id] for item_id in (24008, 33454, 42779, 4371)])

    def test_a_download_that_breaks_off_is_an_error(self):
        class Response(io.BytesIO):
            def read(self, *args):
                raise IncompleteRead(b"ID,ItemPetFoodID")

        self.use(lambda request, timeout=None: Response())
        code, _, err = self.run_cli("Forever", "--build", "Forever=" + FOREVER)
        self.assertEqual(1, code)
        self.assertIn(FOREVER, err)

    def test_an_unknown_food_type_is_an_error_rather_than_a_silent_drop(self):
        tables = dict(TABLES)
        tables[("Item", FOREVER)] = "ID,ItemPetFoodID\n100,1\n101,42\n"
        self.use(FakeWago(tables))
        code, _, err = self.run_cli("Forever")
        self.assertEqual(1, code)
        self.assertIn("42", err)

    def test_a_table_where_no_item_is_food_is_an_error(self):
        tables = dict(TABLES)
        tables[("Item", FOREVER)] = "ID,ItemPetFoodID\n100,0\n"
        self.use(FakeWago(tables))
        code, _, err = self.run_cli("Forever")
        self.assertEqual(1, code)
        self.assertIn("no pet food", err)

    def test_a_missing_build_reports_the_table_and_build(self):
        self.use(FakeWago())
        code, _, err = self.run_cli("Forever", "--build", "Forever=1.60.9.1")
        self.assertEqual(1, code)
        self.assertIn("1.60.9.1", err)

    def test_bad_arguments_are_rejected(self):
        for args in (("Cata",), ("--build", "Forever"), ("--build", "Nowhere=1.2.3.4"),
                     ("--build", "Forever=latest"), ("--build", "Vanilla=2.5.6.70577")):
            with self.subTest(args=args), self.assertRaises(SystemExit):
                self.run_cli(*args)


def parse_names(text):
    """Read `PetFood.foodTypesByName` back without sharing the generator's formatting code."""
    body = text.split("PetFood.foodTypesByName = {", 1)[1].split("\n}", 1)[0]
    names = {}
    for line in body.splitlines():
        for part in line.split(","):
            if part.strip():
                key, value = part.rsplit("=", 1)
                names[key.strip()[2:-2]] = int(value)
    return names


def parse_lists(text, name):
    """Read one `PetFood.<name>` table back without sharing the generator's formatting code."""
    body = text.split("PetFood." + name + " = {", 1)[1].split("\n}", 1)[0]
    lists, key = {}, None
    for line in body.splitlines():
        line = line.split("--", 1)[0].strip()
        if line.startswith("["):
            key = int(line[1:line.index("]")])
            lists[key] = []
            line = line.split("=", 1)[1]
        lists.setdefault(key, []).extend(int(part) for part in line.replace("{", " ").replace("}", " ")
                                         .replace(",", " ").split())
    lists.pop(None, None)
    return lists


if __name__ == "__main__":
    unittest.main()
