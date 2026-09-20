# DBC spatial tools

Inspect coordinate transforms, perform deliberate baseline migrations, or generate
candidate-only Forever map support. None of these commands runs during normal Generation
or runtime reads.

## Generate Forever map support candidates

From the QuestieDB root, using an **existing** local database:

```sh
./questiedb.sh dbc-support \
  --database .cache/dbc/dbc-source.db --build 1.60.1.69893 \
  --output .out/forever-support/review
```

Use the same arguments with `questiedb.ps1`. This command never downloads a database.
It writes only under this checkout's `.out/forever-support/`:

- `Zones/areaIdToUiMapId.lua`: direct and parent-resolved routes, with separate overrides.
- `Zones/uiMapIdToAreaId.lua`: canonical direct reverse mappings, with separate overrides.
- `report.json`: exact source projections/coverage, full assignment evidence, native map
  inventory, parent chains, exceptions, unresolved cases and candidate file hashes.

These are **review candidates, not a complete runtime ZoneDB bundle**. Do not copy them
into active support without reviewing current authored changes. Entrances, subzone and
instance tables, symbols and entity coordinates remain untouched. Retired-map compatibility
must not be used as a native-map allowlist.

### Inputs and ownership

`spatial.py` distinguishes areas, world MapIDs, UI maps, assignment-derived routes, authored
points with undeclared/declared frames, and instance presence. It preserves direct routes;
otherwise it selects the highest directly mapped ancestor. A selected map does not establish
an existing point's frame. Unsupported/ambiguous primary assignments block inferred routing
through their parent chain. Canonical reverse mappings are never built by inverting the
many-to-one descendant table.

`forever-spatial-exceptions.json` records reviewed policy with stable IDs, exact build and
source projection applicability, evidence and retirement conditions. Native aliases,
suppression and retired-map compatibility are distinct. Synthetic keys must not collide with
real areas. The legacy Blackrock Spire key 1585 is absent from this AreaTable snapshot; it is
retained as a legacy key, not relabeled as a real area or invented synthetic area.

The exception input is authoritative for candidate policy. Candidate Lua is generated.
**Active Forever Lua remains authoritative until separately reviewed adoption.** At adoption,
transfer ownership of these two mapping fields to the source facts and exceptions rather than
maintaining both input and output by hand. See [ADR 0014](../../docs/adr/0014-offline-spatial-support-candidates.md).
No entity authoring database, Lua provider evaluator or second coordinate converter is added.

### Reviewed build and remaining gaps

For `1.60.1.69893`, candidates reproduce the reviewed 54 direct, 1,010 inherited and 54 canonical
reverse mappings, plus seven forward policy entries and three reverse aliases. They also
preserve the current branch's **40 retired-map compatibility pairs** in both override tables.
These counts describe this reviewed build, not generic resolver invariants.

The report retains all 308 unresolved real areas, even when suppression or consumer
compatibility supplies a legacy lookup. UiMaps 1463, 1464 and 2665 remain unresolved. The 24
AreaTable records referencing absent world MapIDs are reported rather than fabricated. Current
DBC parent routing for 2657 and 3217 agrees with the already-reviewed owned support fixes.

All four required DBC tables need recorded `ok` coverage. Missing databases, fields, broken
assignment references, parent cycles, exception collisions and mismatched source projections
fail before candidate installation. Restricted or ambiguous assignments remain explicit
unresolved evidence rather than guessed geometry. The report fingerprints full assignment
rows, including unknown selectors, separately from the historical selected-field projections.

Repeated runs with identical inputs produce identical bytes. The existing protected installer
uses separate candidate ownership and installs the report last. Hand-edited/unowned files and
symlinked destinations are rejected; rollback retains recovery data if restoration is unsafe.
There is no runtime installation or compatibility-removal flag.

### Candidate validation

```sh
uv run --no-project python tools/dbc/support.test.py
FOREVER_DBC_DATABASE="$PWD/.cache/dbc/dbc-source.db" \
  uv run --no-project python tools/dbc/support.test.py
```

The first command uses small SQLite fixtures. The second adds pinned-build acceptance:
actual Lua loading compares all four candidate base/override tables against current owned
support, checks every ancestor annotation and the unresolved inventory, and verifies that a
wrong target with unchanged counts fails. Set `LUA` to a Lua 5.1 executable if `lua5.1` is not
on PATH. On PowerShell, set `$env:FOREVER_DBC_DATABASE` before running the second command.
The real-data check is intentionally opt-in; ordinary fixture tests need no DBC cache.

