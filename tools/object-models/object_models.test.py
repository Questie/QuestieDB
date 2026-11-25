"""Object-model data, import and check. Run with uv run tools/object-models/object_models.test.py.

Fixtures are small literal tables. Only RealDataTest reads the committed files and database.
"""
import contextlib
import copy
import io
import json
from pathlib import Path
import re
import sqlite3
import tempfile
import unittest
from unittest.mock import patch

import checking
import importing
import models
import object_models
from importing import Claim, ComposedObject
from models import Display, Displays, ManualRow, ObjectRow

# Display 10 and 20 are models, 30 a creature, 40 an item, 50 has no file, 60 is invisible.
DISPLAYS = Displays("1.60.1.71091", {
    10: Display("file", 1010), 20: Display("file", 2020), 30: Display("creature", 777),
    40: Display("item", 888), 50: Display("none", 0), 60: Display("file", 6060),
})


def row(object_id, name="Thing", flavors=("Forever",), **claims):
    return ObjectRow(object_id, name, frozenset(flavors),
                     {source.replace("_", "-"): value for source, value in claims.items()})


BUILDS = {"Vanilla": "1.15.9.70576", "TBC": "2.5.6.70577", "Wrath": "3.80.2.70522", "Cata": "4.4.2.60895",
          "Mists": "5.5.4.71089", "Forever": "1.60.1.71091"}


def displays_of(flavor):
    return Displays(BUILDS[flavor], DISPLAYS.by_id)


def model_data(*rows, manual=()):
    return models.ModelData(list(rows), list(manual), {6060: "invisible"},
                            {flavor: displays_of(flavor) for flavor in models.FLAVORS})


def manual(object_id, display_id, flavors=("Forever",)):
    return ManualRow(object_id, frozenset(flavors), display_id, "reviewed")


def composed(**flavors):
    return {flavor: {object_id: ComposedObject(*values) for object_id, values in flavors.get(flavor, {}).items()}
            for flavor in models.FLAVORS}


class ResolveTest(unittest.TestCase):
    def test_manual_row_wins_over_sources_that_agree(self):
        data = model_data(row(1, wowhead_forever=10, cmangos_classic=10, att=1010), manual=[manual(1, 20)])
        self.assertEqual(models.Model("file", 2020, "manual"), data.resolve("Forever", 1))

    def test_manual_zero_means_no_model_and_is_not_a_gap(self):
        data = model_data(row(1, wowhead_forever=10), manual=[manual(1, 0)])
        self.assertEqual("none", data.resolve("Forever", 1).kind)

    def test_manual_row_only_covers_its_flavors(self):
        data = model_data(row(1, flavors=("Vanilla", "Forever"), cmangos_classic=10), manual=[manual(1, 20)])
        self.assertEqual(2020, data.resolve("Forever", 1).id)
        self.assertEqual(1010, data.resolve("Vanilla", 1).id)

    def test_own_source_beats_fallback_and_allthethings(self):
        data = model_data(row(1, wowhead_forever=20, cmangos_classic=10, att=1010))
        self.assertEqual(models.Model("file", 2020, "wowhead-forever"), data.resolve("Forever", 1))

    def test_unusable_and_zero_values_fall_through_to_the_next_source(self):
        # Display 5 is no longer in the client, as Classic's 349 on Forever.
        data = model_data(row(1, wowhead_forever=0, cmangos_classic=5, att=1010))
        self.assertEqual(models.Model("file", 1010, "att"), data.resolve("Forever", 1))

    def test_display_newer_than_the_client_table_is_not_guessed_from_another_expansion(self):
        model = model_data(row(1, wowhead_forever=61, cmangos_classic=10, att=1010)).resolve("Forever", 1)
        self.assertEqual(("missing", "display 61 is newer than 1.60.1.71091; update the displays"),
                         (model.kind, model.reason))

    def test_display_without_a_file_is_unusable(self):
        model = model_data(row(1, wowhead_forever=50)).resolve("Forever", 1)
        self.assertEqual(("missing", "display 50 is not in 1.60.1.71091"), (model.kind, model.reason))

    def test_allthethings_file_must_exist_in_the_flavors_client(self):
        model = model_data(row(1, att=123456)).resolve("Forever", 1)
        self.assertEqual(("missing", "file 123456 is not in 1.60.1.71091"), (model.kind, model.reason))

    def test_first_unusable_value_is_the_reported_reason(self):
        self.assertEqual("display 5 is not in 1.60.1.71091",
                         model_data(row(1, wowhead_forever=5, cmangos_classic=6)).resolve("Forever", 1).reason)

    def test_unknown_object_is_missing_but_one_without_a_display_is_not(self):
        data = model_data(row(2, wowhead_forever=0, cmangos_classic=0))
        self.assertEqual(models.Model("missing", reason="no source"), data.resolve("Forever", 1))
        self.assertEqual(models.Model("none", source="wowhead-forever"), data.resolve("Forever", 2))

    def test_reviewed_row_works_for_an_object_no_source_knows(self):
        data = model_data(manual=[manual(9, 20)])
        self.assertEqual(2020, data.resolve("Forever", 9).id)
        self.assertIn("[[\n2020:9\n]]\n", models.render(data, "Forever"))
        self.assertIn("[[\n]]\n", models.render(data, "Vanilla"))

    def test_creature_item_and_hidden_displays_never_become_a_model(self):
        data = model_data(row(1, wowhead_forever=30), row(2, wowhead_forever=40), row(3, wowhead_forever=60))
        self.assertEqual(["creature", "item", "hidden"], [data.resolve("Forever", i).kind for i in (1, 2, 3)])
        self.assertIn("objectsByFileId = [[\n]]", models.render(data, "Forever"))

    def test_source_of_another_flavor_is_not_used(self):
        self.assertEqual("missing", model_data(row(1, wowhead_classic=10)).resolve("Forever", 1).kind)

    def test_disagreement_compares_the_choice_with_own_sources_and_allthethings(self):
        rows = [row(1, "Chest", ("Vanilla",), wowhead_classic=10, cmangos_classic=20),
                row(2, "Altar", ("Vanilla",), cmangos_classic=10, cmangos_wotlk=20),
                row(3, "Trap", ("Cata",), skyfire=10, att=2020)]
        data = model_data(*rows)
        self.assertEqual({"wowhead-classic": 1010, "cmangos-classic": 2020}, data.disagreement("Vanilla", 1))
        self.assertEqual({}, data.disagreement("Vanilla", 2))  # another expansion may differ
        self.assertEqual({"skyfire": 1010, "att": 2020}, data.disagreement("Cata", 3))  # chosen from a fallback
        self.assertEqual({}, model_data(*rows, manual=[manual(1, 10, ("Vanilla",))]).disagreement("Vanilla", 1))


