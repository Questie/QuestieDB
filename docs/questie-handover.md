# Questie handover ledger

**Every known difference between QuestieDB's reads and Questie's compiled database, what we
decided to do about it, and whether it is done yet.**

This file exists so the migration cannot lose track of an edge case. It is the register the
reference-implementation differential feeds, and the checklist to execute when Questie
switches over. If a divergence is not in here, either the differential has not been re-run or
we found something new — both are reasons to update this file, never to ignore the row.

Provider decisions live in [`adr/0004-derived-passes.md`](./adr/0004-derived-passes.md) and
[`adr/0007-dynamic-correction-ownership.md`](./adr/0007-dynamic-correction-ownership.md).
Consumer status in this ledger was checked against Questie's `QuestieTDB-implementation` branch at
`f51b3edb89f8eb838295072425ba65826484511b`; it does not describe released Questie behavior. This
file is status, not rationale.

## Regenerating the evidence

```sh
cd QuestieDB
uv run python tools/differential/compiler_diff.py all --questie=../Questie   # ~2 min, all five flavours
uv run python tools/differential/compiler_diff.py Vanilla --self-check       # prove the gate is live
```

Current counts use the full `QuestieInit` pre-compile sequence from the Questie commit in
`QUESTIE_COMMIT`. Totals compared: 397,395 / 659,216 / 979,423 / 1,587,244 / 1,981,559
fields.

Remaining divergences: **20,220 / 35,926 / 55,031 / 86,047 / 99,427**. Almost all are
the approved `minLevelHealth` and `maxLevelHealth` policy: QuestieDB omits obsolete health
data and returns constant placeholders, while the migration oracle still reads compiler
values. Raw coordinate storage removed the former NPC/Object spawn-value classes through the
tool-only Compiler comparison adapter. Re-porting the pinned Corrections resolved the stale
`questFlags` and `reputationReward` classes, the temporary compatibility pass removed every
base-flavor `requiredRaces` divergence, matching Questie's inherited-Correction creation rule
removed every phantom entity, and the Titan split removed six season-only NPCs from the base
flavors. Entity-id sets agree exactly across all five flavors.

The same counts, with a reason per row, are committed under
`tools/differential/compiler-baseline/`. The gate fails on anything new or grown and prints
what is still owed on every run, so a known defect cannot quietly become permanent.

## Questie input sync to `215b0c757`

The input pin advances from `92ab8206f8fa24fdbf772a0d2330abddbc78396a` to
`215b0c757e2cefdffc11414b2c70456e37573cc2`. The mechanical port updates ten correction files and
copies a comments-only change to `support/Zones/uiMapIdToAreaId.lua`. Raw entity data, schema,
constants, the correction manifest, and the Source TOC are unchanged. Blacklists and content-phase
policy remain Questie-owned; the provider-authored SoD required-race rows are untouched.

Validation ran in isolated worktrees, without updating installed or existing Baked artifacts:

- All five flavors passed Generation, Verification, Source/Baked Equivalence, Reconstruction, and
  data validators. The full Lua suite passed 3,339 checks. No validator baseline changes were needed.
- Compiler comparisons passed on all five base flavors with the existing POLICY baselines unchanged.
  Strict active-SoD `Quest.requiredRaces` comparisons matched all 5,534 quests for both factions.
  Differential sensitivity checks passed.
- Reviewed Golden changes affect 187 / 243 / 240 / 228 / 217 existing entities in Vanilla / TBC /
  Wrath / Cata / Mists, with no additions or removals. The snapshots were refreshed for the imported
  quest chains, Object locations, TBC Item drops, and NPC 20931. All five Golden sensitivity checks passed.

Review found one upstream defect retained by this byte-faithful sync: quest 8604 set
`nextQuestInChain = 8604` in `Era/classicQuestFixes.lua`. The subsequent sync below imports its
upstream fix. Matching the pinned compiler alone did not establish that the gameplay data was correct.

## Pre-cutover Questie input sync to `454b9d072`

