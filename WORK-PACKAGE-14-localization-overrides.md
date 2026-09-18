# Work package: QuestieDB issue #14, localization overrides

Issue: https://github.com/Questie/QuestieDB/issues/14

Status: ready for implementation.

## Objective

Preserve every effective built-in entity localization override from pinned Questie data, including Titan Reforged zhCN values, without changing the deliberate Source-mode localization contract.

## Repositories and reference data

Implement and test this work in:

```text
/home/logon/projects/Questie-clones/Questie-toc/QuestieTDB
```

The localization oracle is the provider's sibling `../Questie` checkout at the revision recorded in `QuestieDB/QUESTIE_COMMIT`. Do not use this work-package checkout as the oracle because its entity lookup sources have been removed. Do not fetch or reset the pinned checkout during this task.

Read `QuestieDB/AGENTS.md`, `DESIGN.md`, `docs/api.md`, and the localization/storage ADRs before editing.

## Current baseline

`generator/l10n.lua` reads the ordinary per-expansion entity lookup files and generates compressed Baked localization blocks for nine non-English locales. It does not load `Localization/lookups/lookupOverrides.lua`.

This drops effective overrides for these known IDs:

```text
Quest: 63866, 64319, 78752, 78753, 83713, 83714, 83717, 87379,
       93975, 94577, 94579, 95158, 95251, 95252
Item:  185956
```

Titan Reforged adds a separate zhCN layer for Wrath, season 109:

- quests 6805 and 7787: `name` and `objectivesText`;
- quests 8184 through 8192: `name`.

Titan's English Dynamic Corrections outrank ordinary localization. A normal zhCN localization row cannot overwrite those corrected English fields under the current read precedence.

Issue #16, Titan's Wrath-only expansion gate, is closed and is not a blocker for this package.

## Scope

1. Parse or materialize all effective entity entries from pinned Questie's `Localization/lookups/lookupOverrides.lua`.
2. Merge ordinary overrides into each applicable flavor and locale during Baked localization generation, with the same entity-existence filtering and effective row semantics as Questie.
3. Add a complete drift check tied to `QUESTIE_COMMIT`. Spot checks of the currently known IDs are necessary tests, but are not enough to guard the source file.
4. Represent Titan zhCN values so they apply only when all three conditions hold:
   - active flavor is Wrath;
   - active season is 109;
   - effective entity locale is `zhCN`.
5. Preserve correct behavior when the effective locale changes at runtime through `LibQuestieDB.l10n.SetLocale`.
6. Document how authored overrides, normal localization blocks, and variant corrections interact.
7. Leave focused evidence that issue #19 can include in its release gate.

## Non-goals

- Adding ordinary localization overlays to Source mode. Source mode intentionally lacks generated localization metadata.
- Claiming Source/Baked localization equality where the public modes deliberately differ.
- Fixing ObjectiveFirst scoping, support-data drift, or SoD `requiredRaces`.
- Reopening issue #16 or broadening Titan to another flavor.
- Changing translation content beyond what exists in the pinned Questie source.
- Editing the current Questie consumer checkout.
- Live-client or external translation-addon acceptance.

## Implementation anchors

- `generator/l10n.lua`: lookup layout, input preflight, extraction, filtering, and block generation.
- `src/read/shared.lua`: precedence between base data, localization, and Corrections.
- `src/l10n/` and `src/api.lua`: runtime locale selection and cache behavior.
- `src/corrections/Titan/`: Titan English correction sources.
- `src/corrections/register.lua`: `IsTitanReforgedActive` and the Wrath plus season 109 boundary.
- `test.lua`, suites `generation-inputs`, `l10n-blocks`, `l10n`, `read-contract`, and `personas`.
- Pinned oracle: `../Questie/Localization/lookups/lookupOverrides.lua`.
- Pinned invocation semantics: `../Questie/Database/Corrections/QuestieCorrections.lua`.

Do not assume the override file has the same shape as ordinary locale files. Preserve Questie's whole-row replacement semantics before mapping rows into compact per-field columns. Filter out IDs absent from the applicable flavor's entity database as Questie does.

## Required design decision

Choose and record the representation for Titan zhCN. A locale-gated Dynamic Correction is one plausible option because it can outrank Titan's English correction and work without ordinary Source localization metadata. Another representation is acceptable if it preserves precedence, runtime locale changes, season withdrawal, Source-mode intent, and Baked behavior.

Keep this decision local to Titan zhCN. It must not turn Source mode into a general localization build.

## Suggested implementation sequence

1. Build a test fixture that executes the pinned override source under each supported locale and records its effective Quest and Item rows.
2. Add a complete source-to-generated drift comparison, then establish the existing failure.
3. Merge ordinary overrides into Baked extraction at the same logical point Questie uses.
4. Implement Titan zhCN using the documented representation and existing Titan persona gates.
5. Exercise locale transitions, including entering and leaving zhCN while season 109 is active.
6. Regenerate in an isolated checkout and verify every applicable flavor/locale combination.

## Required tests and acceptance criteria

Ordinary overrides:

- Every effective pinned Quest and Item override appears in each applicable generated flavor and locale.
- All listed known IDs have explicit field-value assertions.
- IDs absent from a flavor remain absent rather than creating new entities.
- Unaffected locales and fields keep their ordinary lookup values.
- The drift check fails when a pinned override is added, removed, or changed.

Titan zhCN:

- Wrath plus season 109 plus zhCN returns the pinned localized fields for quests 6805, 7787, and 8184 through 8192.
- Plain Wrath, every non-Wrath flavor, every other season, and every other locale do not receive Titan zhCN values.
- Switching from zhCN to another locale removes stale Titan zhCN values; switching back restores them.
- English Titan corrections remain correct and do not permanently mask zhCN.
- Source and Baked behavior follows the documented representation. Ordinary Source localization remains unavailable by design.

Do not accept a manually maintained list of the known IDs as the drift mechanism. The complete pinned source is the contract.

## Validation

Run focused checks from the QuestieDB root:

```sh
lua5.1 test.lua generation-inputs l10n-blocks l10n read-contract personas lua-types
lua-language-server --check=src/types --checklevel=Warning --check_format=pretty
```

Only update `src/types/*.t.lua` and `src/types/consumer.test.lua` if the public shape or behavior contract changes. `ObjectiveFirst` and the current localization API are already declared.

Before completion, regenerate and run the full gate against the pinned oracle:

```sh
./questiedb.sh all --questie=../Questie
```

This command is heavy and writes generated artifacts. Run it only in an isolated QuestieDB checkout or output arrangement that cannot alter a symlinked daily-driver addon. Get confirmation first if the checkout's safety is unclear.

Also run:

```sh
git diff --check
```

## Deliverables

- Generator/runtime changes and focused tests in QuestieDB.
- Complete pinned-override drift coverage.
- Documentation of ordinary override merge semantics and Titan zhCN precedence.
- Evidence for all known IDs, negative persona cases, locale transitions, and the full gate.
- A concise note for issue #19 identifying the focused check it should invoke.

## Coordination

This package may share Wrath season 109 persona utilities with issue #17. Coordinate common test-helper edits, but keep localization assertions here. Issue #19 aggregates the finished check and must not absorb this implementation.