class RenderTest(unittest.TestCase):
    def test_groups_objects_by_model_and_keeps_flavors_apart(self):
        data = model_data(row(7, wowhead_forever=20), row(3, wowhead_forever=10), row(5, wowhead_forever=20),
                          row(9, flavors=("Vanilla",), wowhead_classic=10))
        self.assertIn("[[\n1010:3\n2020:5,7\n]]\n", models.render(data, "Forever"))
        self.assertIn("[[\n1010:9\n]]\n", models.render(data, "Vanilla"))


class MergeTest(unittest.TestCase):
    def merge(self, rows, source, claims, names=None):
        names = names or {1: ("Campfire", "other")}
        flavors = models.SOURCE_ORDER
        users = [flavor for flavor in models.FLAVORS if source in flavors[flavor].all]
        return importing.merge(rows, composed(**{flavor: names for flavor in users}), source, claims)

    def test_fills_gaps_and_reports_changes(self):
        rows, result = self.merge([], "wowhead-forever", {1: Claim(10, "campfire!")})
        self.assertEqual([(1, 10)], result.added)
        rows, result = self.merge(rows, "wowhead-forever", {1: Claim(20, "Campfire")})
        self.assertEqual([(1, 10, 20)], result.changed)
        self.assertEqual({"wowhead-forever": 20}, rows[0].claims)

    def test_partial_export_keeps_known_values(self):
        rows, _ = self.merge([], "wowhead-forever", {1: Claim(10, "Campfire")})
        rows, _ = self.merge(rows, "wowhead-forever", {})
        self.assertEqual({"wowhead-forever": 10}, rows[0].claims)

    def test_other_name_is_refused_and_leaves_no_row(self):
        rows, result = self.merge([], "att", {1: Claim(1010, "Owl Statue")})
        self.assertEqual([], rows)
        self.assertEqual([(1, "Owl Statue", 1010, "Campfire")], result.refused)

    def test_id_shared_by_two_objects_reaches_only_the_named_one(self):
        # 410020 is a real object of Season of Discovery, and an invented one from TBC on.
        database = composed(Vanilla={410020: ("Owl Statue", "quest")}, TBC={410020: ("Blackhoof Cage", "objective")})
        rows, result = importing.merge([], database, "att", {410020: Claim(2020, "Owl Statue")})
        data = model_data(*rows)
        self.assertEqual(2020, data.resolve("Vanilla", 410020).id)
        self.assertEqual("missing", data.resolve("TBC", 410020).kind)
        self.assertEqual([(410020, "Owl Statue", 2020, "Blackhoof Cage")], result.refused)

    def test_placeholders_are_skipped_only_where_they_mean_nothing(self):
        objects = {1: ("Campfire", "other"), 19519: ("Human Statue", "other"), 2: ("unk name", "other")}
        for source, object_id, claim, taken in (
                ("skyfire", 1, Claim(474, "Campfire"), False), ("skyfire", 1, Claim(299, "Campfire"), False),
                ("skyfire", 1, Claim(2350, "Campfire"), False), ("cmangos-wotlk", 1, Claim(474, "Campfire"), True),
                ("skyfire", 2, Claim(10, "unk name"), False),
                ("skyfire", 19519, Claim(9519, "Human Statue"), False),
                ("cmangos-tbc", 19519, Claim(9519, "Human Statue"), False),
                ("wowhead-tbc", 19519, Claim(9519, "Human Statue"), True)):
            with self.subTest(source=source, claim=claim):
                rows, result = self.merge([], source, {object_id: claim}, objects)
                self.assertEqual((taken, not taken), (bool(rows), result.skipped["placeholder"] == 1))

    def test_object_that_left_the_database_is_dropped_and_reported(self):
        rows, _ = self.merge([], "wowhead-forever", {1: Claim(10, "Campfire")})
        rows, result = self.merge(rows, "wowhead-forever", {}, {2: ("Chest", "other")})
        self.assertEqual(([], [(1, "Campfire")]), (rows, result.removed))

    def test_dropped_row_is_reported_even_when_its_id_survives_elsewhere(self):
        both = composed(Vanilla={1: ("Owl Statue", "quest")}, TBC={1: ("Cage", "objective")})
        rows, _ = importing.merge([], both, "att", {1: Claim(2020, "Owl Statue")})
        rows, result = importing.merge(rows, composed(TBC={1: ("Cage", "objective")}), "att", {})
        self.assertEqual(([], [(1, "Owl Statue")]), (rows, result.removed))

    def test_renamed_object_loses_its_values_and_is_reported(self):
        rows, _ = self.merge([], "wowhead-forever", {1: Claim(10, "Campfire")})
        rows, result = self.merge(rows, "wowhead-forever", {}, {1: ("Owl Statue", "other")})
        self.assertEqual(([], [(1, "Campfire")]), (rows, result.removed))

    def test_renaming_one_flavor_leaves_the_others_alone(self):
        rows, _ = importing.merge([], composed(Vanilla={1: ("Owl", "other")}, TBC={1: ("Owl", "other")}), "att",
                                  {1: Claim(2020, "Owl")})
        rows, _ = importing.merge(rows, composed(Vanilla={1: ("Owl", "other")}, TBC={1: ("Cage", "other")}), "att", {})
        data = model_data(*rows)
        self.assertEqual(("file", "missing"), (data.resolve("Vanilla", 1).kind, data.resolve("TBC", 1).kind))

    def test_flavor_that_gains_the_object_shares_its_values(self):
        rows, _ = importing.merge([], composed(Vanilla={1: ("Owl", "other")}), "att", {1: Claim(2020, "Owl")})
        rows, _ = importing.merge(rows, composed(Vanilla={1: ("Owl", "other")}, TBC={1: ("owl", "other")}), "att", {})
        self.assertEqual("file", model_data(*rows).resolve("TBC", 1).kind)

    def test_spelling_change_keeps_the_values(self):
        rows, _ = self.merge([], "wowhead-forever", {1: Claim(10, "Campfire")})
        rows, result = self.merge(rows, "wowhead-forever", {}, {1: ("Camp Fire", "other")})
        self.assertEqual(([("Camp Fire", {"wowhead-forever": 10})], []), ([(r.name, r.claims) for r in rows], result.removed))

    def test_object_without_a_name_accepts_any(self):
        rows, _ = self.merge([], "wowhead-forever", {1: Claim(10, "Anything")}, {1: ("", "drop")})
        self.assertEqual({"wowhead-forever": 10}, rows[0].claims)


class ReaderTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="object models ")
        self.addCleanup(self.temporary.cleanup)
        self.directory = Path(self.temporary.name)

    def write(self, name, text):
        path = self.directory / name
        path.write_text(text, encoding="utf-8")
        return path

    def database(self, name, *statements):
        path = self.directory / name
        connection = sqlite3.connect(path)
        for statement, *values in statements:
            connection.execute(statement, values)
        connection.commit()
        connection.close()
        return path

    def test_csv_skips_objects_without_a_display_and_keeps_zero(self):
        path = self.write("a.csv", "objectId,displayId,name\n1,10,Camp\n2,,Chest\n3,0,Trap\n")
        self.assertEqual({1: Claim(10, "Camp"), 3: Claim(0, "Trap")}, importing.read_source(path, "skyfire"))

    def test_allthethings_csv_must_hold_file_ids(self):
        path = self.write("a.csv", "objectId,displayId,name\n1,10,Camp\n")
        with self.assertRaisesRegex(ValueError, "missing columns fileDataId"):
            importing.read_source(path, "att")

    def test_bad_csv_cells_fail_with_their_line(self):
        for line, message in (("1,-1,Camp", "a.csv:3: -1 is not a display"), ("1,x,Camp", "a.csv:3: invalid literal"),
                              ("1", "a.csv:3: wrong number of cells"), ("1,2,Camp,4", "wrong number of cells")):
            with self.subTest(line=line), self.assertRaisesRegex(ValueError, message):
                importing.read_source(self.write("a.csv", "objectId,displayId,name\n7,0,Ok\n%s\n" % line), "skyfire")

    def cmangos(self, repository, *rows):
        columns = "entry INTEGER, type INTEGER, displayId INTEGER, name TEXT, data3 INTEGER, data6 INTEGER, data8 INTEGER"
        return self.database(
            "c.db", ["CREATE TABLE artifact_metadata (key TEXT, value TEXT)"],
            ["INSERT INTO artifact_metadata VALUES ('cmangos_db_repo', ?)", repository],
            ["CREATE TABLE gameobject_template (%s)" % columns],
            *[["INSERT INTO gameobject_template VALUES (?, ?, ?, ?, ?, ?, ?)", *row] for row in rows])

    def test_cmangos_release(self):
        path = self.cmangos("https://github.com/cmangos/classic-db.git", (31, 2, 6, "Old Lion Statue", 1, 1, 1))
        self.assertEqual({31: Claim(6, "Old Lion Statue")}, importing.read_source(path, "cmangos-classic"))

    def test_objects_players_never_see_have_no_display(self):
        path = self.cmangos("cmangos/classic-db", (1, 8, 299, "Focus", 1, 0, 0), (2, 8, 10, "Moonwell", 0, 1, 1),
                            (3, 6, 299, "Trap", 0, 0, 1), (4, 6, 10, "Bear Trap", 1, 1, 0), (5, 30, 299, "Aura", 0, 1, 0))
        self.assertEqual({1: 0, 2: 10, 3: 0, 4: 10, 5: 0}, {
            object_id: claim.value for object_id, claim in importing.read_source(path, "cmangos-classic").items()})

    def test_cmangos_release_without_a_display_value_fails(self):
        path = self.cmangos("https://github.com/cmangos/classic-db.git", (31, 2, None, "Old Lion Statue", 0, 0, 0))
        with self.assertRaisesRegex(ValueError, "None is not a display"):
            importing.read_source(path, "cmangos-classic")

    def test_mixed_up_databases_are_refused(self):
        path = self.cmangos("https://github.com/cmangos/tbc-db.git")
        with self.assertRaisesRegex(ValueError, "expected a release of cmangos/wotlk-db, found .*tbc-db"):
            importing.read_source(path, "cmangos-wotlk")
        with self.assertRaisesRegex(ValueError, "cannot be imported as att"):
            importing.read_source(path, "att")
        with self.assertRaisesRegex(ValueError, "Unknown source 'wowhead'"):
            importing.read_source(path, "wowhead")

    def scraper(self, *pages):
        return self.database(
            "w.db", ["CREATE TABLE pages (entity_type TEXT, entity_id INTEGER, locale TEXT, body TEXT, source_url TEXT)"],
            *[["INSERT INTO pages VALUES ('object', ?, ?, ?, ?)", *page] for page in pages])

    def test_scraper_cache_takes_only_the_pages_own_viewer_and_name(self):
        viewer = 'data-mv-display-id="%d" data-mv-type="2" data-mv-type-id="%d"'
        data = '$.extend(g_objects[%d], {"id":%d,"loc":{"x":[1]},"name":"%s"});'
        url = "https://www.wowhead.com/forever/object=1"
        path = self.scraper(
            (1, "enUS", viewer % (10, 1) + data % (2, 2, "Neighbour") + data % (1, 1, r'Uther\u0027s \"Chest\"'), url),
            (2, "enUS", viewer % (10, 99) + data % (2, 2, "Other viewer"), url),
            (3, "enUS", data % (3, 3, "No viewer"), url),
            (4, "deDE", viewer % (10, 4) + data % (4, 4, "Deutsch"), url),
            (5, "enUS", viewer % (99, 98) + viewer % (20, 5) + data % (5, 5, "Second viewer"), None))
        self.assertEqual({1: Claim(10, 'Uther\'s "Chest"'), 5: Claim(20, "Second viewer")},
                         importing.read_source(path, "wowhead-forever"))

    def test_scraper_cache_of_another_flavor_is_refused(self):
        path = self.scraper((1, "enUS", "", "https://www.wowhead.com/tbc/object=1"))
        with self.assertRaisesRegex(ValueError, "expected pages of /wotlk/, found .*/tbc/"):
            importing.read_source(path, "wowhead-wotlk")

    def test_display_type_decides_even_when_the_row_has_a_file(self):
        path = self.write("d.csv", "ID,FileDataID,AlternateDisplayType,ClientCreatureDisplayInfoID,ClientItemID\n"
                                   "1,1010,0,0,0\n2,125512,1,7804,0\n3,146919,2,0,12856\n4,0,0,0,0\n")
        displays = importing.read_display_info(path, "1.60.1.71091")
        self.assertEqual({1: Display("file", 1010), 2: Display("creature", 7804), 3: Display("item", 12856),
                          4: Display("none", 0)}, displays.by_id)

    def test_older_client_has_only_plain_displays(self):
        path = self.write("d.csv", "ID,ModelName,FileDataID\n1,Chest.mdx,1010\n")
        self.assertEqual({1: Display("file", 1010)}, importing.read_display_info(path, "1.15.9.70576").by_id)

    def test_unknown_display_type_and_build_fail(self):
        path = self.write("d.csv", "ID,FileDataID,AlternateDisplayType\n1,1010,3\n")
        with self.assertRaisesRegex(ValueError, "display 1: unknown AlternateDisplayType 3"):
            importing.read_display_info(path, "1.60.1.71091")
        path = self.write("d.csv", "ID,FileDataID,AlternateDisplayType,ClientCreatureDisplayInfoID\n9,1010,1,0\n")
        with self.assertRaisesRegex(ValueError, "display 9: invalid display creature 0"):
            importing.read_display_info(path, "1.60.1.71091")
        with self.assertRaisesRegex(ValueError, "Build must look like"):
            importing.read_display_info(path, "1.60.1")

    def test_files_survive_a_round_trip(self):
        rows = [row(1, "Camp", ("Vanilla", "Forever"), wowhead_forever=0, att=1010), row(2, "", skyfire=3)]
        self.assertEqual(rows, models.read_sources(self.write("sources.tsv", models.render_sources(rows))))
        self.assertEqual(DISPLAYS, models.read_displays(self.write("d.tsv", models.render_displays(DISPLAYS))))

    def test_unknown_source_column_fails(self):
        path = self.write("sources.tsv", "objectId\tflavors\tname\twowhead\n")
        with self.assertRaisesRegex(ValueError, "unknown or repeated source columns: wowhead"):
            models.read_sources(path)

    def test_malformed_files_fail_with_their_line(self):
        header = "objectId\tflavors\tdisplayId\tnote\n"
        for text, message in (
                (header + "2\tall\t0\ta\n1\tall\t0\tb\n", "manual.tsv:3: ID 1 is out of order"),
                (header + "1\tClassic\t0\ta\n", "unknown flavor 'Classic'"),
                (header + "1\tall\t6x\ta\n", "expected a number, found '6x'"),
                (header + "1\tall\t6\t\n", "needs a note"),
                (header + "1\tall\t6\n", "expected 4 columns, found 3"),
                ("objectId\tnote\n", "expected columns")):
            with self.subTest(text=text), self.assertRaisesRegex(ValueError, message):
                models.read_manual(self.write("manual.tsv", text))

    def test_inputs_that_contradict_each_other_fail(self):
        for build, message in (
                (lambda: model_data(manual=[manual(1, 10), manual(1, 20)]), "object 1 has two rows for Forever"),
                (lambda: model_data(row(1, "A", att=1010), row(1, "B", att=1010)), "object 1 has two rows for Forever"),
                (lambda: model_data(manual=[manual(1, 999)]), "display 999 shows nothing in Forever 1.60.1.71091"),
                (lambda: model_data(manual=[manual(1, 50)]), "display 50 shows nothing in Forever 1.60.1.71091"),
                (lambda: models.ModelData([], [], {6061: "typo"}, {f: displays_of(f) for f in models.FLAVORS}),
                 "hidden.tsv: no client has model file 6061"),
                (lambda: models.ModelData([], [], {}, {f: Displays("1.15.9.1", {}) for f in models.FLAVORS}),
                 "displays: build 1.15.9.1 is not a TBC client")):
            with self.subTest(message=message), self.assertRaisesRegex(ValueError, message):
                build()


class CheckTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="object models ")
        self.addCleanup(self.temporary.cleanup)
        self.directory = Path(self.temporary.name)
        self.rows = [row(1, "Chest", wowhead_forever=10), row(2, "Altar", wowhead_forever=20),
                     row(3, "Trap", wowhead_forever=10)]
        self.database = {"Forever": {1: ComposedObject("Chest", "quest"), 2: ComposedObject("Altar", "objective"),
                                     3: ComposedObject("Trap", "other")}}
        # Enough other objects that a few gaps stay below the lost-data limit.
        for object_id in range(100, 120):
            self.rows.append(row(object_id, "Rock", wowhead_forever=10))
            self.database["Forever"][object_id] = ComposedObject("Rock", "other")

    def check(self, data):
        models.lua_path("Forever", self.directory).write_text(models.render(data, "Forever"), encoding="utf-8")
        return checking.check(data, self.database, self.directory)["Forever"]

    def test_complete_data_has_nothing_to_report(self):
        report = self.check(model_data(*self.rows))
        self.assertEqual(([], []), (report.errors, report.warnings))
        self.assertEqual({"file": 23}, report.details["kinds"])

    def test_planted_gap_is_reported_once_in_its_group(self):
        for index, group in ((0, "quest"), (1, "objective"), (2, "other")):
            with self.subTest(group=group):
                rows = [r for r in self.rows if r is not self.rows[index]]
                details = self.check(model_data(*rows)).details
                self.assertEqual([(index + 1, group, "no source")],
                                 [(gap["objectId"], gap["group"], gap["reason"]) for gap in details["gaps"]])
                self.assertEqual(1, details["missingByGroup"][group])
                self.assertEqual(1, sum(details["missingByGroup"].values()))

    def test_only_quest_and_objective_gaps_warn(self):
        report = self.check(model_data(*self.rows[3:]))
        self.assertEqual([], report.errors)
        self.assertEqual(["quest object 1 Chest has no model: no source",
                          "objective object 2 Altar has no model: no source"], report.warnings)

    def test_object_without_a_display_is_no_gap(self):
        self.rows[0].claims["wowhead-forever"] = 0
        report = self.check(model_data(*self.rows))
        self.assertEqual(([], {"file": 22, "none": 1}), (report.warnings, report.details["kinds"]))

    def test_losing_most_models_fails(self):
        report = self.check(model_data(*self.rows[:3]))
        self.assertEqual(["20 of 23 objects have no known model; is sources.tsv complete?"], report.errors)

    def test_renamed_object_warns_until_imported(self):
        self.database["Forever"][1] = ComposedObject("Owl Statue", "quest")
        report = self.check(model_data(*self.rows))
        self.assertEqual([], report.errors)
        self.assertIn("object 1 is now Owl Statue, but its model was found as Chest", report.warnings[0])
        self.database["Forever"][1] = ComposedObject("chest.", "quest")
        self.assertEqual([], self.check(model_data(*self.rows)).warnings)

    def test_object_that_left_the_database_is_only_listed(self):
        del self.database["Forever"][3]
        report = self.check(model_data(*self.rows))
        self.assertEqual(([], []), (report.errors, report.warnings))
        self.assertEqual([3], report.details["gone"])

    def test_wrong_shipped_model_fails(self):
        data = model_data(*self.rows)
        self.check(data)
        path = models.lua_path("Forever", self.directory)
        path.write_text(path.read_text().replace("1010:1,3,", "2020:1,3,"), encoding="utf-8")
        errors = checking.check(data, self.database, self.directory)["Forever"].errors
        self.assertEqual(["Forever.lua does not match its sources; run `questiedb object-models write`"], errors)

    def test_changed_source_without_write_fails(self):
        self.check(model_data(*self.rows))
        self.rows[0].claims["wowhead-forever"] = 20
        self.assertEqual(1, len(checking.check(model_data(*self.rows), self.database, self.directory)["Forever"].errors))

    def test_windows_line_endings_pass(self):
        data = model_data(*self.rows)
        path = models.lua_path("Forever", self.directory)
        path.write_bytes(models.render(data, "Forever").replace("\n", "\r\n").encode())
        self.assertEqual([], checking.check(data, self.database, self.directory)["Forever"].errors)

    def test_disagreeing_sources_are_listed_with_their_files(self):
        self.rows[0].claims["att"] = 2020
        self.assertEqual([(1, {"wowhead-forever": 1010, "att": 2020})],
                         [(d["objectId"], d["files"]) for d in self.check(model_data(*self.rows)).details["disagreements"]])


class CommandTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="object models ")
        self.addCleanup(self.temporary.cleanup)
        self.directory = Path(self.temporary.name)
        # Object 1 is a gap. The others keep gaps below the lost-data limit.
        rocks = range(100, 120)
        self.write("sources.tsv", models.render_sources([row(i, "Rock", models.FLAVORS, att=1010) for i in rocks]))
        self.write("manual.tsv", "objectId\tflavors\tdisplayId\tnote\n")
        self.write("hidden.tsv", "fileDataId\tnote\n")
        (self.directory / "displays").mkdir()
        for flavor in models.FLAVORS:
            self.write("displays/%s.tsv" % flavor, models.render_displays(displays_of(flavor)))
        models.write_files(models.load(self.directory), {}, self.directory)
        self.database = composed(**{flavor: {1: ("Chest", "quest"), **{i: ("Rock", "other") for i in rocks}}
                                    for flavor in models.FLAVORS})

    def write(self, name, text):
        path = self.directory / name
        path.write_text(text, encoding="utf-8")
        return path

    def files(self):
        return {path.name: path.read_bytes() for path in sorted(self.directory.rglob("*")) if path.suffix in (".tsv", ".lua")}

    def run_main(self, *args, env=None):
        with patch.object(object_models, "composed_objects", side_effect=lambda f: {x: self.database[x] for x in f}), \
                patch.object(object_models, "OUTPUT", self.directory / "out"), \
                patch.object(models, "DATA", self.directory), \
                patch.object(models, "SHIPPED", self.directory), \
                patch.dict(object_models.os.environ, {"GITHUB_ACTIONS": "", "GITHUB_STEP_SUMMARY": "", **(env or {})}), \
                contextlib.redirect_stdout(io.StringIO()) as out, contextlib.redirect_stderr(io.StringIO()) as err:
            return object_models.main([str(arg) for arg in args]), out.getvalue() + err.getvalue()

    def test_gaps_pass_and_reach_the_report(self):
        code, output = self.run_main("check", "Forever")
        self.assertEqual(0, code, output)
        report = json.loads((self.directory / "out/report.json").read_text())
        self.assertEqual([1], [gap["objectId"] for gap in report["Forever"]["details"]["gaps"]])
        self.assertIn("warning: quest object 1 Chest has no model: no source", output)

    def test_wrong_data_fails(self):
        self.write("Forever.lua", "stale")
        code, output = self.run_main("check", "Forever")
        self.assertEqual(1, code)
        self.assertIn("ERROR: Forever: Forever.lua does not match its sources", output)

    def test_github_gets_one_annotation_per_flavor_and_a_summary(self):
        summary = self.directory / "summary.md"
        for i in range(1, 7):
            self.database["Vanilla"][i] = ComposedObject("Chest %d" % i, "quest")
        code, output = self.run_main("check", env={"GITHUB_ACTIONS": "true", "GITHUB_STEP_SUMMARY": str(summary)})
        self.assertEqual(0, code)
        self.assertEqual(6, output.count("::warning title=Object models ("))
        self.assertIn("::warning title=Object models (Forever)::1 object model warnings: quest object 1 Chest", output)
        self.assertIn("quest object 6 Chest 6 has no model", summary.read_text())

    def test_import_updates_the_shipped_lua_and_leaves_manual_alone(self):
        self.write("manual.tsv", "objectId\tflavors\tdisplayId\tnote\n1\tForever\t20\treviewed\n")
        before = self.files()["manual.tsv"]
        source = self.write("wowhead.csv", "objectId,displayId,name\n1,10,Chest\n")
        code, output = self.run_main("import", "wowhead-forever", source)
        self.assertEqual(0, code, output)
        self.assertEqual(before, self.files()["manual.tsv"])
        self.assertIn(b"\n2020:1\n", self.files()["Forever.lua"])
        self.assertEqual(0, self.run_main("check")[0])

    def test_import_saves_every_refused_value(self):
        source = self.write("wowhead.csv", "objectId,displayId,name\n" + "".join("%d,10,Other\n" % i for i in range(1, 41)))
        self.database["Forever"].update({i: ComposedObject("Chest", "other") for i in range(1, 41)})
        code, output = self.run_main("import", "wowhead-forever", source)
        self.assertEqual(0, code, output)
        refused = (self.directory / "out/refused-wowhead-forever.tsv").read_text().splitlines()
        self.assertEqual((41, "40\tOther\t10\tChest"), (len(refused), refused[-1]))

    def test_reviewed_row_for_a_new_object_ships_after_write(self):
        self.write("manual.tsv", "objectId\tflavors\tdisplayId\tnote\n1\tForever\t20\treviewed\n")
        self.assertEqual(0, self.run_main("write")[0])
        self.assertIn(b"\n2020:1\n", self.files()["Forever.lua"])
        self.assertNotIn("has no model", self.run_main("check", "Forever")[1])

    def test_rejected_input_changes_no_file(self):
        self.write("manual.tsv", "objectId\tflavors\tdisplayId\tnote\n1\tForever\t20\treviewed\n")
        self.run_main("write")
        before = self.files()
        bad_csv = self.write("bad.csv", "objectId,displayId,name\n1,-1,Chest\n")
        without_reviewed = self.write("d.csv", "ID,FileDataID\n10,1010\n60,6060\n")
        bad_display = self.write("e.csv", "ID,FileDataID,AlternateDisplayType,ClientCreatureDisplayInfoID\n20,1,1,0\n")
        not_sqlite = self.directory / "broken.db"
        not_sqlite.write_bytes(b"SQLite format 3\x00garbage")
        for args, message in (
                (("import", "wowhead-forever", bad_csv), "-1 is not a display"),
                (("import", "wowhead-forever", not_sqlite), "object-models: "),
                (("displays", "Forever", "1.60.1.71500", without_reviewed), "object 1: display 20 shows nothing"),
                (("displays", "Forever", "1.60.1.71500", bad_display), "invalid display creature 0"),
                (("displays", "Mists", "1.15.9.70576", without_reviewed), "build 1.15.9.70576 is not a Mists client"),
                (("displays", "Classic", "1.60.1.71500", without_reviewed), "Unknown flavor: Classic"),
                (("check", "Classic"), "Unknown flavor: Classic"),
                (("import", "att"), "invalid arguments"),
                (("import", "att", "/nowhere.csv"), "nowhere.csv")):
            with self.subTest(args=args):
                code, output = self.run_main(*args)
                self.assertEqual(1, code, output)
                self.assertIn(message, output)
                self.assertEqual(before, self.files())

    def test_new_displays_resolve_objects_that_were_waiting_for_them(self):
        source = self.write("wowhead.csv", "objectId,displayId,name\n1,61,Chest\n")
        self.run_main("import", "wowhead-forever", source)
        self.assertIn("display 61 is newer than 1.60.1.71091; update the displays", self.run_main("check", "Forever")[1])
        newer = self.write("d.csv", "ID,FileDataID\n" + "".join("%d,%d\n" % (i, i * 101) for i in (10, 20, 61)))
        code, output = self.run_main("displays", "Forever", "1.60.1.71500", newer)
        self.assertEqual(0, code, output)
        self.assertIn("1.60.1.71091 -> 1.60.1.71500, 1 displays added, 4 removed, 0 changed", output)
        self.assertIn(b"\n6161:1\n", self.files()["Forever.lua"])


