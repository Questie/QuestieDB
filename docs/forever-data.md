# Forever data: history and current workflow

This document separates the initial data-adoption record from the current maintenance
workflow. Historical revisions, hashes, counts and source line numbers describe the
adoption snapshot, not a requirement that Forever remain identical to that snapshot.

## Historical record: initial Forever release preparation

This records what we prepared for the first Forever release, not evidence that it was
published. No release tag or publication date is recorded here yet. Add those when this
baseline ships. Preserve this account when the data changes; record subsequent migrations
separately rather than rewriting the initial results to describe newer inputs.

### Sources and processing

The clean upstream seed was `0529e8d82075316242b0796e2128afb40d300130`.
The supplied coordinate-tool checkout was based on
`d94542ac92423f05c6fbde6574ada29b15c0d4e8`; its working files, not that commit alone,
provided the converter and converted outputs. Only the approved
`Questie-db/QuestieDB` and `Questie-db/QuestieDB-DBC` external sources were read.
No previous Forever implementation or recovery snapshot was used.

The adoption followed this sequence:

1. Matched the supplied converter's Era source hashes against the clean upstream seed.
2. Used its existing coordinate-adjusted outputs. The converter derived per-map scale and
   offset from Era and Forever DBC map bounds, preserving world position while changing
   map-percentage coordinates. It rewrote recognized numeric coordinate tokens in raw
   entities and Correction providers, preserving other Lua content and runtime branches.
   This assumes world positions did not move; it does not discover new or relocated content.
3. Adopted all four entity files, all six Correction providers and their conversion manifest
   together. Checked the adopted bytes with hashes and Lua semantic comparisons, not just
   freshly generated candidates. No installing conversion was run during adoption.
4. Copied the locale and support seed into independently owned Forever paths, then imported
   only the reviewed DBC support changes described below.
5. Passed the owned inputs through normal Generation and Source/Baked validation. Coordinate
   conversion was not added to Generation or runtime reads. The end result was independently
   maintained source data, not a runtime dependency on Era or the external export checkout.

### Verification at adoption

- `data/Forever/conversion.json` was adopted as the supplied, unchanged conversion manifest.
  All ten external output hashes matched. All ten Era source hashes matched both
  the supplied checkout and the clean upstream files. The zone-symbol hash also
  matched. No source revision reconciliation was necessary.
- Geometry and complete build provenance were independently re-read from the
  supplied existing SQLite cache, read-only, and matched the manifest exactly.
  Source build: **1.15.9.69722**, with explicitly accepted untracked legacy
  coverage. Target build: **1.60.1.69893**, with recorded `ok` coverage.
- The actual adopted bytes, read back from all ten Forever paths, passed the
  supplied Lua semantic validator: ten files and 30 Correction personas. This
  was separate from a later successful candidate `--dry-run --keep-unmapped`.
- The strict dry run failed on exactly six unresolved coordinates, as intended.
  No conversion run installed or overwrote outputs, and no download occurred.
- `support/Forever/provenance.json` records all 36 locale and ten support seed
  hashes, adopted hashes, original tool hashes, the conversion manifest hash,
  and the full DBC support report. Every external DBC output hash was checked.
  These are one-time migration records, not permanent Era-equality constraints.

The four raw entity files and all six applicable Correction files were adopted
as a set. Original module names are preserved, including `QuestieItemStartFixes`.
Item data, Item Corrections, reputation Corrections and Item-start Corrections contained
no recognized coordinates and were byte copies of their source inputs at adoption.

The 36 locale files were physically copied directly from clean `l10n/Classic`.
Era has no applicable global `lookupOverrides` input to copy. Ten support files
were physically seeded with their original relative layout and module shapes:

- `Zones/{dungeons,subZoneToParentZone,zoneIds,instanceIdToAreaId,areaIdToUiMapId,uiMapIdToAreaId}.lua`
- `QuestXP/xpDB-classic.lua`
- `FactionTemplates/factionTemplateClassic.lua`
- `DropTables/{itemDropCorrections,classicItemDrops}.lua`