Existing coordinate/conversion tests cover Hawkwind's precise projection and two-decimal
export, phases and source-preserving rewriting. The new position fixtures cover parent-frame
separation, real zero points, partial-sentinel rejection, and Prince Tortheldrin/object instance
presence. They do **not** claim to validate consumer entrance rendering or live placement.

## Historical coordinate migration

Create a separate Forever baseline from QuestieDB's Era data and corrections.
The converter changes coordinate literals, not game content or runtime flavor
selection. Era inputs remain untouched. Forever already has an adopted baseline; these commands
are for deliberate migrations in an isolated workspace, not a prerequisite for normal Generation.

Use the repository-root `questiedb.sh` or `questiedb.ps1` launcher. The tools need
Python 3.8+ with its standard library. Conversion also needs Lua 5.1 for semantic
validation. Downloading from the private `Questie/dbc` repository requires an
installed, authenticated `gh` CLI with repository access.

## Inspect a coordinate

From the QuestieDB root:

```sh
./questiedb.sh dbc-coordinates \
  --from-build 1.15.9.69722 --to-build 1.60.1.69893 \
  --allow-untracked-source \
  --ui-map 1412 --point 44.18 76.06
```

On Windows, use the same arguments with `./questiedb.ps1`. `--ui-map` is a UiMapID,
not an AreaID or instance MapID. Points use percentages (`0–100`), not normalized
coordinates. Repeat `--point X Y` for more points, or omit both point options to
compare maps. `--json` prints the complete comparison and any supplied points.

For these builds, Chief Hawkwind's Era point becomes approximately
`43.8889, 76.6595`; converted files store **`43.89, 76.66`**. Named tests cover both
the full-precision prediction and the rounded Lua output. The transform preserves
world position through a per-map scale and offset. It assumes the NPC and world coordinate frame did not move. Check
several separated landmarks per changed map before treating the result as verified
Forever placement.

## Convert data and corrections

First convert and validate temporary copies:

```sh
./questiedb.sh convert-forever \
  --from-build 1.15.9.69722 --to-build 1.60.1.69893 \
  --allow-untracked-source --keep-unmapped --dry-run
```

Inspect the reported counts and unmapped AreaIDs. Then remove `--dry-run` to install
the ten output files:

```sh
./questiedb.sh convert-forever \
  --from-build 1.15.9.69722 --to-build 1.60.1.69893 \
  --allow-untracked-source --keep-unmapped
```

The example deliberately retains unresolved coordinates. Omit `--keep-unmapped` to
require every non-sentinel point to have a supported direct map transform; otherwise
conversion fails before installing outputs. The flag does not guess a transform.
It leaves those points unchanged and records their source lines for review.

`--dry-run` may download the missing DBC cache and creates temporary validation
files. It does not install Forever outputs or write their conversion manifest.
`--lua PATH` or `LUA` selects the Lua 5.1 executable. Neither command generates TOCs,
registers a flavor, nor modifies runtime Correction selection. Existing Forever registrations
read the installed outputs on subsequent Source loads or Generation; existing Baked TOCs
are not rebuilt.

### Output files

Raw inputs come from `data/Classic/`. The first five correction inputs come from
`src/corrections/Era/`; **item-start corrections come from `src/corrections/Shared/`**.

```text
data/Forever/foreverItemDB.lua
data/Forever/foreverNpcDB.lua
data/Forever/foreverObjectDB.lua
data/Forever/foreverQuestDB.lua

src/corrections/Forever/classicItemFixes.lua
src/corrections/Forever/classicNPCFixes.lua
src/corrections/Forever/classicObjectFixes.lua
src/corrections/Forever/classicQuestFixes.lua
src/corrections/Forever/classicQuestReputationFixes.lua
src/corrections/Forever/itemStartFixes.lua
```

`data/Forever/conversion.json` records source/output hashes, source and target builds,
DBC snapshot hashes and coverage, coefficients, per-file counts, converted AreaIDs,
and samples of unmapped or out-of-bounds coordinates. Keep it with the generated
files: it also identifies outputs the tool may safely update on a later run.

The tested `1.15.9.69722` → `1.60.1.69893` conversion recognized **140,660 pairs** and
changed **13,691**. Six points on synthetic AreaIDs `10073`, `10074` and `10089`
remained unresolved. The dry run validated all ten files and 30 correction personas.
Counts depend on the source revision as well as the DBC builds.

## DBC download and coverage

Both commands default to `.cache/dbc/dbc-source.db`, ignored by Git. `--database PATH`
selects another location; a relative path is relative to the calling directory.

- If the database exists, use it locally without network access. Invalid databases
  or databases missing a requested build fail rather than being replaced.