The input pin advances from `215b0c757e2cefdffc11414b2c70456e37573cc2` to
`454b9d072965ee8f1a881429260fcf1fac8d60f7`, the `Questie/master` tip at synchronization time
(Questie v11.38.0). In a fresh isolated QuestieDB worktree, `generate.lua meta` fetched the exact
commit into a new `.cache/questie/<sha>` directory with `QUESTIE_PATH` unset. All subsequent import
and migration checks used that checkout explicitly; no existing external Questie checkout was used.

The only imported data change fixes quest 8604's `nextQuestInChain` from 8604 to 8605. Raw entity
data, entity localization, schema, constants, support-data values, the Correction manifest, and the
Source TOC are unchanged. Existing Quest XP indentation is preserved. Upstream's new breadcrumb
handling and tracker changes remain consumer-owned; no pre-compile transform changed.

The five Golden snapshots change only quest 8604's hash, plus their producer stamps. Generation
and validation ran in the isolated worktree; existing installed Baked artifacts were not changed.

- All five flavors passed Generation, Verification, Source/Baked Equivalence, Reconstruction,
  validators, compiler comparison, and Golden checks, including the gates' sensitivity checks.
- The full Lua suite passed 3,340 checks, including localization, support-data, correction, and
  ObjectiveFirst fidelity. Compiler and validator baselines remain unchanged.
- Strict active-SoD `Quest.requiredRaces` comparisons matched all 5,534 quests for both Alliance
  and Horde, with no baseline allowances and successful sensitivity checks.

## Confirmed in a live client, 2026-08-19

The offline differential compares two Lua processes. This run compared the shipped artifact
against a running Questie inside the game, which is the only way to prove the client's real
metadata reader behaves like the offline emulator.

**Client:** Classic Era 1.15.9, enUS, Alliance. **Artifact:** `QuestieDB_Vanilla.toc`, baked
mode, producer `build-7169b67`. **Compared against:** Questie 11.36.1 as loaded.
**Scope:** every field of every entity, 4,257 quests, 10,122 NPCs, 14,899 items, 6,666
objects. **590,128 field comparisons, 54 divergences.**

Entity id sets matched exactly on all four types, zero ids on either side alone.

The four baselined Vanilla classes reproduced **to the row**: `Object.spawns` absent-vs-value
24, `Npc.spawns` value 9, `Object.spawns` value 9, `Quest.requiredRaces` value 7. Forty-nine,
the recorded baseline.

The five extra rows are all upstream data drift between 11.33.2, which
`tools/questie-sync/port-corrections.lua` was last run against, and the 11.36.1 in the client. Each was
confirmed at the source line, so all five should disappear on the next re-sync and none of
them is a QuestieDB defect:

| Entity | Field(s) | 11.33.2 (ours) | 11.36.1 (client) |
| --- | --- | --- | --- |
| Quest 1271 | `preQuestGroup`, `preQuestSingle` | `preQuestGroup = {1204,1222}` | `preQuestSingle = {1222}`, `preQuestGroup = {}` |
| Quest 4144 | `specialFlags` | `specialFlags.REPEATABLE` | correction removed upstream |
| Quest 5151 | `extraObjectives` | `Questie.ICON_TYPE_INTERACT` (17) | `Questie.ICON_TYPE_OBJECT` (4) |
| Object 188135 | `name` | not set | `objectKeys.name = "Ice Stone"` |

Quest 5151 doubles as an independent check on the constants pipeline: 17 and 4 are exactly
what the live `Questie.ICON_TYPE_*` globals hold and what
`src/corrections/enum/constants.lua` records, so the symbolic constants resolved correctly on
both sides and only the source file changed.

Two further sweeps ran clean in the same session:

* **Storage contract**, 1,050,268 reads across all four types: zero numeric nils, zero empty
  tables leaking through, zero never-nil violations, zero wrong types.
* **Correction Overlay**: `Apply()` 1.45 ms, withdrawal 1.22 ms. A `{}` correction cleared a
  field without touching its siblings, an added entity was readable and enumerable with
  `Exists` true, `GetRaw` still returned base data, `GetProvenance` named the registrar for
  touched fields and `QuestieDB` for untouched ones, and withdrawal restored the original
  coordinates exactly. This is the mechanism the gathering-node POLICY row depends on,
  verified end to end.

