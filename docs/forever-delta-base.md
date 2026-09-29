# Forever generated delta-base

`src/corrections/Forever/generated/` imports reviewed offline candidates from
`/home/logon/projects/forever-base-db/generated/index-order/`. The four providers retain
upstream filenames and module identities: `foreverBaseNpc.lua` / `ForeverBaseNpc`,
`foreverBaseObject.lua` / `ForeverBaseObject`, `foreverBaseQuest.lua` / `ForeverBaseQuest`
and `foreverBaseItem.lua` / `ForeverBaseItem`.

Only the module boundary is adapted: `QuestieLoader:CreateModule`, the QuestieDB import
and colon `Load()` replace the standalone entry points. Upstream Quest uses `Load(QuestieDB)`
with a Forever context supplying `questKeys`, `raceKeys` and `classKeys`; NPC, Object and Item
still use `Load(keys)`. Keep upstream body locals, including `questKeys` and the used `raceIDs`
and `classIDs` aliases, without duplicating them. Unused aliases are omitted.

Quest race/class masks use exact named aggregates or sums of named individual bits. Zero
remains literal `0`, never a `NONE` alias. Maps and other fields remain numeric. Preserve every
row value, inline entity name, Forever Wowhead URL and assumption comment. Starter/finisher
groups retain positional nil holes, including operation operands such as `{nil, {424005}}`;
spawn maps retain zone keys. Fields follow ascending numeric authoring-key indices:
`_remove`, ordinary sets, then `_add`, with canonical schema order inside each group
(`name` first when present). Indices come from the consumer, not a duplicate ordering list.
This is source formatting, not a guarantee about Lua table iteration order. The reviewed
restriction and relationship data and consumer `:Load()` contract remain unchanged.

## Policy and limitations

The Static order remains **raw base -> inherited legacy Corrections -> generated delta-base
-> authored Forever Corrections**. All six legacy providers, including generated reputation
and Item-start sets, precede `ForeverDeltaBaseStatic` (1300). Authored `forever*Fixes.lua`
providers follow in `ForeverStatic` (1400). Dynamic Corrections still override static data.
The effective upstream comparison baseline excludes generated, authored Forever and Dynamic
providers. Later authored corrections remain authoritative, not inputs to extraction.

Ordinary table fields initialize missing records or absent/empty effective-baseline fields.
Populated fields use `_add`/`_remove`, including a new group alongside an existing group.
Scalars remain replacements. Uncertain removals are report-only. Operation semantics belong
to the [public API](api.md#table-addremove-operations) and [ADR 0016](adr/0016-table-correction-operations.md).

The import covers missing-record names, levels, explicit quest starter/finisher relationships,
accepted inverse NPC/object links, eligible new-record spawns, and item categories and source
relationships. Selected singleton item starts coordinate item `startQuest` with quest starter
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

Explicit not-in-game and deferred quest-ID policies withhold generated rows before selection
and filter held quest references from item export projections. They do not delete raw data,
existing consumer records or baseline relationships. Assumptions and holdbacks are upstream
policy inputs, not extra runtime providers. Deferred entries retain reasons and revisit
questions and must be reviewed on future data work; export omission does not resolve them.

This is not a complete gameplay database. Objectives, objective text, chains, quest rewards,
drop rates, detailed item stats, localization and restrictions beyond the supported policies
remain gaps. Cached evidence and reviewed assumptions do not prove client acceptance.
The existing required-races Derived Pass is unchanged and can infer over explicit zero when
NPC evidence changes. The separate runtime-zero policy decision (phase 5) remains deferred.

## Provenance and validation

[`provenance.json`](../src/corrections/Forever/generated/provenance.json) records upstream
reports and providers, imported providers, generator/reader/helper hashes, assumption and
holdback metadata, extractor, raw consumer inputs, coordinate manifest and effective-baseline
hashes. It retains source-cache paths and registry metadata, selection and field policies,
summary counts and missing-reference counts. SQLite databases are not hashed. Full field-level
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
3. In that copy only, replace the four providers and adapt their wrappers. Preserve row bodies,
   nil holes and comments. Never copy candidates into `legacy/`, authored providers or raw data.
   Compare every decoded upstream table with imported `:Load()` using the real Forever runtime
   context: Quest takes `Load(QuestieDB)`; the other providers take their matching `Load(keys)`.
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
6. Obtain fresh review before copying only approved providers, provenance, tests and documentation
   into the working checkout. Do not copy disposable TOCs or validation output.

Static-only generated providers load in Source mode and fold into Generation. Baked file lists
omit them. Neither Generation nor client loading requires the external generator, scraper,
SQLite caches or upstream reports.
