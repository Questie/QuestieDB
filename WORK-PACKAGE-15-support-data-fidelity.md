# Work package: QuestieTDB issue #15, support-data fidelity

Issue: https://github.com/Questie/QuestieTDB/issues/15

Status: ready for implementation.

## Objective

Make every published support-data module match pinned Questie for the active flavor in both Source and Baked modes. Add a semantic drift gate so future Questie changes cannot silently leave copied support data behind.

## Repositories and reference data

Implement and test this work in:

```text
/home/logon/projects/Questie-clones/Questie-toc/QuestieTDB
```

Compare against the provider's sibling `../Questie` checkout at the revision in `QuestieTDB/QUESTIE_COMMIT`. Do not use this work-package checkout as the oracle. Do not fetch or reset the pinned Questie checkout as part of the task.

Read `QuestieTDB/AGENTS.md`, `DESIGN.md`, and `docs/api.md` before editing.

## Current baseline

Baked flavor TOCs select one support-data variant. The committed Source TOC lists all variants, and later assignments currently win. Source mode can therefore expose the wrong flavor's QuestXP, faction templates, zone maps, or drop tables.

Three shared sources are known to be stale:

- `support/Zones/dungeons.lua`;
- `support/Zones/zoneIds.lua`;
- `support/DropTables/itemDropCorrections.lua`.

Known semantic differences include:

- nine missing Item correction blocks, covering 37 Item/Npc pairs: 5030, 5062, 5086, 10551, 11725, 25767, 25768, 25769, and 31957;
- 44 dungeon records with stale alternative-area values;
- dungeon 2257 named `Deeprun Tramp` rather than `Deeprun Tram`;
- missing `THE_RING_OF_TRIALS = 9999`;
- dungeon alternative area slot values still using the old scalar shape where current Questie expects `alternativeAreaIds` lists.

Current Questie integration still loads its own support files and does not bind `LibQuestieDB.Support`. This prevents the stale dungeon shape from breaking current startup, but it does not make the provider contract correct.

## Scope

1. Synchronize the three known stale shared datasets from pinned Questie.
2. Audit every file named in `config.supportData.shared` and every per-flavor list in `config.supportData.perFlavor`, not just the three known failures.
3. Make Source mode select support data for the active flavor explicitly. Do not rely on cross-flavor file assignment order.
4. Prove complete semantic equality between Source and Baked support modules for Vanilla, TBC, Wrath, Cata, and Mists.
5. Add a semantic drift check tied to `QUESTIE_COMMIT` for every copied support dataset.
6. Add schema-shape checks for nested values, especially dungeon `alternativeAreaIds` lists.
7. Document copied datasets, flavor selection, cumulative loads, and the drift gate.
8. Leave focused evidence that issue #19 can include in its aggregate release gate.

## Non-goals

- Switching Questie consumers to `LibQuestieDB.Support`.
- Removing Questie's local support-data files or wrapper modules.
- Moving wrapper behavior from `zoneDB.lua`, `QuestieXP.lua`, or `dropDB.lua` into QuestieTDB.
- Fixing entity data, localization overrides, or ObjectiveFirst.
- Broad TOC architecture changes beyond correct Source support selection.
- Live-client testing or release publication.

## Implementation anchors

- `src/config.lua`, `config.supportData`, `config.supportFiles`, `sourceFileList`, and `bakedFileList`.
- `src/support/data.lua`: support shim and public module access.
- `src/support/_begin.lua` and `src/support/_end.lua`: load boundary.
- `support/Zones/`, `support/QuestXP/`, `support/FactionTemplates/`, and `support/DropTables/`.
- `test.lua`, suites `toc`, `support`, `generation-inputs`, and `questie-input-integrity`.
- `validators/zones.lua` and the repository validator runner used by `tools/check.sh`.
- Pinned Questie sources under `../Questie/Database/Zones/data`, `Database/QuestXP`, `Database/FactionTemplates`, and `Database/DropTables/data`.

Preserve the deliberate Mists behavior in `config.supportData.perFlavor.Mists`:

- Mists-specific `areaIdToUiMapId` and `uiMapIdToAreaId` maps;
- MoP QuestXP and faction-template data;
- both MoP and Cata drop tables, in the same effective order as Questie.

Compare loaded Lua values, not source bytes. Some current differences are only formatting, while table shape and effective overwrite order are part of the contract.

## Suggested implementation sequence

1. Create an inventory mapping each support file to its pinned Questie source and published module field.
2. Add a semantic oracle loader for the pinned checkout and establish failures for all five flavors.
3. Synchronize the shared data, retaining upstream value shape.
4. Change Source selection so the running flavor determines exactly one applicable variant set.
5. Compare complete published support module tables in Source, Baked, and pinned Questie modes.
6. Regenerate the committed base TOC if its source file list changes and review the TOC diff.
7. Wire the semantic drift check into the normal quality path without duplicating issue #19's aggregate orchestration.

## Required tests and acceptance criteria

Data fidelity:

- All nine missing Item blocks and all 37 Item/Npc pairs match pinned Questie.
- All affected dungeon records match, including list-valued `alternativeAreaIds`.
- Dungeon 2257 has the pinned name.
- `THE_RING_OF_TRIALS` is present with value 9999.
- Every shared and per-flavor support module is semantically equal to pinned Questie.

Flavor selection:

- Vanilla, TBC, Wrath, Cata, and Mists each expose their own QuestXP and faction-template data.
- Mists exposes its own zone maps rather than generic maps.
- Mists retains the intended cumulative Cata plus MoP drop data.
- Source and Baked support values are identical for each flavor.
- Loading one flavor after another in the emulator does not retain support tables from the previous flavor.

Drift and shape controls:

- Adding, removing, changing, or reshaping a copied value in the pinned source makes the drift check fail.
- A scalar in place of a required `alternativeAreaIds` list fails a focused test.
- Formatting-only source differences do not fail semantic equality.

## Validation

Run focused checks from the QuestieTDB root:

```sh
lua5.1 test.lua generation-inputs questie-input-integrity toc support
lua5.1 generate.lua toc --questie=../Questie
git diff -- QuestieTDB.toc
git diff --check
```

`generate.lua toc` rewrites the committed base TOC. Run it only when the Source file-list change is ready for review, and inspect the diff rather than discarding it.

Before completion, run:

```sh
tools/check.sh all --questie=../Questie
```

The full gate is heavy, generates artifacts, and writes under the checkout. Run it only in an isolated QuestieTDB checkout or output arrangement that cannot alter a symlinked daily-driver addon. Get confirmation first if the checkout's safety is unclear.

## Deliverables

- Synchronized support data and explicit Source flavor selection in QuestieTDB.
- Complete five-flavor semantic fidelity tests, including Source/Baked equality.
- A pinned-source drift check and documentation of every copied dataset.
- Reviewed generated TOC changes, if any.
- Focused and full-gate results in the handoff.
- A concise note for issue #19 naming the completed support-data gate.

## Coordination

Issue #17 is likely to edit `src/config.lua` too. Implement #15 and #17 sequentially or coordinate ownership of that file. Neither issue conceptually blocks the other. Do not make this package responsible for changing Questie's current support-data consumption.