- If missing, resolve one `Questie/dbc` release, download its manifest and source
  artifact, verify the compressed SHA-256, decompress, and validate the SQLite
  structure and both requested builds before installation.
- An authenticated `gh` login is preferred. Without one, the downloader tries public
  HTTPS; that cannot access the currently private repository.
- `--dbc-tag TAG` selects the release **only when the database is missing**. There is
  no automatic cache refresh. Choose a new cache path with `--database` when you
  deliberately need another artifact.

The CLI requires explicit `1.15.x` source and `1.60.x` target builds, not mutable
`*_v1` views. The stored Era snapshot predates coverage tracking, so the example
uses `--allow-untracked-source`. This records untracked source coverage; it never
bypasses recorded failures. Target snapshots must have recorded `ok` coverage.

## What conversion preserves

The [rewriter](rewrite.py) changes only X/Y numeric tokens in recognized fields:
NPC/Object spawns and waypoints, Quest `triggerEnd` spawn lists, and Quest
`extraObjectives` spawn lists. It processes both faction branches without executing
or flattening them. Comments, module names, functions, class conditions, symbolic
keys, localization calls, phases, nil holes and unrelated values remain intact.
There are no runtime conversion wrappers in the output.

Item data, Item corrections, reputation corrections and item-start corrections
contain no coordinate fields and are copied byte-for-byte. Unsupported coordinate
expressions or malformed shapes fail explicitly. Lua validation compares loaded
original and transformed data, including non-coordinate values, module-load effects
and the existing faction/class correction cases, before installation.

Complete `{-1,-1}` instance sentinels remain unchanged; partial sentinels fail.
`{0,0}` is a real point. Transform calculations retain full precision; converted
pairs are rounded to two decimal places when written (halfway values round away
from zero). Unchanged-map and explicitly retained unmapped coordinates keep their
original precision. This is an offline conversion policy, not a change to runtime
coordinate storage. Trailing zero padding is not added to Lua numbers.

Coordinates are not clamped. Out-of-bounds results are reported before rounding so
a rounded boundary value cannot hide them. Rounding that would create an instance
sentinel is rejected. The manifest records the output rounding policy.

Only direct, unambiguous AreaID/UiMapID relationships shared by the two builds are
converted. Partial map rectangles, conditional assignments, changed identities,
subzone-parent guesses and synthetic map routing are not silently inferred.

## Reruns and recovery

Every run starts from the Era inputs, never the existing Forever files. Repeating a
run with identical inputs produces identical outputs, not a second transformation.
Existing files that differ from both the proposed output and the recorded generated
hash are treated as hand-edited or unowned; the tool refuses to overwrite them.
Preserve or move those files before regeneration. There is no force-overwrite flag.

The installer checks all destinations, stages bytes and backups, then replaces
files with the manifest last. Symlinked destinations are rejected. Ordinary
installation errors and cooperative cancellation trigger rollback. If a destination
was edited after publication, rollback preserves that edit and retains the
`.forever-conversion-*` recovery directory, including `recovery.json` and backups.
Follow the reported recovery path; do not delete it before resolving the files.
This is not a transaction across an abrupt process kill or power failure.

## Integration and remaining data gaps

These files are a coordinate-adjusted Era baseline, not complete Forever content.
Flavor configuration, TOC selection and Correction applicability are owned by the
provider integration, not this converter. See [Forever input adoption](../../docs/forever-data.md)
for the adopted-byte validation, independent locale/support inputs, reviewed DBC
support imports and deferred gaps. The completed support-map handoff and its consumer
compatibility links are maintained separately from coordinate conversion; consult the
[current map limitations](../../docs/forever-data.md#current-support-map-limitations) before
importing another export. New content and race/class restrictions need separate work.
Questie-owned runtime Corrections can still supply Era coordinates, and
`support/Forever/Zones/dungeons.lua` entrance coordinates are not converted by this tool.

The tooling is self-contained in QuestieDB. It does not require the sibling `dbc/`
or `QuestieDB-DBC/` checkout. The separate support-data generator in `QuestieDB-DBC/`
produces support exports, not inputs to this coordinate converter.

## Focused tests

Run from the QuestieDB root; fixtures use temporary files and mocked downloads:

```sh
uv run --no-project python tools/dbc/coordinates.test.py
uv run --no-project python tools/dbc/download.test.py
uv run --no-project python tools/dbc/rewrite.test.py
uv run --no-project python tools/dbc/convert.test.py
uv run --no-project python tools/dbc/support.test.py
uv run --no-project python tools/cli/questiedb.test.py
```

These DBC suites also run under `./questiedb.sh test`. Semantic tests require Lua
5.1; POSIX cancellation and PowerShell launcher checks depend on platform support.
