# Work package: QuestieDB issue #13, SoD `requiredRaces`

Issue: https://github.com/Questie/QuestieDB/issues/13

Status: ready for implementation after a focused data audit.

## Objective

Make `Quest.requiredRaces` on an active Season of Discovery persona match Questie's final composed database in both Source and Baked modes. Keep plain Vanilla behavior unchanged.

## Repositories and reference data

Implement and test this work in:

```text
/home/logon/projects/Questie-clones/Questie-toc/QuestieTDB
```

Use QuestieDB's sibling `../Questie` checkout as the reference implementation. Its revision must match `QuestieDB/QUESTIE_COMMIT`. Do not use this work-package checkout as the data oracle because its old database and compiler have already been removed.

Read `QuestieDB/AGENTS.md`, `DESIGN.md`, and the relevant ADRs before editing. Do not fetch, reset, or otherwise change the pinned Questie checkout as part of this work.

## Current baseline

`src/derived/requiredRaces.lua` reproduces Questie's inference after Static Corrections for the five base flavors. The base-flavor compiler differential reports no remaining `Quest.requiredRaces` differences.

SoD is different. Its Quest and Npc changes are Dynamic Corrections over Vanilla and are composed after the static Derived Pass. The existing pass therefore cannot see:

- quests introduced by SoD;
- SoD changes to `Quest.startedBy`;
- SoD changes to `Npc.friendlyToFaction`.

The task is not to replace the working base-flavor pass or complete issue #1's explicit materialization cleanup.

## Scope

1. Repair or add the focused SoD oracle needed to compare Questie's final composed Quest and Npc data with QuestieDB under an active SoD persona.
2. Audit every active SoD quest whose final `requiredRaces` is absent or zero using Questie's exact current rule:
   - inspect creature starters in `startedBy[1]` only;
   - read their final corrected `Npc.friendlyToFaction` values;
   - preserve Questie's handling of missing NPCs, unknown faction values, mixed starters, and explicit zero.
3. Record the complete mismatch set before choosing the representation.
4. Prefer explicit symbolic SoD corrections when the mismatch set is small and stable. If evidence requires post-composition derivation, keep it bounded to SoD and preserve correction application, withdrawal, cache invalidation, and Source/Baked behavior.
5. Add focused automated tests proving the resulting values and the seasonal boundary.
6. Leave reusable focused evidence that issue #19 can add to the aggregate release gate.

## Non-goals

- Replacing the base-flavor Derived Pass with explicit corrections. That remains issue #1.
- Building the broad side-channel and release matrix owned by issue #19.
- Changing Questie's inference policy to a cleaner or more conservative rule.
- Refactoring the correction registry unless the measured mismatch set proves it necessary.
- Editing the current Questie consumer checkout.
- Live-client testing, packaging policy, or release publication.

## Implementation anchors

- `src/derived/requiredRaces.lua`: working base-flavor transcription and documented SoD limitation.
- `src/derived/_end.lua`: Derived Pass registration.
- `src/corrections/register.lua`: `IsSod`, `IsSodActive`, and seasonal registration.
- `src/corrections/registry.lua`: dynamic composition, cache invalidation, and withdrawal semantics.
- `src/corrections/Sod/`: copied SoD correction inputs.
- `tools/differential/compiler_diff.py`: comparison driver; accepts `--season=SoD`.
- `tools/differential/dump_compiler.lua`: Questie oracle persona and final-data dump.
- `test.lua`, suites `derived-required-races`, `corrections`, `overlay`, `personas`, and `correction-fidelity`.

The files under `src/corrections/` are fidelity-checked copies of Questie correction sources. Do not hand-edit a copied SoD file and silently break that ownership rule. If explicit rows belong in an upstream correction, change the canonical source through the agreed data-sync path and port it. If the result is provider-owned derived data, keep it outside the byte-identical copies and document why.

Use symbolic race masks from the active expansion enums. Do not embed numeric masks.

## Suggested implementation sequence

1. Make the SoD differential persona run Questie's same initialization and correction path. First prove the oracle can detect a deliberate mismatch.
2. Dump and review the final composed Quest and Npc inputs used by the inference on both sides.
3. Produce a reviewable list of affected quest IDs, inferred masks, starter IDs, and starter faction evidence.
4. Choose explicit corrections or a post-composition pass from the measured size and volatility of that list. Document the choice near the code.
5. Implement the smallest solution and add focused Source and Baked tests.
6. Prove the inactive-season and withdrawal cases before running broad validation.

## Required tests and acceptance criteria

Positive coverage:

- Active SoD returns Questie's inferred `ALL_ALLIANCE` or `ALL_HORDE` value for every audited mismatch.
- The rule sees SoD-added quests, corrected `startedBy` values, and corrected NPC faction values.
- Source and Baked mode return the same final `requiredRaces` values for active SoD.

Negative and lifecycle coverage:

- Plain Vanilla receives none of the SoD-only values.
- Other base flavors and unsupported season IDs receive none of the SoD-only behavior.
- Existing nonzero `requiredRaces` values stay unchanged unless the pinned Questie oracle changes them.
- Mixed or non-exclusive starter evidence does not create a faction restriction.
- If the design adds runtime-derived state, disabling or withdrawing the SoD owner removes stale values and invalidates affected caches.

Completion requires a zero unaccepted `Quest.requiredRaces` difference for the active SoD persona. Do not hide differences by updating a baseline.

## Validation

Run focused checks from the QuestieDB root:

```sh
lua5.1 test.lua derived-required-races corrections overlay personas correction-fidelity
uv run tools/differential/compiler_diff.py Vanilla --season=SoD --questie=../Questie
uv run tools/differential/compiler_diff.py Vanilla --season=SoD --questie=../Questie --self-check
```

The SoD differential may fail before implementation because repairing that persona is part of this package. The self-check must pass before treating a green comparison as evidence.

Before completion, run the repository's full gate against the pinned oracle:

```sh
tools/check.sh all --questie=../Questie
```

`tools/check.sh all` is heavy, generates artifacts, and writes under the checkout. Run it only in an isolated QuestieDB checkout or output arrangement that cannot alter a symlinked daily-driver addon. Get confirmation first if the checkout's safety is unclear.

Also run:

```sh
git diff --check
```

## Deliverables

- The implementation and focused tests in QuestieDB.
- A complete pre-fix mismatch inventory and the final zero-difference result.
- A short note explaining the chosen representation and correction ownership.
- Focused test and full-gate command results in the handoff.
- Any remaining limitation moved to issue #19 rather than expanding this package.

## Coordination

This package can share seasonal test-persona mechanics with issues #14 and #17, but it owns only `requiredRaces`. Coordinate any edits to common persona or differential code. Issue #19 may consume the completed check; it is not a prerequisite for this fix.