The faction file and three zone files then received the reviewed changes below.
Unprovided support and localization remain an independently maintained Era seed,
not verified new Forever content.

### Coordinate results and gaps at adoption

The converter recognized 140,660 pairs: 13,691 converted, 123,819 unchanged,
3,144 complete instance sentinels and six unresolved points explicitly retained.
Only Mulgore, Eastern Plaguelands, Redridge Mountains and Stormwind City have
changed supported map frames. Transformed pairs use two decimal places, halfway
away from zero; unchanged and unresolved coordinates retain their precision.
Normal Generation and runtime reads must not apply another transform or round.

All six unresolved points use authored continent/world routing, not ordinary
AreaIDs. They remain unchanged because the DBC assignments do not establish a
supported direct AreaID transform. Retention is not a claim of placement accuracy.

| File and line | Entity | Synthetic area | Retained x, y |
| --- | --- | --- | --- |
| `classicNPCFixes.lua:1531` | 9026 Overmaster Pyron | 10074 Eastern Kingdoms | 46.818, 67.705 |
| `classicNPCFixes.lua:1559` | 9046 Scarshield Quartermaster | 10074 Eastern Kingdoms | 49.119, 64.098 |
| `classicNPCFixes.lua:3011` | 15215 Mistress Natalia Mar'alith | 10073 Kalimdor | 44.399, 86.11 |
| `classicNPCFixes.lua:3365` | 16033 Bodley | 10074 Eastern Kingdoms | 48.896, 63.93 |
| `classicObjectFixes.lua:436` | 180453 Hive'Regal Glyphed Crystal | 10073 Kalimdor | 44.404, 86.1 |
| `classicObjectFixes.lua:440` | 180652 Freshly Dug Dirt | 10089 Azeroth | 29.99, 89.15 |

The Crystal's authored comment explicitly places it outside the Silithus map.
Do not infer a zone transform from an entity name or nearest parent. Existing
1414/1415/947 to synthetic-area overrides remain intact.

#### Later coordinate producers identified during adoption

- Both static and faction-dependent coordinate-bearing Forever providers are
  converted. The validator compares functions under both factions and all nine
  quest classes; it does not flatten providers to one persona.
- The waypoint Derived Pass subsequently simplifies/interpolates already
  converted values. It must use Forever's owned zone support and must not run a
  second coordinate conversion.
- `support/Forever/Zones/dungeons.lua` entrance triples are **not converted**.
  Known affected entries include Stockade 717, Deeprun Tram 2257, Champions' Hall
  2918 and inherited Brawlpub 6618 in Stormwind; Stratholme 2017/10001, Naxxramas
  3456 and inherited Scarlet Enclave 16236 in Eastern Plaguelands. Some inherited
  entries are later-expansion/season content, not evidence of Forever availability.
  Review entrances separately before claiming navigation accuracy.
- Consumer Dynamic Corrections can still supply Era coordinates, including the
  Darkmoon Mulgore example documented by the supplied investigation. Those
  consumer sources were not imported or independently inspected here. The
  consumer must select Forever coordinates; consumer policy stays outside QuestieDB.
- New entities, moved terrain/NPCs and Forever race/class restrictions are not
  provided by this conversion. Separated live static-landmark checks on each of
  the four changed maps remain pending. Chief Hawkwind's 43.89, 76.66 alone is not
  a client-wide placement proof.

### Reviewed DBC support changes

The export is build **1.60.1.69893**. Exact projection hashes, output hashes,
counts and diagnostics are retained in `support/Forever/provenance.json`.
No reference-only export creates a new public API.

#### Faction templates

Adopted all 453 exported `template ID -> EnemyGroup` values at the conventional
owned path `FactionTemplates/factionTemplateClassic.lua`. The filename is internal;
the file header identifies the actual Forever build and DBC source.