All ten locale variants resolved, CJK and Cyrillic included, with `esMX` distinct from
`esES`.

Read cost and memory from the same session are in
[`read-performance.md`](./read-performance.md).

## Divergence register

`FIX` = we intend to match Questie. `POLICY` = permanent and correct, the consumer closes it.
`UNTRIAGED` = nobody has looked yet.

| Class | Vanilla | TBC | Wrath | Cata | Mists | Status | Disposition |
| --- | ---: | ---: | ---: | ---: | ---: | --- | --- |
| `Npc.minLevelHealth` value | 10,090 | 18,499 | 29,601 | 46,311 | 45,870 | **POLICY** | Deprecated health data is not stored. QuestieDB returns the documented `0` placeholder for known NPCs; compiler parity is intentionally not required. |
| `Npc.maxLevelHealth` value | 10,106 | 17,403 | 25,406 | 39,712 | 53,533 | **POLICY** | Same policy, with the documented `1` placeholder. |
| `Object.spawns` absent-vs-value | 24 | 24 | 24 | 24 | 24 | **POLICY** | Gathering nodes. QuestieDB keeps all 17,191 spawn points; Questie suppresses them with a registered Dynamic Correction. Permanent and correct. |

Entity **id sets match exactly** on all five flavours and all four types — zero
`ID_ONLY_IN_*` rows. Storage, generation and enumeration are not implicated in anything above.

## Closed

| Class | Was | Closed by |
| --- | ---: | --- |
| `Quest.objectives` absent-vs-`{}` | 1,654 / 2,708 / 3,574 / 5,947 / 6,868 | Never-nil structures. `readers["objectives"]` and `readers["questgivers"]` always construct a table, so the field reads `{}` for an entity that exists. `normalize.default` is the single definition; Source mode reaches it through `normalize.field`, Baked mode caches it per entity type, and `encode` still omits the line — no stored bytes. |
| `Quest.startedBy` absent-vs-`{}` | 84 / 372 / 557 / 4,596 / 5,090 | Same. |
| `Quest.finishedBy` absent-vs-`{}` | 76 / 366 / 527 / 470 / 1,175 | Same. |
| `Quest.objectives` value | 2,495 / 3,690 / 5,200 / 8,158 / 9,451 | Element-level nil→0. Questie's tuple writers emit `value or 0` and its readers read every slot, so `objective[3]`, `spellObjective[3]` and `killCredit[4]` come back as `0`. Padded in `normalize`, so both modes agree by construction. |
| `Quest.extraObjectives` value | 7 / 25 / 54 / 99 / 116 | Same rule, row slot `[4]` (objectiveIndex). |
| `Npc.waypoints` value | 454 / 808 / 1,095 / 1,153 / 1,158 | `src/derived/waypoints.lua`, the first Derived Pass. Verified at **zero** on all five flavours, with `verify`, `equivalence`, `reconstruct` and determinism all green. |
| `Object.waypoints` value | – / – / – / 3 / 3 | Same pass. |
| `Npc.spawns` Correction Overlay coordinates | 9 / 11 / 25 / 41 / 59 | ADR 0006 makes raw coordinates the production contract. The migration-only Compiler comparison adapter quantizes base data but leaves Dynamic Corrections raw, matching Questie's `QuerySingle` behavior without carrying compiler loss into storage. |
| `Object.spawns` Correction Overlay coordinates | 9 / 11 / 13 / 18 / 19 | Same adapter policy. |
| Phantom entities from inherited Corrections | 0 / 0 / 1 / 4 / 99 ids, plus inherited fields | The Correction registry derives each file's source expansion and applies Questie's `noNewEntries` rule when a later flavor inherits it. Older Corrections can update surviving rows, but only a field-1/name Correction may create a missing entity. |
| `Quest.questFlags` value | – / – / 2 / 72 / 72 | Resolved by the pinned Correction re-port. |
| `Quest.reputationReward` absent-vs-value | – / – / 1 / 1 / 1 | Resolved by the pinned Correction re-port. |
| `Quest.requiredRaces` value | 1 / 27 / 339 / 693 / 315 | `src/derived/requiredRaces.lua` temporarily transcribes Questie's exact base-flavor inference and reaches zero divergences. Explicit corrections remain the final fix in [#1](https://github.com/Questie/QuestieDB/issues/1). For active SoD, `src/corrections/Sod/sodRequiredRaces.lua` supplies 25 QuestieDB-owned Dynamic Correction rows. Alliance and Horde comparisons now match pinned Questie's returned values for all 5,534 SoD quests. |
| WotLK NPC Static Correction order | – / – / 20 / 20 / 20 | The generated manifest now follows Questie: `LoadAutomatics()` first, then hand-authored `Load()`. This removed 16 wrong-value and four absent-vs-value spawn divergences per affected flavor. A real overlap on NPC 30208 guards the order. |
| TBC prerequisite fields absent-vs-value | – / 3 / – / – / – | Questie's active TBC content phase advanced from 2 to 3, resolving the three compiler divergences for quests 10944 and 11007. `LoadContentPhaseFixes` remains excluded from QuestieDB under ADR 0007 because content-phase selection is consumer policy. |

