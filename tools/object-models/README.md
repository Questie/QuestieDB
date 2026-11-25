# Object models

Maintains which 3D model each game object has, per flavor. The game client cannot be asked for
an object's model, so QuestieDB has to know it. Shipped data lives in `support/ObjectModels/`;
see [support data](../../docs/support-data.md#object-models) for the runtime side and
[ADR 0019](../../docs/adr/0019-object-models-as-support-data.md) for the reasons.

No command uses the network. Generation and tests need only the committed files.

## Files in `support/ObjectModels/`

| File | Written by | Holds |
| --- | --- | --- |
| `sources.tsv` | `import` | What every source says: one row per object and name, one column per source |
| `manual.tsv` | you | Reviewed decisions. They win over every source |
| `hidden.tsv` | you | Model files that show nothing useful |
| `displays/<Flavor>.tsv` | `displays` | The client's `GameObjectDisplayInfo`, as one kind and one ID per display |
| `<Flavor>.lua` | `write` | The shipped module, generated from the files above |

Objects point to a *display ID*; the flavor's display table turns that into a model file, a
creature, an item, or nothing. Newer clients give creature and item displays a FileDataID too,
so the display's kind decides, never the presence of a file. Only plain model files ship.

The first usable source wins: Wowhead for that flavor, then that flavor's emulator database,
then other expansions', then AllTheThings. `SOURCE_ORDER` in `models.py` is the exact order.

## Commands

```sh
./questiedb.sh object-models check [flavor ...]
./questiedb.sh object-models import <source> <file>
./questiedb.sh object-models displays <flavor> <build> <GameObjectDisplayInfo.csv>
./questiedb.sh object-models write
```

### A warning says objects have no model

CI runs `check` and warns when an object that starts or ends a quest, or is an objective, has no
known model. It never blocks: new content arrives before its models do. Every gap, with a reason
and a link to open by hand, is in `.out/object-models/report.json`.

| Reason | What to do |
| --- | --- |
| `no source` | Import a source that knows it, usually Wowhead through scraper-questie: `import wowhead-forever path/to/data/raw/forever.db` |
| `display N is newer than <build>` | Download `GameObjectDisplayInfo` of the new build from wago.tools as CSV: `displays Forever 1.60.1.71500 path/to/file.csv` |
| `display N is not in <build>` | The client dropped that display, so the source is out of date. Add a `manual.tsv` row if you know better |

For a single object, add a row to `manual.tsv` and run `write`.

Objects whose sources all say *no display* are not gaps: players never see them.

### A warning says an object is now something else

Its name in the database no longer matches the name its model was found under. The next import
of any source drops the old values; add a `manual.tsv` row if the model is still right.

### What fails the check

Wrong or unusable data: a malformed file, a reviewed display that shows nothing in that client,
a hidden file no client has, a display table of another game version, a shipped Lua file that does
not match its sources, or a quarter of a flavor's models missing. Run `write` after editing a file
by hand.

## Importing

`import` takes one of three file types and picks the reader from the file:

- a CMaNGOS release database from `Questie/cmangos` (`gameobject_template`), for `cmangos-*`;
- a scraper-questie raw cache, such as `data/raw/forever.db`, for `wowhead-*`. Only cached pages
  are read. Both kinds must say that they belong to the source, so mixed-up files are refused;
- a CSV with `objectId`, `name`, and `displayId` (`fileDataId` for `att`).

It updates one column and the list of objects, then writes the Lua. It never edits `manual.tsv`.
Values that the file does not mention are kept, because an export can be partial. Nothing is
written when the result is invalid.

A value is taken only when the source's name matches ours, ignoring case and punctuation.
Numbers are reused: 410020 is an Owl Statue in Season of Discovery, and from TBC on an invented
ID for a cage. Every refused value is in `.out/object-models/refused-<source>.tsv`; add a
`manual.tsv` row when it is the same object after all.

Some values carry no information and are skipped: SkyFire's displays 299, 474 and 2350 and its
objects without a name, emulator displays that are the object ID minus 10000, and the editor
placeholders of CMaNGOS objects that players never see.

SkyFire and AllTheThings have no reader and rarely change. Make a CSV first:

- SkyFire: `entry`, `displayId` and `name` of the dump's `gameobject_template` rows.
- AllTheThings: `model` as `fileDataId` and `readable` as `name` of each `[id] = { ... }` in
  `ObjectDB.lua`.

## Reviewed rows

`manual.tsv` columns: `objectId`, `flavors` (`all` or a comma-separated list), `displayId`, and a
note saying why. Display 0 means the object has no model on purpose. IDs that Corrections
invented are listed that way; give such a row a real display to show one.

`check` counts where the chosen value disagrees with a flavor's own sources or AllTheThings, and
lists them in `report.json`. A manual row settles it.

## Tests

```sh
uv run tools/object-models/object_models.test.py
lua5.1 test.lua object-models
```