Against the 367-row seed: 366 retained values match, 87 IDs are added, no retained
value changes, and **3546 -> 0 is removed**. All 10,119 raw NPC rows and both
factions of NPC Correction results were checked: no NPC faction reference is
missing from the export, including no reference to removed template 3546.
Occurrences of 3546 as an NPC vendor ID are unrelated to faction-template IDs.
The focused dataset check also examines captured Correction writes and injects
an invalid reference to prove missing references fail.

#### Zone-map dispositions

These are partial DBC projections, not complete replacements. Existing override
strings are preserved byte-for-byte. Retained seed rows outside the export are
not relabeled as verified Forever facts.

| Export | Evidence and disposition |
| --- | --- |
| `areaIdToUiMapId` | 54 export rows: 49 agree, four are new, one changes. Import Riverglades 16591 -> 2548, Zephras Isle 16593 -> 2521, Darkspear Islands 16606 -> 2524, Shen'dralas 16651 -> 2652, and replace Mount Hyjal 616 -> 198 with 616 -> 2482. Each is an explicit primary assignment. Retain the 167 seed rows absent from the export as unverified compatibility/navigation data, not an active-map allowlist. |
| `uiMapIdToAreaId` | 49 existing links agree; import the five corresponding reverse links. Remove inherited Cata Hyjal 198 -> 616 because the Forever assignment establishes 2482 instead. Of 195 seed rows absent from the export, retain the other 194 pending review. Preserve continent and synthetic-floor overrides. |
| `subZoneToParentZone` | 956 matching rows, 230 new rows, two conflicting parents, 1,191 seed rows absent. Retain the seed unchanged. Defer all additions pending parent-chain/navigation review rather than unioning new reference rows into runtime routing. Valley of Bones 2657 changes 405 -> 16651; The Maul 3217 changes 2557 -> 357. Those change inherited routing and need a coordinate/navigation review. The complete proposed additions and conflicts are recorded in provenance. |
| `instanceIdToAreaId` | 19 matching rows and eight additions, no conflicts. Import explicit `Map.AreaTableID` links 369 -> 2257 (Tram), 449 -> 2918 and 450 -> 2917 (barracks), 489 -> 3277 (Warsong), 529 -> 3358 (Arathi), 2959 -> 16544 (City of Dalaran). Defer test map 13 -> 13649 and unused prison 35 -> 717. Retain the 88 seed links absent from the export: missing DBC area links do not establish removal. New identity links do not supply entrances or imply active content. |

Three mapping fields and their override companions remain deferred Lua strings;
instance mappings remain a numeric table. Empty override strings from the export
were never loaded or copied over authored overrides. No LuaLS API change is needed.

Outstanding export gaps include six assignments without AreaID (UI maps 1414,
1415, 1463, 1464, 947, 2665), a secondary Azeroth assignment, and 46 maps without
explicit instance-area links. Zephras UI map 2665 remains unresolved despite its
name matching 2521. Familiar dungeon gaps include Shadowfang 33, Deadmines 36,
Razorfen Kraul 47, Razorfen Downs 129, Scarlet Monastery 189, Zul'Farrak 209,
Scholomance 289 and Stratholme 329. Their authored seed links remain. Area 279
(Dalaran) has a parent but lacks the export's subzone flag; no inferred link was
added. Full omitted-map diagnostics are preserved in provenance.

`areaNames`, `races`, `skillLines` and `questSort` are deferred reference-only
exports. No consumer/API shape is identified. Race records do not establish a
playability/faction policy; skill records do not establish profession policy.
Quest XP, drops, zone symbols and complete dungeon/navigation inputs were not
supplied by this DBC export.

### Validation results recorded during adoption

The four converter fixture suites passed (10, 11, 9 and 18 tests). The actual adopted
outputs passed semantic comparison across ten files and 30 Correction personas. The
support dataset check passed, including its missing-faction-reference Self-proof.
These are historical results, not a claim that later edits have been revalidated.

## Subsequent local refresh: completed Forever map handoff

After the initial adoption, the approved `Questie-db/QuestieDB-DBC` handoff was manually
completed for the same **1.60.1.69893** build. The local refresh adopts its 1,064 forward
DBC relationships (54 direct and 1,010 parent-resolved) and 54 canonical reverse links.
The many-to-one forward map is deliberately not inverted. The supplied seven forward
policy overrides and three continent/world reverse aliases remain.