## Deliberately not reproduced

| Upstream behaviour | Why not |
| --- | --- |
| `l10n:Initialize` writing translations into the entity tables | Replaced by the l10n overlay, which is what removes the `dbCompiledLang` recompile. Verified inert at enUS, so it does not affect the differential. |
| `Townsfolk.Initialize()` | Not entity data. |

## Consumer-owned Dynamic Corrections

The TOC dependency/loading work is already complete. The remaining integration starts with
`LibQuestieDB` loaded and uses its generic Correction registrar; QuestieDB has no
consumer-specific entry point or parameterized Correction API.

Ownership follows the information needed to choose or construct a Correction:

- QuestieDB owns Corrections based only on provider data or generic WoW facts it can determine
  itself, such as class, race, faction, expansion, and season.
- Questie owns Corrections based on Questie runtime state or policy, including Darkmoon event
  state, gathering-node suppression, content phases, settings, projections/caches, and
  asynchronous Item repair.

Questie keeps the state, tables, and refresh trigger. It registers a function that returns the
currently selected Correction table:

```lua
local activeNpcCorrections = {}
local questieCorrections = LibQuestieDB.GetRegistrar("Questie")

questieCorrections.RegisterRuntimeCorrection(
    "Npc",
    "DarkmoonFaire",
    function()
        return activeNpcCorrections
    end,
    100
)

-- Questie's event code owns this selection and calls Apply after every change.
activeNpcCorrections = selectedDarkmoonNpcCorrections or {}
questieCorrections.Apply()
```

Registration happens once. Questie's event or policy code updates the captured table and calls
`Apply()` after the initial selection and every later change. Re-applying rebuilds owner
`Questie` in place: it replaces the previous result, does not accumulate old locations, and
does not change owner precedence. Returning an empty Correction table withdraws that registered
Correction's previous values. `GetRaw` continues to expose unchanged provider data, while normal reads expose
the composed view and `GetProvenance` reports `"Questie"` for fields Questie currently wins.

For Darkmoon Faire specifically:

- The database coordinates remain valid entity data in QuestieDB.
- Questie retains the existing correction tables and chooses among them from `QuestieEvent`
  state.
- Questie registers the selected NPC Correction through owner `"Questie"` and reapplies when
  the event location changes.
- QuestieDB does not receive location booleans, know the schedule, select a location, or expose
  a Darkmoon-specific API.

Questie-side tests should cover the initial location, every supported transition, withdrawal of
old coordinates, unchanged `GetRaw` data, and `"Questie"` provenance. Darkmoon behavior itself
belongs in Questie's tests; QuestieDB tests only the generic registrar lifecycle.

Since the data-shaped slot API landed, the captured-table pattern above is only needed for
corrections large enough to warrant lazy materialization. A state-driven consumer correction is
simpler as a write-through slot — no provider function, no explicit apply, and only the written
datatype recomposes:

