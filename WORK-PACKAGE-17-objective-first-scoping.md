# Work package: QuestieTDB issue #17, ObjectiveFirst scoping

Issue: https://github.com/Questie/QuestieTDB/issues/17

Status: ready for implementation.

## Objective

Publish exactly the five objective-ordering hint tables applicable to the active flavor and season. Source and Baked modes must match each other and pinned Questie's intended load boundary.

## Repositories and reference data

Implement and test this work in:

```text
/home/logon/projects/Questie-clones/Questie-toc/QuestieTDB
```

Use the provider's sibling `../Questie` checkout at the revision in `QuestieTDB/QUESTIE_COMMIT` as the source and behavior oracle. Do not use this work-package checkout as the oracle, and do not fetch or reset the pinned checkout during this task.

Read `QuestieTDB/AGENTS.md`, `DESIGN.md`, `docs/api.md`, and the correction ADRs before editing.

## Current baseline

Correction files assign objective-order hints as module-load side effects, for example:

```lua
QuestieCorrections.itemObjectiveFirst[503] = true
```

`src/corrections/compat.lua` collects those assignments into five shared tables and `src/corrections/_end.lua` publishes them as `LibQuestieDB.ObjectiveFirst`.

The problem occurs before correction registration:

- Source mode loads every expansion's correction files, so later-expansion hints can leak into older flavors.
- Baked Vanilla includes SoD files that contain required Dynamic providers. Their top-level hint assignments run even when registration later rejects SoD on plain Vanilla.
- Registration gates cannot undo file-load side effects that already happened.

Known examples:

- Cata's hint for quest 52 appears on Vanilla in Source mode;
- MoP spell hints for quests 10068 through 10073 appear on TBC and Wrath;
- plain Vanilla can receive SoD event hints.

The public `ObjectiveFirst` value and all five table fields are already declared in `src/types/LibQuestieDB.t.lua`, `src/types/General.t.lua`, and `src/types/consumer.test.lua`. Do not add duplicate declarations.

## Scope

1. Define the applicable five-table contents for each base flavor and supported seasonal persona from pinned Questie's actual correction file boundaries.
2. Scope collection or publication early enough that top-level assignments from inapplicable files cannot leak.
3. Make Source and Baked publish identical full table contents for:
   - Vanilla without a season;
   - active SoD;
   - TBC;
   - Wrath without a season;
   - Wrath season 109;
   - Cata;
   - Mists.
4. Add full-table parity tests for all five fields:
   - `killCreditObjectiveFirst`;
   - `objectObjectiveFirst`;
   - `itemObjectiveFirst`;
   - `eventObjectiveFirst`;
   - `spellObjectiveFirst`.
5. Compare against pinned Questie applicability, not merely Source against Baked. Two equally polluted modes are still wrong.
6. Preserve package-time static-body stripping and its module-side-effect validation.
7. Update `docs/api.md` to remove the current limitation and describe final flavor/season behavior.
8. Leave focused evidence that issue #19 can add to its aggregate release gate.

## Non-goals

- Changing the shape or mutability contract of `LibQuestieDB.ObjectiveFirst`.
- Moving hints into entity fields.
- Fixing support-data selection, localization, or SoD `requiredRaces`.
- Reworking correction registration that occurs after files load unless the selected design needs a narrow shared boundary.
- Building issue #19's broad release orchestration.
- Editing copied correction values solely to compensate for loader leakage.
- Live-client testing or release publication.

## Implementation anchors

- `src/corrections/compat.lua`: current unscoped collection tables.
- `src/corrections/_begin.lua` and `src/corrections/_end.lua`: collection and publication boundaries.
- `src/config.lua`, `config.correctionFiles`, `sourceFileList`, and `bakedFileList`: file selection.
- `src/corrections/register.lua`: expansion, SoD, and Titan gates that currently run after side effects.
- `src/corrections/*/*QuestFixes.lua`: top-level hint assignments.
- `tools/strip-static.lua`: package-time side-effect preservation checks.
- `test.lua`, suites `toc`, `corrections`, `correction-fidelity`, `personas`, `lua-types`, and package-strip coverage within the correction tests.
- `src/types/General.t.lua`, `src/types/LibQuestieDB.t.lua`, and `src/types/consumer.test.lua`: existing public declaration.
- Pinned Questie TOCs and correction initialization under `../Questie`.

Do not hide flavor/season policy in an opaque one-use helper. Keep the applicability rule visible where files are selected or their side effects are admitted.

## Suggested implementation sequence

1. Build a pinned-oracle extractor that captures all five tables for each flavor/persona using Questie's applicable files.
2. Add a focused table diff and establish the current leaks. Include deliberate negative controls so the comparator proves it can fail.
3. Choose the smallest load-boundary fix. Registration-only filtering is insufficient because it runs too late.
4. Apply the same rule to Source and Baked without breaking required Dynamic correction files.
5. Test all personas and full table contents, then run package stripping and compare the staged package too.
6. Update API documentation and only change LuaLS declarations if the public shape actually changes.

## Required tests and acceptance criteria

Base flavor coverage:

- Each flavor contains every hint from applicable current and earlier expansion sources.
- No flavor contains a hint introduced only by a later expansion.
- Quest 52 does not leak from Cata into Vanilla.
- Quests 10068 through 10073 do not leak from MoP into TBC, Wrath, or Cata unless pinned Questie explicitly includes them there.

Seasonal coverage:

- Plain Vanilla excludes every SoD-only hint.
- Active SoD contains exactly the SoD additions on top of Vanilla.
- Plain Wrath and Wrath season 109 match the pinned oracle independently.
- A seasonal persona on the wrong expansion does not activate that variant's hints.

Mode and package coverage:

- Source and Baked full tables are deeply equal for every tested persona.
- Both modes independently match the pinned oracle.
- Loading personas in sequence does not retain hints from the previous run.
- A stripped packaged artifact retains every applicable top-level hint and no inapplicable hint.
- Existing ObjectiveFirst table identities and read-only consumer contract remain intact.

## Validation

Run focused checks from the QuestieTDB root:

```sh
lua5.1 test.lua toc corrections correction-fidelity personas lua-types
lua-language-server --check=src/types --checklevel=Warning --check_format=pretty
```

Run the repository's package-strip-focused correction checks if implementation adds a dedicated suite; do not rely only on Source-mode tests.

Before completion, run:

```sh
tools/check.sh all --questie=../Questie
```

The full gate is heavy, generates artifacts, and writes under the checkout. Run it only in an isolated QuestieTDB checkout or output arrangement that cannot alter a symlinked daily-driver addon. Get confirmation first if the checkout's safety is unclear.

Also run:

```sh
git diff --check
```

## Deliverables

- Scoped ObjectiveFirst collection/publication and focused tests in QuestieTDB.
- Pinned-oracle full-table fixtures or comparison code for every required persona.
- Source, Baked, and stripped-package parity evidence.
- Updated API documentation and type checks.
- Focused and full-gate command results in the handoff.
- A concise note for issue #19 naming the side-channel gate it should invoke.

## Coordination

Issue #15 is likely to edit `src/config.lua` too. Implement #15 and #17 sequentially or coordinate that file explicitly. Seasonal persona utilities may overlap with issues #13 and #14, but this package owns only ObjectiveFirst behavior.