The inherited main map tables are no longer an unreviewed multi-expansion seed. Only
**27 referenced ordinary dungeon areas and 13 referenced synthetic dungeon aliases**
retain their old map targets, in a clearly separated compatibility section of each
override string. Those 40 pairs exist solely because the pinned consumer indexes by
UiMapID before resolving instance markers to outdoor entrances. Their retired floor
UiMaps are not valid native Forever maps. No compatibility entry replaces a current DBC
fact; for example, area 1037 now resolves to Wetlands 1437 instead of old floor 293.
Unused SoD map overrides and 70 unused synthetic floor aliases were removed. Authored
symbols, dungeon entrances and instance identities were not changed.

The two reviewed subzone conflicts are now aligned with supplied DBC parent facts:
2657 -> 16651 and 3217 -> 357. Both parent routes now select the same map as their direct
lookup. No coordinate was converted, and none of the 230 other proposed parent additions
was imported. Parent resolution selects a map, not a coordinate frame.

[The map audit](forever-map-override-audit.md) records the field-based inventory, entrance
routing and consumer regression evidence. The focused suite checks actual raw/corrected
spawn fields and quest 7461's NPC objective plus quest 5382's object objective. Removing
compatibility for ordinary dungeon 209 or synthetic area 10022 must fail the same
spawn-derived coverage check. A temporary original-consumer
harness also passed those two objectives with current maps and failed with 10022 removed.
In a disposable copy, Forever validators reported zero findings (15/15 checks), and the
Golden snapshot remained unchanged for all 35,944 entities. Both Self-proofs passed.

The original adoption hashes and report above remain historical. The appended
`local_map_refresh` record in `support/Forever/provenance.json` records the completed
handoff/report hashes, source projections, exact compatibility pairs, parent changes and
current output hashes. The exporter itself was not changed or run. **Exporter generation
will overwrite its manual additions**, and a future import must review these local
compatibility additions instead of replacing them blindly.

## How it works now

### Current support-map limitations

Current map facts come from the completed DBC handoff, with narrowly retained pre-entrance
consumer compatibility described above. Do not use all forward/reverse entries as proof
of native map availability. The 308 unresolved real areas in the handoff, alternative
continent maps 1463/1464 and second Zephras map 2665 remain unresolved; keeping a legacy
dungeon lookup for the consumer does not resolve its missing native map.

The consumer must eventually resolve instances before indexing by UiMapID. Only then can
the compatibility links retire after checking NPC and object objectives. The existing
entrance coordinates, inherited symbolic/instance data and live placement limitations
from the adoption record still require their own review. This refresh supplies no new
coordinate conversion and no live-client validation.

### Ownership and normal generation

Forever owns ordinary files in `data/Forever`, `src/corrections/Forever`,
`l10n/Forever`, and `support/Forever`. There are no Era symlinks or runtime data
fallbacks. Shared schemas, algorithms and initial Classic rules do not imply shared
authored data. Era synchronization must not rewrite Forever inputs.

Normal Generation reads those owned files, applies Static Corrections and Derived Passes,
and encodes the Baked artifact with its owned localization. Source mode uses the same
applicable entity providers and transforms; its existing Base translation limitation is
unchanged. Neither path performs the Era-to-Forever coordinate conversion again. Do not
load legacy Era/Shared providers alongside the equivalent Forever providers.