```lua
registrar.Set("Npc", "DarkmoonFaire", selectedDarkmoonNpcCorrections)
registrar.Set("Npc", "DarkmoonFaire", nil)   -- withdraws when no faire is active
```

See "Data-shaped corrections: `Set`" in docs/api.md.

### External translation addons

#### Historical assessment

The first assessed Questie migration converted legacy `QUESTIE_LOCALES_OVERRIDE` entity lookups
into ordinary entity Corrections. It supported only the two-slot Quest shape and conflicted with
QuestieDB's later locale-first read contract. The limitation recorded for
[Jakanis/QuestieUkrainianTranslation commit `0d6e1d3`](https://github.com/Jakanis/QuestieUkrainianTranslation/commit/0d6e1d3474972c54d205e1368689bf31011f2f4b)
was accurate for that revision. It is retained as migration history, not current compatibility
guidance.

#### Current consumer integration

The integration built on revision `cb986af34` in checkout
`/home/logon/projects/Questie-clones/Questie-tdb-claude`, branch `QuestieTDB-implementation`, passed
1,609 consumer tests with real-provider conformance, production lint, and loader validation.
Support-wrapper checks passed for all five flavors and both factions. This is not evidence of a
released Questie revision or a completed live smoke matrix.

`l10n.InitializeUILocale` now handles UI strings only. Login Initialization then requires Contract
Version 2 and a callable `LibQuestieDB.l10n.SetCorrection` before selecting the provider locale and
calling `l10n.PublishLocaleOverrideEntityNames`. The adapter converts all four optional entity
lookups to rows keyed by QuestieDB's numeric entity field indexes. It publishes the four slots as
owner `QuestieLocalesOverride`, name `EntityNames`.

The Quest adapter accepts both `{name, objectives}` and the older
`{name, description, objectives}` shape. A present third slot is treated only as objectives, so a
malformed third slot cannot make the description become objective text. Unknown IDs and malformed
lookup entries are skipped. Empty or malformed fields are omitted while other valid fields in the
same row can still publish. `enUS` entity overrides are not published. Re-publishing replaces each complete slot; removing the external global or changing
its locale withdraws the old locale's four slots without touching other names under the owner.

The adapter also registers a valid inactive locale, so a later `SetLocale` can activate it without
re-reading the external addon. This includes custom locales such as `ukUA`: `SetCorrection` accepts
any non-empty locale other than `enUS`, while the generated Base locale list and `localeIndex`
remain the same nine entries. Missing custom-locale fields fall through to the corrected or base
English entity value.

A translation addon can eventually publish Dynamic Translation Correction rows directly under its
own owner. That gives provenance to the direct source and removes Questie from the entity data path:

```lua
LibQuestieDB.l10n.SetCorrection(
    "MyTranslationAddon", locale, "Item", "names", itemRows)
LibQuestieDB.l10n.SetCorrection(
    "MyTranslationAddon", locale, "Quest", "text", questRows)
LibQuestieDB.l10n.SetCorrection(
    "MyTranslationAddon", locale, "Npc", "names", npcRows)
LibQuestieDB.l10n.SetCorrection(
    "MyTranslationAddon", locale, "Object", "names", objectRows)
```

Requirements for that direct-publisher migration:

1. Build rows with numeric **entity field indexes** from `LibQuestieDB.Meta`, not compact lookup
   tuples or Localization-block column indexes.
2. Pass the target locale with every slot. Locale selection activates only that locale's slots, so
   changing locale does not require reapplying entity Corrections.
3. Use a non-empty locale other than `enUS`. Custom locales need no generated Base block.
4. Do not rely on translations to add entities. A row becomes visible only while the composed
   entity database reports that ID as existing.
5. Skip empty scalar strings and empty or sparse objective lists; the interface rejects them.
   Withdraw a complete named slot with `nil` when it is no longer owned.
6. Publishing after a localized read is safe because an active-locale write invalidates that
   entity type's reads and Name index. Publishing before Questie's entity reads avoids doing that
   work twice.
7. Keep `QUESTIE_LOCALES_OVERRIDE.locale`, `.localeName`, and `.translations` while Questie still
   consumes the addon's UI strings.

Once known translation addons publish through the localization interface, Questie can stop
adapting their entity lookup fields.

## Questie-side checklist

Status below reflects the assessed `QuestieTDB-implementation` branch, not released Questie.
Each item is behavior that would otherwise be lost by deleting the compiler and its neighbours.

- [x] **Register the gathering-node Dynamic Correction.** The migration branch registers
      `GatheringNodeDisplayPolicy` under owner `Questie`, preserving the 24-object suppression
      policy without changing QuestieDB's provider data.
- [x] **Remove entity writes from `l10n`.** Questie retains UI translations, zone names,
      categories, and locale selection. `QuestieDBLocale` owns entity-locale orchestration.
- [x] **Replace the object-name scan with the provider Name index.** Object ID lookup uses
      `LibQuestieDB.Object.IdsByName`; tooltip registrations retain their consumer-owned set.
- [x] **Bind `LibQuestieDB.ObjectiveFirst`.** Questie binds all five tables before rich Quest
      projections run. QuestieDB scopes their contents by flavor and season as recorded in
      [ADR 0012](./adr/0012-objective-first-applicability.md).
- [x] **Translate `extraObjectives` descriptions while building Questie's runtime objectives.**
      QuestieDB stores row slot `[3]` as the enUS localization key; Questie translates it in the
      consumer projection.
- [x] **Retain Questie's Darkmoon correction tables.** The migration branch selects and applies
      them through owner `Questie`; QuestieDB owns no Darkmoon-specific runtime API or state.
- [x] **Preserve the TBC content-phase prerequisite Correction** for quests 10944 and 11007 as
      Questie-owned policy.
- [x] **Retain asynchronous missing-Item repair.** The migration branch publishes its results as
      `RuntimeItemRepair` under owner `Questie`; scheduling and cache knowledge stay consumer-owned.
- [x] **Consume support data through `LibQuestieDB.Support`.** The current review checkout binds
      Zone, XP, Drop, and faction-template data from the provider while keeping Questie's wrapper
      functions and policy. The local payload files remain in the tree but are no longer loaded by
      the flavor TOCs. Mists still combines Mists Wowhead drops with Cata private-server drops.
- [x] **QuestieDB's waypoint pass is verified at zero divergences** on all five flavours, so
      `QuestieCorrections:PreCompile()` and `OptimizeWaypoints` can be deleted from Questie at
      switch-over. `Modules/Libs/RamerDouglasPeucker.lua` is byte-copied into QuestieDB
      (`src/derived/RamerDouglasPeucker.lua`) and re-diffed by `tools/questie-sync/port-corrections.lua`, so
      it goes too — but note QuestieDB *transcribes* `OptimizeWaypoints` itself, and the
      reference differential is the only thing guarding that transcription.
- [x] **Consume QuestieDB's derived `requiredRaces` values.** The migration branch no longer
      contains Questie's inference pass. Base-flavor output and active SoD values are verified.
      QuestieDB preserves pinned Questie's 25 SoD results as owned Dynamic Corrections, including
      masks whose gameplay meaning is questionable because Questie inferred them before applying
      faction-specific starter changes. [#13](https://github.com/Questie/QuestieDB/issues/13)
      records the audit; revisiting those masks is deferred unless player reports make it relevant.
- [ ] **Audit `QuestieCorrections.lua` rather than deleting it.** It is the file where derived
      logic hid; the port copies correction *files* only, so anything in the orchestrator was
      never carried across. This ledger is the audit's output so far — re-read the file before
      removing it.
- [ ] **Check `QuestieInit.lua:118-134` for anything added since 2026-08-19.** A new pre-compile
      transform would be invisible to every gate we have except this differential.

## Provider follow-up from the consumer audit

The entity differential is strong, but it does not cover every value Questie consumes. The
cutover audit found provider work outside ordinary entity-field parity:

- Built-in lookup overrides and Titan zhCN translations are implemented with locale-first reads
  and Translation Corrections ([#14](https://github.com/Questie/QuestieDB/issues/14)). The isolated
  five-flavor generation and full gate passed; custom-locale support also passed focused checks.
- Zone, XP, Drop, and faction-template support data is synchronized and covered by a semantic drift
  gate ([#15](https://github.com/Questie/QuestieDB/issues/15)). The current Questie checkout consumes
  it through `LibQuestieDB.Support`; consumer tests and all five-flavor wrapper checks passed.
- Titan corrections require both the Wrath flavor and active season 109
  ([#16](https://github.com/Questie/QuestieDB/issues/16)). The complete all-flavor matrix and
  accepted-record review passed, and the GitHub issue is closed.
- `ObjectiveFirst` now has Source, Baked, and stripped-package parity under the documented
  expansion and season boundary ([#17](https://github.com/Questie/QuestieDB/issues/17),
  [ADR 0012](./adr/0012-objective-first-applicability.md)).
- Differential coverage needs to include side channels and a working SoD oracle
  ([#19](https://github.com/Questie/QuestieDB/issues/19)).

## Tracked on GitHub

Work is tracked at [`Questie/QuestieDB`](https://github.com/Questie/QuestieDB/issues).
This ledger records the implementation status even when the corresponding GitHub issue has not
yet been closed.

| Issue | Work | Status here |
| --- | --- | --- |
| [#1](https://github.com/Questie/QuestieDB/issues/1) | Materialize the derived `requiredRaces` patch | Open |
| [#2](https://github.com/Questie/QuestieDB/issues/2) | Triage the three unexplained divergence classes | Resolved by the pinned re-port and WotLK order fix |
| [#3](https://github.com/Questie/QuestieDB/issues/3) | Decide whether the overlay quantizes coordinates | Resolved by ADR 0006: production stays raw; only base values adapt for the compiler differential |
| [#4](https://github.com/Questie/QuestieDB/issues/4) | Validator baseline is stale, 78 new findings | Reviewed and refreshed in `validator-baseline-review.md` |
| [#5](https://github.com/Questie/QuestieDB/issues/5) | Baked artifacts ship static correction bodies | Implemented by package-time stripping; live-client acceptance remains with #6 |
| [#6](https://github.com/Questie/QuestieDB/issues/6) | Mists in-client acceptance at 97.7 MiB | Open |
| [#7](https://github.com/Questie/QuestieDB/issues/7) | Differential missing from `release.yml` | Resolved; release publication depends on the matrix |
| [#8](https://github.com/Questie/QuestieDB/issues/8) | Pin the Questie input checkout | Resolved by `QUESTIE_COMMIT` and shared workflow checkout |
| [#9](https://github.com/Questie/QuestieDB/issues/9) | Decide where corrections are authored after phase 13 | Open |
| [#10](https://github.com/Questie/QuestieDB/issues/10) | Institutionalize the live-client probe ritual | Open |
| [#11](https://github.com/Questie/QuestieDB/issues/11) | Decide the decoded-cache budget | Open |
| [#12](https://github.com/Questie/QuestieDB/issues/12) | Distribution polish: flavor table, wrong-flavor no-op, `builtAt` | Open |
| [#13](https://github.com/Questie/QuestieDB/issues/13) | Preserve active-SoD `requiredRaces` values | Implemented with 25 owned Dynamic Correction rows; gameplay-policy review deferred unless relevant |
| [#14](https://github.com/Questie/QuestieDB/issues/14) | Import lookup overrides and Titan zhCN corrections | Open |
| [#15](https://github.com/Questie/QuestieDB/issues/15) | Synchronize support data and add drift validation | Implemented in `5e0fc2c`; GitHub issue remains open |
| [#16](https://github.com/Questie/QuestieDB/issues/16) | Restrict Titan corrections to Wrath | Closed; full all-flavor matrix passed |
| [#17](https://github.com/Questie/QuestieDB/issues/17) | Keep `ObjectiveFirst` flavor-scoped in Source mode | Implemented and validated; GitHub issue remains open |
| [#18](https://github.com/Questie/QuestieDB/issues/18) | Former parameterized-correction follow-up | Closed — superseded by ADR 0007 |
| [#19](https://github.com/Questie/QuestieDB/issues/19) | Cover correction side channels and SoD in differential tests | Open |