class RealDataTest(unittest.TestCase):
    """The committed files, without depending on how much of the database they cover."""

    @classmethod
    def setUpClass(cls):
        cls.data = models.load()

    def test_shipped_lua_matches_its_sources(self):
        for flavor in models.FLAVORS:
            with self.subTest(flavor=flavor):
                self.assertEqual(models.render(self.data, flavor), models.lua_path(flavor).read_text(encoding="utf-8"))

    def test_invisible_models_never_ship(self):
        # Invisible.M2, two invisible stalkers, a click box, an invisible trap, a spell effect, a building.
        files = {"166432", "124640", "124641", "511490", "2199319", "4569801", "107917"}
        for flavor in models.FLAVORS:
            shipped = set(re.findall(r"(?m)^(\d+):", models.lua_path(flavor).read_text(encoding="utf-8")))
            self.assertEqual((set(), True), (shipped & files, len(shipped) > 1000), flavor)

    def test_objects_lua_lists_the_composed_view_with_roles(self):
        composed_view = object_models.composed_objects(["Vanilla", "Wrath"])
        objects = composed_view["Vanilla"]
        self.assertEqual(ComposedObject("Old Lion Statue", "quest"), objects[31])
        self.assertEqual("Owl Statue", objects[410020].name)  # Season of Discovery only
        self.assertEqual("Blood Ritual Altar", composed_view["Wrath"][420002].name)  # Titan Reforged only
        for object_id, role, why in (
                (175124, "objective", "Rookery Egg is a direct objective"),
                (759, "objective", "The Holy Spring is an extra objective"),
                (161557, "drop", "Milly's Harvest drops an objective item"),
                (142185, "drop", "Flame of Byltan drops a required source item"),
                (2554, "drop", "Cortello's Riddle drops an item that starts a quest"),
                (177794, "drop", "Strange Lockbox belongs to a Horde quest")):
            with self.subTest(why):
                self.assertEqual(role, objects[object_id].role)


if __name__ == "__main__":
    unittest.main()