Add new entity Corrections to `src/corrections/Forever/forever*Fixes.lua`. The six inherited
providers live in `src/corrections/Forever/legacy/` and remain the baseline, not the normal
editing surface. See [Correction authoring](forever.md#correction-authoring) for entry points
and precedence. Other Forever inputs remain directly maintained. Intentional differences
from Era are expected. Validate them with Forever's validators, Verification, Reconstruction,
Source/Baked equivalence, and focused behavior tests. No compiler comparison or full-data
golden refresh is required. See [the integration guide](forever.md) for normal commands and
client-acceptance requirements.

### Candidate-only support export

`questiedb.sh dbc-support` (or `questiedb.ps1`) now reproduces the completed map handoff
and the current 40 compatibility pairs from an explicit existing DBC snapshot plus current
owned Lua overrides. Override policy and comments stay in those Lua inputs; there is no second
exception file to maintain. Hashes identify inputs in the generated report, while pinned
historical hashes live only in acceptance tests. It writes forward/reverse mapping candidates,
a parent-support candidate and an
evidence report under `.out/forever-support/`, never active support. The parent candidate
preserves the owned base/overrides and proposes only missing direct children of the five
reviewed Forever zones. For the pinned build these reproduce all 65 parent relationships
from Questie's former zone overlay; 64 are missing from the current owned parent table.
Other deferred parent additions remain outside this scope. See the
[candidate workflow](../tools/dbc/README.md#generate-forever-map-support-candidates).

The historical external generator above remains unchanged and unsafe to run over its manual
handoff. Active Forever Lua still owns the shipped maps. Candidate adoption and any transfer
of base tables to generated support ownership require separate review; override strings remain
authored inputs. The consumer sentinel fix and version-skew safeguards are still prerequisites
to retiring compatibility links.

### Deliberate conversion or DBC refresh

The converter now lives in this repository under `tools/dbc/`; using it does not require
the original sibling checkout. It remains an opt-in migration tool, not an ordinary build
step. See [the converter guide](../tools/dbc/README.md) for mechanics and command options.

For a deliberate new migration:

1. Choose and record the source revision and explicit Era/Forever DBC builds. Review the
   assumptions about map identity and unchanged world positions.
2. Use an isolated workspace and an existing explicit database path when working offline.
   Inspect dry-run output, coverage, unresolved points and rounding before accepting outputs.
3. Preserve authored Forever changes. The installer protects edited outputs; do not alter
   recorded hashes merely to bypass that protection. Resolve differences deliberately.
4. Review raw entities and Correction providers together so later Corrections cannot restore
   old coordinates. Review support exports separately: partial DBC maps are not wholesale
   replacements for authored navigation data or overrides.
5. Validate accepted bytes and behavior, record the new provenance and outstanding gaps,
   and retain previous migration records in Git. Update current guidance when behavior changes;
   do not turn the historical adoption section into a description of the latest files.

`conversion.json` describes converter outputs and protects reruns. Its six Correction paths
now point into `legacy/`; the move preserved all provider bytes and recorded output hashes.
The support provenance records seed and import evidence, including the historical manifest hash. A later authored edit can legitimately differ from an
adoption hash, but that difference must not be presented as an unchanged converter output.
Initial deferred gaps remain unresolved until a subsequent reviewed change records their
resolution; the historical tables above are not a live completion tracker.

### Focused validation

Run offline from the repository root:

```sh
uv run --no-project python tools/dbc/coordinates.test.py
uv run --no-project python tools/dbc/download.test.py
uv run --no-project python tools/dbc/rewrite.test.py
uv run --no-project python tools/dbc/convert.test.py
lua5.1 tools/dbc/forever-data.test.lua
```

The converter fixture suites exercise geometry, download validation with mocked transport,
token rewriting, rounding, sentinels, semantic validation, output ownership, reruns,
rollback and cancellation.
The dataset check covers actual support shapes, reviewed links, preserved routing
and faction references, including a missing-reference Self-proof. It does not
require future Forever inputs to equal Era.

To revalidate adopted conversion bytes without regenerating them, call
`convert.geometry` with an existing explicit database path, then pass
`{path: Path(path).read_bytes() for path in manifest['files']}` to
`convert.validate`. Check manifest source/output hashes and geometry first. A dry
run validates fresh candidates and is not a substitute for this adopted-byte check.

Tooling remains opt-in. A missing database can trigger a download even on a dry
run; inspect the path first. Never run an installing conversion merely to test
this adoption. Keep the manifest and protected-output behavior intact when making
future authored changes.
