# Forever generated delta-base

`src/corrections/Forever/generated/` imports reviewed offline candidates from
`/home/logon/projects/forever-base-db/generated/objectives-text-import/`. The four providers retain
upstream filenames and module identities: `foreverBaseNpc.lua` / `ForeverBaseNpc`,
`foreverBaseObject.lua` / `ForeverBaseObject`, `foreverBaseQuest.lua` / `ForeverBaseQuest`
and `foreverBaseItem.lua` / `ForeverBaseItem`.

Only the module boundary is adapted: `QuestieLoader:CreateModule`, module imports
and colon `:Load()` replace the standalone entry points. Upstream Quest uses
`Load(QuestieDB, ZoneDB)`: the first context supplies `questKeys`, Forever `raceKeys`,
Forever `classKeys` and `sortKeys`; the second supplies `zoneIDs`. NPC and Object use
`Load(keys, ZoneDB)` when emitting `zoneID`; Item retains `Load(keys)`. Imported Quest,
NPC and Object providers import the real `QuestieDB` and `ZoneDB` modules. NPC/Object
`:Load()` binds its matching keys from QuestieDB before the unchanged upstream body.
Do not attach zone constants to the shared QuestieDB module or change compatibility/runtime code.

A standalone call uses the owning contexts:

```lua
local provider = dofile("generated/foreverBaseQuest.lua")
local foreverEnums = LibQuestieDB.Enum.byExpansion.Forever
local corrections = provider.Load({
    questKeys = LibQuestieDB.Enum.questKeys,
    raceKeys = foreverEnums.raceKeys,
    classKeys = foreverEnums.classKeys,
    sortKeys = LibQuestieDB.Enum.sortKeys,
}, {zoneIDs = LibQuestieDB.Enum.zoneIDs})
```

Preserve the complete upstream function body, including `questKeys` and used `raceIDs`,
`classIDs`, `zoneIDs` and `sortKeys` aliases. Declare only aliases used by the body.

Quest race/class masks use exact named aggregates or sums of named individual bits. Zero
remains literal `0`, never a `NONE` alias. Nonzero quest categories use exact named
`zoneIDs.NAME` or `sortKeys.NAME` constants, with no numeric fallback or extra minus sign.
NPC/Object `zoneID` also uses exact `zoneIDs.NAME` constants. Other fields and spawn map keys
remain numeric. Preserve every row value, inline entity name, Forever Wowhead URL and assumption comment. Starter/finisher
groups retain positional nil holes, including operation operands such as `{nil, {424005}}`;
spawn maps retain zone keys. Fields follow ascending numeric authoring-key indices:
`_remove`, ordinary sets, then `_add`, with canonical schema order inside each group
(`name` first when present). Indices come from the consumer, not a duplicate ordering list.
This is source formatting, not a guarantee about Lua table iteration order. The symbolic category refresh omits only explicit category-zero assignments; all IDs,
non-category values, nonzero category values and the consumer `:Load()` contract remain unchanged.

## Policy and limitations

The Static order remains **raw base -> inherited legacy Corrections -> generated delta-base
-> authored Forever Corrections**. All six legacy providers, including generated reputation
and Item-start sets, precede `ForeverDeltaBaseStatic` (1300). Authored `forever*Fixes.lua`
providers follow in `ForeverStatic` (1400). Dynamic Corrections still override static data.
The effective upstream comparison baseline excludes generated, authored Forever and Dynamic
providers. Later authored corrections remain authoritative, not inputs to extraction.

Ordinary table fields initialize missing records or absent/empty effective-baseline fields.
Partial changes to populated fields use `_add`/`_remove`, including a new group alongside an existing group.
Scalars remain replacements. Uncertain removals are report-only. Operation semantics belong
to the [public API](api.md#table-addremove-operations) and [ADR 0016](adr/0016-table-correction-operations.md).

The import covers missing-record names, levels, explicit quest starter/finisher relationships,
accepted inverse NPC/object links, single-area NPC/object zones, explicit reputation rewards,
known quest categories, eligible new-record spawns, and item categories and source relationships. Selected singleton item starts coordinate item `startQuest` with quest starter
slot 3. Existing names and converted spawns remain unchanged. New spawns in changed map frames
(areas 44, 139, 215 and 1519) are withheld. Item source tabs with at least 200 rows are withheld
because Wowhead can cap lists. Missing references remain reported; unresolved quest giver
endpoints are withheld, while item source references are retained rather than silently pruned.

Quest restrictions now include explicit race/class masks rebuilt from confirmed source
identities and Forever constants. Unsupported masks are withheld whole, never narrowed by
stripping unknown bits. Narrow faction inference applies only to independently materialized
missing quests with absent race evidence and consistent core/infobox faction evidence. It
includes the faction's Skyborne variant and does not backfill existing records.

Separately reviewed, exact-ID assumption policies may supply `requiredRaces = 0` as a last
resort after evidence guards pass. Zero means all races, not no eligible races. Both/None labels,
names or geography alone do not authorize it. Inline comments identify each policy. Race
assumptions do not remove class restrictions; Research Access retains its Mage mask.

Quest `reprewards` supplies signed `{factionId, amount}` pairs in `reputationReward`.
Missing, empty, malformed or duplicate-faction source lists are withheld whole.
Selected missing records receive valid rewards. Existing records require source-new
or explicit Era changes per faction: matching values are suppressed, missing selected
factions are added, and changed amounts replace exact Era-matching target pairs using
remove/add operations. When those removals cover the entire target reward list,
the accepted additions are emitted as one plain set instead. Partial changes keep
operations. Plain sets depend on the reviewed baseline; regenerate if upstream
inputs change. Target-only factions and conflicting amounts are preserved.
Missing source factions never authorize deletion. No bonuses, spillover, caps,
conditional applicability or reputation requirements are inferred.

Quest `zoneOrSort` uses the known signed core category: positive area IDs, negative
QuestSort IDs. Explicit source zero remains comparison evidence but is omitted from
Corrections: an existing quest with an unset numeric category reads as zero. This rule
does not omit race/class masks, levels or reputation amounts whose value is zero.
Categories enrich existing or independently
selected quests; they never select a missing quest by themselves. Unknown identities are
withheld. Existing nonzero effective categories remain authoritative, and unchanged existing
records are not backfilled. `category2`, giver locations, objectives and map membership do
not substitute for category evidence. A category is organizational, not proof of physical
geography or a drawable map. The upstream `quest_categories.py` helper and report
`category_catalog` record the reviewed identities, including Crafting 16941 and Camping -666.

Positive categories use `ZoneDB.zoneIDs`; negative sorts use `QuestieDB.sortKeys`:

```lua
[questKeys.zoneOrSort] = zoneIDs.CRAFTING,
[questKeys.zoneOrSort] = sortKeys.CAMPING,
```

The consumer enum supplies `RUINS_OF_LORDAERON = 16611`, `THE_HALL_OF_THANES = 16919`
and `CRAFTING = 16941` in addition to its existing symbols. These are category identities,
not display names or map routes. Missing exact named constants must fail upstream rendering
rather than produce opaque numeric assignments.

NPC/Object `zoneID` is a best estimate of the primary AreaID, not quest `zoneOrSort`
or a drawable point. Zone evidence enriches independently selected, source-validated rows;
it never selects an entity, changes spawns or overwrites an existing nonzero effective zone.
Zero is omitted. Own-page `location` must identify one distinct positive known area, with
no conflicting numeric mapper areas. Exact `ZoneDB.zoneIDs` symbols are required.

The optional, explicitly supplied zone cache can corroborate direct evidence or supply
fallback only when own location is absent/empty. Fallback needs an explicit singleton
NPC/object Listview row location agreeing with available container/row evidence; membership
alone is insufficient. Invalid, negative, multi-zone or conflicting evidence is withheld,
not bypassed. No item-tab 200-row cap applies. Missing pages/rows do not establish absence
or completeness: the cache is partial/unknown, independently pinned from the entity snapshot.
Recorded cache provenance is retained without opening, hashing or refreshing SQLite files
at import. Multi-zone selection, travel/instance heuristics and coarse-map interpretation
remain deferred to a separately reviewed policy. `entity_zones.py` and the report's
`evidence.entity_zones` identify the extraction and preservation decisions.

Explicit not-in-game and deferred quest-ID policies withhold generated rows before selection
and filter held quest references from item export projections. They do not delete raw data,
existing consumer records or baseline relationships. Assumptions and holdbacks are upstream
policy inputs, not extra runtime providers. Deferred entries retain reasons and revisit
questions and must be reviewed on future data work; export omission does not resolve them.

Quest `objectivesText` stores the heading-adjacent objective summary as ordered lines,
including paragraph breaks. It never substitutes Description, Progress or Completion
dialogue. Existing effective text and explicit clears are preserved; text cannot select
a missing quest. The `quest_text.py` helper hash and extraction policy are recorded in
provenance. Lines are never sorted, deduplicated or patched individually.

This is not a complete gameplay database. Structured objectives, narrative dialogue, chains,
item/currency/XP/money quest rewards,
drop rates, detailed item stats, localization and restrictions beyond the supported policies
remain gaps. Cached evidence and reviewed assumptions do not prove client acceptance.
The existing required-races Derived Pass is unchanged and can infer over explicit zero when
NPC evidence changes. The separate runtime-zero policy decision (phase 5) remains deferred.

## Provenance and validation

[`provenance.json`](../src/corrections/Forever/generated/provenance.json) records upstream
reports and providers, imported providers, generator/reader/helper hashes, assumption and
holdback metadata, extractor, raw consumer inputs, coordinate manifest and effective-baseline
hashes. It retains source-cache paths and registry metadata, selection and field policies,
summary counts, missing-reference counts, separate `inputs.zone_cache` provenance and
zone evidence summaries. SQLite databases are not hashed. Full field-level
evidence remains in the hash-identified upstream reports rather than duplicated here.

[The validation report](forever-delta-base-validation.md) records this run's inventory,
input identity, complete command results, zero-preservation checks and historical findings.
Passing those gates does not establish complete gameplay behavior or client parser support.

## Refresh

1. Review a complete upstream run, never a sample. Read the assumption and holdback policies,
   both reports, unresolved references and withheld evidence. Record unresolved deferred work.
2. Snapshot tracked **working bytes**, including intended dirty inputs, into a disposable
   consumer copy. Record HEAD, status and full file hashes. Verify report baseline and
   generator/helper/policy hashes before and after validation; stop if any input drifts.
3. In that copy only, replace changed providers and adapt their wrappers. Leave unchanged
   providers byte-identical. Preserve row bodies, nil holes and comments. Never copy candidates into `legacy/`, authored providers or raw data.
   Compare every decoded upstream table with imported `:Load()` using the real Forever runtime
   context: Quest takes `Load(QuestieDB, ZoneDB)`; NPC/Object with zones take
   `Load(keys, ZoneDB)`; Item takes `Load(keys)`.
4. Update provenance and literal import witnesses. Inspect generated/Static numeric presence
   separately from public getters, which normalize absent numbers to zero. Record all reviewed
   zeroes through current Derived Passes and both read modes.
5. Run the correction audit, correction/import/native-selection suites, full Forever Generation
   with localization, alias byte comparison, Verification, Equivalence and its Self-proof,
   Reconstruction, Forever artifact tests, Baked import witnesses and all gameplay validators
   with their Self-check. Use the exact commands in the validation report. Continue independent
   checks after failures, recording logs, exit codes and timings. Never update gameplay baselines
   to hide findings or bypass localization or Self-proofs.
   For a formatting-only refresh, complete decoded equality against both the prior standalone
   providers and prior working import, unchanged report data/policy, correction audit, Source
   suites and gameplay Self-checks may reuse the prior full artifact gates. Record that scope
   explicitly; do not claim Generation or artifact gates ran again.
   The authorized entity-zone import uses a focused scope instead: compare every decoded
   report/upstream/imported row and prove that the prior import differs only by the 1,523
   new zone fields. Check every new zone after Static/Derived and through actual Source
   named/generic getters, preservation witnesses, holdbacks, correction audit, Source suites
   and gameplay Self-checks. This is not a new Baked validation or a general waiver of
   artifact gates for future data imports.
6. Obtain fresh review before copying only approved providers, provenance, tests and documentation
   into the working checkout. Do not copy disposable TOCs or validation output.

Static-only generated providers load in Source mode and fold into Generation. Baked file lists
omit them. Neither Generation nor client loading requires the external generator, scraper,
SQLite caches or upstream reports.
