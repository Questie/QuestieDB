# Native correction migration: branch review

This document records the scope, decisions, alternatives, and validation for
`simplify-correction-execution`. It describes the final combined-file implementation,
not the intermediate Static/Dynamic file split.

The branch originally started at `d983a8025eca2e55ca1f61886307745f9db15a2c`, which already
contained zone-ID consolidation. It is now rebased onto master
`0a8472d52f7e4ff5ae9d2de33d4886be6d1d5364`, including PR #59 field-key consolidation,
PR #60 expansion ordering, and PR #62 Forever race-mask selection and validation.
Raw-data loader simplification and structured validator findings remain separate workstreams.
The rebase preserves master's changes rather than restoring the original branch's assumptions.

## Summary

QuestieDB owns its correction sources. It no longer needs to pretend those files are
running inside Questie merely to preserve their imported implementation shape.

We removed that compatibility machinery while preserving the useful concepts and
observable results: Static and Dynamic Corrections, ordering, flavor ownership,
seasonal admission, consumer overrides, and database values.

The final design has three responsibilities:

| Responsibility | Owner |
| --- | --- |
| Correction data and lazy functions | Native provider files under `src/corrections/` |
| File selection and registration policy | `src/corrections/manifest.lua` |
| Applying corrections and composing consumer layers | The existing Correction registry |

Provider filenames remain familiar. Static and Dynamic functions stay together.
Packaging still strips Static definitions from mixed files before distribution.

## Why we changed it

The imported authoring format made sense while staying close to Questie's sources was
an ongoing requirement. It left us with fake `QuestieLoader` modules, temporary global
replacement, direct-write capture, and wrappers around correction functions.

Those mechanisms were accommodations for another project's implementation, not
requirements of QuestieDB's domain. Keeping them would make future contributors learn
an environment that QuestieDB only simulates.

The guiding distinction became:

- Preserve correction semantics and consumer contracts.
- Replace imported internal structure when doing so makes ownership and authoring clearer.
- Do not use an internal refactor to change gameplay facts or correction precedence.

This is not a rejection of Questie as a consumer. It removes an unnecessary internal
dependency on Questie's module conventions.

## What stayed the same

- Static Corrections apply during Generation and Source materialization, before Derived Passes.
- Dynamic Corrections apply through the existing owner-scoped registry and Correction Overlay.
- Consumer registration APIs, owner precedence, and override behavior remain unchanged.
- Registration identities, sequence, application order, filters, and merge options are preserved.
- Seasonal providers and ObjectiveFirst hints remain restricted to applicable flavors and seasons.
- Forever owns its inputs and does not inherit live Era providers. Its race masks retain
  PR #62's values. The explicit ownership follow-up gives it complete independent race,
  class and NPC-flag tables, with class/NPC values initially matching the previous Classic
  values. Classic supplies ordering only, never enum aliases or fallback.
- Correction tables remain lazy. Loading a provider defines functions rather than materializing
  its large data tables.
- The public schema and support value shapes are unchanged. No contract-version or LuaLS public
  signature change was needed.
- Historical import and conversion provenance remains historical evidence, not rewritten approval
  for new source bytes.

## Before and after

### Before

```text
Copied provider imports Questie-shaped modules
    -> compatibility layer supplies modules and constants
    -> provider returns rows and may write to fake database tables
    -> invocation shim temporarily supplies the Questie global
    -> wrapper merges captured writes with returned rows
    -> manifest dispatcher registers the wrapped function
    -> registry applies it
```

### After

```text
Central manifest selects native provider files
    -> native preparation selects shared invariants or the actual flavor's declared tables
    -> providers export ordinary lazy functions through the addon namespace
    -> central registrar validates and registers those functions directly
    -> existing registry applies the declared policy
```

Providers use `LibQuestieDB.Meta.<Entity>.keys` and the existing enums directly. There is
no replacement `QuestieDBLoader`, fake import graph, or second application registry.
The native export table is simply how addon files share functions.

## Changes in detail

### Provider execution

All 45 provider files use native exports. Their 78 function declarations are listed in
the central manifest. The inventory contains 27 mixed files, five pure-Static files,
and 13 pure-Dynamic files, including `Sod/sodRequiredRaces.lua`.

Removed:

- Correction-specific `QuestieLoader` installation and restoration.
- `src/corrections/compat.lua` and its fake imported modules.
- `compat.Invoke` and temporary replacement of the global `Questie`.
- Direct-write capture buffers and the merge/copy wrapper around returned corrections.
- Unused reversed field-key maps.
- Correction begin/end shim markers and seasonal discard-scope files.
- Identity localization wrappers; the same English text remains in correction values.

The remaining seven direct writes were empty Item rows in the Wrath provider. Each ID
already appeared in its returned corrections. Removing those redundant writes allowed
capture machinery to disappear without losing entity creation.

Icon references now use the owned icon enum instead of requiring a temporary Questie
global. Native field-key access uses the canonical schema rather than imported module
stand-ins. Familiar function names remain where they help authors navigate the existing
files; they no longer imply Questie module methods or receiver binding.

### Central policy

`manifest.lua` owns each file's applicability and each function's registration identity,
category, ordering, and merge metadata. `register.lua` now composes native exports rather
than dispatching fake module methods or wrapping provider calls.

There are two relevant orders:

1. Manifest file/function sequence determines registration sequence and tie breaking.
2. The declared load-order window plus offset determines application order within an owner.

File-level applicability controls whether a provider chunk loads. Function-level
metadata controls registry applicability and Static inheritance behavior. These are
related but not interchangeable. Keeping both explicit preserves existing behavior.

For example, WotLK NPC `LoadAutomatics` stays at `WotlkStatic + 11`, followed by `Load`
at `+ 12`. A focused test reverses the central declarations and observes the real change
in NPC 30208's overlapping spawn corrections. The test demonstrates policy ownership,
not merely that the manifest contains the expected strings.

Applicable missing functions, duplicate exports, and unlisted exports fail clearly.
Era and inherited Forever providers may share an export key only because their file
selection is mutually exclusive. Cumulative expansion providers use distinct keys.

### Flavor constants after rebasing

Master's PR #62 corrected an important assumption: `flavor.rules = "Classic"` does not mean
Forever must use Classic races. The old compatibility layer contained this new selection
behavior, so deleting that layer during rebase required retaining the policy in native loading.
The rebase temporarily kept absent-table fallback to match master before the separately
approved ownership follow-up. This paragraph records that checkpoint, not final policy.

At that checkpoint, `src/corrections/prepare.lua` resolved tables before providers executed:

1. Shared `Enum[name]` wins when present.
2. Otherwise, the configured flavor's enum set must exist.
3. Its named table wins if defined, including an explicitly empty table.
4. Only an absent table falls back to `flavor.rules`.

Preparation published original references through `Enum.corrections` after all required tables
resolved. It did not copy tables or fill missing individual keys. Forever therefore received
`SKYBORNE_ALLIANCE`, `SKYBORNE_HORDE`, and its larger faction masks without inheriting absent
race keys such as `BLOOD_ELF`. Class and NPC flag tables still fell back to Classic. A missing
Forever enum set failed during loading, before provider exports or hint writes.

This is a native preparation phase, not a restored module loader. Standalone enum and support
loading remain independent of it. Required-races inference and validation retain master's
separate use of the actual flavor's race constants. The
[final ownership follow-up](#final-forever-enum-ownership-follow-up) removes the temporary
class/NPC fallback without changing produced values.

### Hints and seasonal selection

The five public ObjectiveFirst tables now have a native initializer. They remain
load-time consumer hints, not entity corrections.

Seasonal provider files consult the central policy before publishing functions or
writing hints. The registrar uses the same policy. This avoids requiring inactive
seasonal exports and prevents hints from leaking onto ordinary or wrong-flavor clients.

### Source, Baked, and offline loading

Source mode and Generation load and register both categories. Baked mode selects files
with Dynamic declarations and registers only those functions.

Both Baked development cases work:

- An unstripped worktree may contain Static functions, but Baked mode does not register
  or invoke them.
- A packaged mixed file may omit Static functions entirely. Its required Dynamic
  functions must still exist.

Offline loading uses an explicit flavor and the same providers and registration policy.
A failed load or registration can leave a partial namespace. The documented recovery is
to discard it and call `runtime.build()` again. We did not add transactional rollback
machinery for an internal construction operation. Tests exercise failures after work
has already begun and verify fresh-namespace recovery.

### Packaging

`tools/distribution/strip-static.lua` remains, adapted to native exports and the central
function declarations:

- Pure-Static files are omitted from Baked file lists.
- Static function definitions are removed from staged mixed files, without callable stubs.
- Pure-Dynamic provider files remain byte-identical to their source.
- Dynamic code, shared helpers, and ObjectiveFirst hints are preserved.
- Repository source files are never rewritten by packaging.

Stripping validates transformations before writing staged files. It checks compilation
and compares actual native Dynamic behavior, registration metadata, and hints across
applicable flavors and character branches.

This intentionally retains a formatting constraint: exported function declarations and
their closing `end` must start at column zero, with nested blocks indented. Unsupported
formatting or changed behavior fails packaging. A negative test makes Dynamic code depend
on a Static function only for a Mists Horde Mage Orc; the stripping check must catch it.

### DBC conversion and validation

The converter still has ten explicit inputs: four raw databases and six inherited
correction files. Original source/destination filenames are retained.

Two lists serve different purposes:

| List | Purpose |
| --- | --- |
| `src/corrections/manifest.lua` | Normal runtime/Generation correction selection and execution policy |
| `tools/dbc/convert.py` `INPUTS` | Explicit Era-to-Forever migration source/destination pairs |

Adding a runtime provider does not automatically authorize converting or overwriting a
Forever file. That separation remains intentional.

Conversion validation now loads native exports and composes them with actual source and
target manifest policy. It checks complete inventories, categories, metadata, hints,
and returned values, including coordinate-only changes. It no longer reconstructs fake
Questie modules or rewrites registration footers.

After PR #62, both compared provider bodies are evaluated with the destination's Forever
constants. Their separate source/target manifest policies are still checked. This distinguishes
coordinate rewriting from an intentional change in symbolic race masks; a destination body
that incorrectly hardcodes the Classic mask still fails validation.

Registration names and categories are still repeated in the converter as validation
expectations. Consolidating that overlap is a possible follow-up, not required to
complete this migration. The source/destination mapping itself is separate information.

Historical manifests and hashes were not refreshed. Native provider bytes differ from
the historical converted bytes, so the installer continues treating them as hand edits
that must not be silently overwritten. No installing conversion or DBC download was run.

## Approaches we considered and changed

| Approach | Decision and reason |
| --- | --- |
| Remove only capture and global-icon shims | Expanded the scope. It left an awkward mixture of native access and simulated Questie modules. |
| Register each function directly from its provider file | Reversed. It scattered policy and placed important settings below thousands of data lines. Central ownership is easier to review and maintain. |
| Move per-file registration settings to provider headers | Not the final solution. Visibility would improve, but ordering would still be distributed across files rather than visible centrally. |
| Split all mixed providers into `.static.lua` and `.dynamic.lua` files | Implemented during exploration, then reversed. Keeping original filenames and functions together reduces disruption for teammates. |
| Remove package source stripping | Reversed along with the split. We still want Static bodies absent from Baked packages, so stripping remains for mixed files. |
| Replace `QuestieLoader` with a new generic loader framework | Rejected. Plain addon namespace exports and a small central registrar are enough. |
| Preserve every old helper for compatibility | Rejected for unused internal machinery. Real consumer interfaces and data semantics are preserved instead. |
| Make failed namespace construction transactional | Not added. Discard-and-rebuild is the simpler supported recovery contract. |
| Require full-data golden refreshes for future edits | Not introduced. This is one-time migration evidence, not a permanent authoring gate. |

Static/Dynamic file separation remains a future improvement. It could eventually remove
format-sensitive stripping, but that cleanup should be an explicit team-facing change,
not an incidental consequence of replacing the internal module format.

## Readability and contributor workflow

The final comment pass covered 76 files, including every provider. It added:

- Expansion and ownership headings in the central manifest.
- Separate chunks for raw inputs, inherited providers, and shared inputs in conversion lists.
- Processing-phase comments around loading, validation, stripping, staging, and publication.
- Provider orientation, function annotations, and Static/Dynamic responsibility landmarks.
- Clear directions for adding a file and choosing its location in the manifest.

Comments explain policy and change locations rather than narrating each assignment.
Body-specific Static instructions live inside their functions so stripping removes them
instead of leaving misleading instructions above Dynamic code.

For authors:

1. Edit provider functions for data changes.
2. Edit the central manifest for registration policy changes.
3. When adding a provider, export its functions near the file header and add its block in
   the appropriate manifest section. Declare every exported function.
4. Regenerate the Source TOC when files are added, removed, moved, reordered, or their
   file-level applicability changes.
5. Run shared checks and Generation/validation for the affected flavors.

See [the native correction guide](docs/native-corrections.md) for examples and commands.
The comment-only pass was checked independently: all 68 affected Lua executable token
streams and six Python executable ASTs remained unchanged, excluding Python docstrings.

## Proof that the results stayed the same

The initial comparison used the original branch base, not an intermediate implementation.
After rebase, a fresh comparison used fetched master `0a8472d`, including its intentional
Forever mask changes. The rebased implementation matches that target, not the older Forever
results. Generation and mutation experiments ran in disposable directories, not over
development Baked artifacts or live data.

### Provider behavior

The unchanged baseline observer and serializer compared:

- 18 scenarios and 362 character/season personas.
- 9,056 provider invocations.
- Complete returned rows and fields, not sampled values or counts alone.
- Stable identities, selection order, registration sequence, load order, options, and filters.
- ObjectiveFirst hints before and after provider invocation.

All observations matched exactly. The matrix includes both factions, all eleven class
tokens, Human/non-Human race branch representatives, ordinary realms, active SoD/Titan,
and inappropriate flavor/season combinations. Synthetic class/race combinations exercise
branches; they are not a claim about legal character creation.

### Generated entity data

All six flavors matched across 1,235,624 entity metadata directives. Both normalized
bytes and their original directive order matched. All 24 per-entity-type hashes matched.

Generation used `--no-l10n --no-base-toc`. The comparison covers entity ID headers,
Scalar rows, table fields, and chunks. Build/version metadata and changed runtime file
lists are not entity equality requirements. Full Localization Generation was excluded.

### Portable entity checksums

These SHA-256 values match fetched master `0a8472d` and the rebased combined-layout candidate.
They cover sorted entity directives only, with the exact normalization shown below. They
are migration evidence, not permanent expectations for future data edits. The five legacy
flavors are also unchanged from the original `d983a80` comparison; Forever intentionally differs.

| Flavor | SHA-256 |
| --- | --- |
| Vanilla | `768f8978dbeda091fae87c2a93abc95d132c7d8fa4c40fc5d92ea29330e99336` |
| TBC | `c2bcbef8943173ab655c822432630e0f8495675c8a95d1645777691640f92fb9` |
| Wrath | `35de1a6b1b1b8efb82dd6116ec7cea1e9d9db5cdf7957abee5a966be10c87c8f` |
| Cata | `945d6fafdd3ba635699dfd600d9da42b3f62dbf3fa603f9d18e675ef48b5993b` |
| Mists | `3a8dc917a494d936297e41f19bed70fbf2c739b88a6b354ec9b7d01ce6cdefa7` |
| Forever | `24365086d899599251ffd59a1493b410651c1ad5ad00a79d95fb770971625d1e` |

To reproduce the entity comparison, run from a disposable checkout of the recorded source,
not a daily-driver addon directory. These commands write Baked TOCs into that checkout:

```sh
for flavor in Vanilla TBC Wrath Cata Mists Forever; do
  lua5.1 generate.lua "$flavor" --no-l10n --no-base-toc || exit 1
  printf '%s: ' "$flavor"
  LC_ALL=C grep -aE '^## X-(Quest|Npc|Item|Object)-' "QuestieDB_${flavor}.toc" |
    LC_ALL=C sort | sha256sum
done
```

Later legitimate data edits can change these hashes. Investigate and attribute a mismatch;
do not alter data merely to reproduce a historical hash. The full provider-matrix observer
and its snapshots remain session-local artifacts, unlike this recorded checksum summary.

### Mutation controls

A fresh mutation in the final combined Era provider changed Quest 117's name from
`Thunderbrew` to `Thunderbrew SELF-PROOF`.

The provider comparison detected exactly `[117][1]`; generated Vanilla data differed at
exactly `X-Quest-117-S`. Provider identities and counts remained unchanged. Restoring the
source returned both comparisons to exact baseline bytes. This demonstrates that equal
counts alone cannot make the proof pass.

The separate central-order test detects the NPC 30208 change described above. Packaging
negative controls detect malformed definitions and Dynamic dependencies on removed
Static code.

### Runtime, tooling, and packaging checks

Final validation included:

- 2,456 shared Lua checks, rerun before the implementation commit.
- 38 packaging tests.
- 77 packaged-addon hint checks and 39 central-authoring checks.
- 21 DBC conversion tests, alongside the other DBC fixture suites.
- Ten temporary converted candidates: 140,660 coordinate pairs and 440 provider invocations,
  validated using recorded coefficients without opening a DBC database.
- Real extracted Vanilla and Forever packages. Static exports were absent, pure-Dynamic
  files and hints survived, and both Forever/Camelot TOCs loaded.
- Focused independent reviews of lifecycle, central policy, DBC overwrite protection,
  packaging, tests, and comment accuracy.

The final combined-layout evidence is at
`/tmp/qdb-validator-final-combined.eQnMZw/evidence`; the original baseline and comparison
scripts are at `/tmp/questiedb-native-corrections-proof.9AOqlG`. These are session-local
review artifacts, not committed dependencies or guaranteed permanent storage. The branch
documents their scope and results; future CI does not require those directories.

### Fresh rebase validation

The new-master reference is `/tmp/qdb-rebase-master-proof.FPHLqC`. Independent native
validation is `/tmp/qdb-validator-rebased.djK46O/README.md`. These preserve complete snapshots,
source manifests, commands, checksums, and comparison results for the rebase.

- All six datasets and all 1,235,624 directives match master `0a8472d` exactly, including order.
- All 362 personas and 9,056 provider invocations match outputs, metadata, options, sequence,
  applicability and hints.
- Master intentionally changes 137 generated Forever Quest `requiredRaces` values versus
  `d983a80`: 136 come from provider output, and quest 7162 comes from the Derived Pass.
  The transitions are `77 -> 4294967373` and `178 -> 8589934770`. No other entity fields differ.
- A fresh mutation reverted one Forever provider binding to Classic race constants. Comparison
  detected exactly 136 incorrect provider/generated masks. Quest 7162 stayed correct because
  its mask comes from the unchanged Derived Pass. Restoring the binding returned both
  comparisons to exact target-master bytes.
- Source, Baked and extracted Forever/Camelot reads returned `4294967373` for quests 1581 and
  7162. Class and NPC-flag tables retained their Classic fallback identities.
- Validation passed 3,294 shared checks, 503 targeted runtime/Baked/persona checks, 38 packaging
  tests, 21 converter tests, and the real Forever distribution fixture. Direct and extracted
  public-read checks each passed 38 assertions. Six-flavor area lookup and race validation
  also passed.
- Fresh review found no integration defects. The raw loader, Source reader and raw entity data
  remain byte-identical to fetched master; the raw-data-loading work was not included.

The earlier counts and Quest 117 mutation above describe the original migration validation.
They are retained as history, not substituted for this new-master proof.

### Final Forever enum ownership follow-up

After validating the master-compatible rebase, the approved follow-up makes Forever's enum
ownership explicit. `Forever` now declares complete literal `raceKeys`, `classKeys` and
`npcFlags` tables. Class/NPC values initially match the previously selected Classic values;
races, Skyborne names and masks are unchanged. Static duplication is intentional so future
flavor edits are independent. It is not a claim of live DBC validation.

Preparation retains shared invariant precedence, otherwise requiring the actual flavor's
declared table. Missing sets or tables fail before publication, provider exports, registration
or hints. Defined empty tables remain empty; there are no aliases, fallback to another flavor,
or key merges. `flavor.rules` selects ordering only. Table identities intentionally change;
produced values do not. The prior fallback identity evidence above remains historical.

Fresh follow-up evidence is in `/tmp/qdb-forever-enum-ownership.Gvz9O5`:

- Focused `correction-enums corrections derived-required-races native-toc support toc` suites:
  2,082 checks passed. Full `--shared`: 3,768 checks passed.
- Tests mutate Classic class/NPC values without changing Forever's literal `1503`/`16384`;
  all three missing-table cases fail even with Classic tables present. Restoring the old
  fallback in a disposable copy fails all three rejection tests. Aliasing class/NPC tables
  back to Classic fails four ownership/mutation checks.
- All six no-localization generations before and after match across 1,235,624 directives,
  including original order, and match every portable checksum above. Forever remains
  `24365086d899599251ffd59a1493b410651c1ad5ad00a79d95fb770971625d1e`.
- Complete selected-enum values match before/after for all six flavors. Source and Generation
  tests retain masks for quests 1581 and 7162; both generated Forever/Camelot TOCs also return
  `4294967373` and select independent Forever table identities.
- Lua syntax and `git diff --check` pass. Legacy provider bytes and the CI pin are unchanged.

The historical matrix scripts are absent on this machine, so independent validation built a
fresh observer rather than claiming to rerun that exact harness. Its evidence is at
`/tmp/qdb-fresh-provider-validator.cMZzFx`. The observer uses the real native runtime and registry,
with the before-state serializer, and compares this follow-up against commit `0f0f1fa`:

- All 18 scenarios, 362 personas and 9,056 invocations match: 4,494 Static and 4,562 Dynamic.
- Complete returns, registry metadata except executable function identity, and hints before
  and after invocation are byte-identical. Nil/empty values, sparse fields, options, filters,
  ordering and sequence are retained.
- Matching output SHA-256: `b7dec722b0e0ece3afae932e7ab66ae3bca207049c34f214937554c53c578036`.
- Matching metadata SHA-256: `98bf2cbe5044ded62b612a46cf5cd99ebc423a6a19affd042d8d18423cf2ee98`.
- Matching hints SHA-256: `464a589082e60421c32444ab8f84447c9756c192088c7e940155a7ba379dfc60`.
- Independent targeted checks passed 2,082 Lua assertions, 21 converter tests and 38 packaging
  tests. Fresh focused review found no issues.

This is a new before/after observation, not a reconstruction of unavailable historical logs.
All fresh Generation and mutation checks used disposable copies; no root Baked TOCs or live
data were touched.

### Limits

This work did not repeat full localized Generation or live-client validation. It did not
exercise every race token or compose every persona through every public getter. The
provider matrix and generated-data comparison are complemented by focused runtime tests,
not presented as exhaustive live-game coverage.

Two optional DBC snapshot acceptance tests were skipped because no external database was
provided. No release, preview publication, network DBC download, or production data change
was performed.

## CI and commit organization

The existing legacy-content guard compared Forever's inherited Lua files against an older
accepted commit. Native source changes necessarily changed those bytes, even after we
restored the filenames. We kept the guard and explicitly advanced its pin to the completed
migration rather than disabling it or bypassing its path coverage.

| Commit | Scope |
| --- | --- |
| `b05ab74` | All 45 correction provider files. Intentionally incomplete by itself so reviewers can inspect the large data-file adaptation separately. |
| `2fc6d1c` | Central loading, manifest, tooling, tests, comments, and documentation, including master-compatible flavor constant selection. Completes the migration. |
| `628066f` | Pins the legacy-content guard to `2fc6d1c9e45f90d55d94f6ce37c310fae7a4282a` and records that acceptance. |

The first commit is deliberately not a buildable checkpoint. The final branch is the
validated unit. The new pin accepts the reviewed provider bytes; subsequent legacy Lua
edits still fail. New Forever corrections belong in authored `forever*Fixes.lua` files.

If a rebase changes the migration commit's identity, update the pin to the corresponding
rebased commit before opening or updating the PR. Historical comparisons retain their original
baseline; the separate fresh rebase comparison explicitly targets master `0a8472d`.

## Work deliberately left outside this branch

- Static/Dynamic file separation and eventual removal of the stripper.
- Converter registration-expectation deduplication.
- General flavor-inventory and Lua executable-discovery consolidation.
- Further field-key or expansion-order redesign. The already-merged PRs #59 and #60 are
  preserved by the rebase, not reimplemented or rolled back.
- Raw entity loader environment simplification.
- Structured validator findings in place of print parsing.
- Unrelated support, localization, or Derived Pass loader rewrites.
- Changing active race inference, waypoint behavior, coordinates, or other gameplay facts.
- Removing public `compilerTypes` or changing deferred support strings that consumers use.
- Rewriting historical conversion provenance or authorizing automatic Era-to-Forever syncing.

The branch is intentionally a correction-authoring and execution migration. It does not
need to solve every remaining migration-era duplication to be useful or reviewable.

## Handoff for the next computer or session

### State at handoff

- Repository: `Questie/QuestieDB`.
- Branch: `simplify-correction-execution`.
- The three implementation commits listed above are complete. This document is an additional
  documentation commit, not another implementation step.
- The original machine's worktree was
  `/home/david/private/QDB-New.worktrees/correction-execution`. That absolute path is not a
  build dependency; use the new checkout's root.
- The branch tracks `origin/simplify-correction-execution`. David pushed the rebased history
  through `dff8960`; subsequent documentation and enum-ownership follow-ups can be normal
  commits. No further force-push is needed unless history is rewritten again.
- `/tmp` directories in this document do not transfer with Git. They contain detailed local
  proof, not files required by the implementation or normal tests. Preserve them separately
  if the complete original observation logs/scripts are needed on the new machine.

### Rebase complete

The fetched master used for this rebase is `0a8472d52f7e4ff5ae9d2de33d4886be6d1d5364`:

- PR #59, field-key consolidation (`6510062`, merged as `434ac22`).
- PR #60, expansion-order consolidation (`7a6a158`, merged as `fe91e36`).
- PR #62, Forever enum selection, race-key names and validation (`cf56da5`, `af6a824`,
  `bd64bc5`, merged as `0a8472d`).

All are integrated and validated. The branch retains the native compatibility-layer deletion,
canonical schema keys, config-owned ordering and support aliases. PR #62's flavor-first
constant selection has a native home in `prepare.lua`, and its inference/validator changes
are preserved. Conflict resolution did not choose either side wholesale.

The local backup `backup/simplify-correction-execution-pre-rebase-91b1011` preserves the old
branch tip. It is a local recovery reference, not a build input or a guaranteed remote branch.
The provider-first commit split remains intentional. The CI pin now references the rebased
completed-migration commit. A later documentation-only commit does not require another pin.

David has pushed the rebased history. Commit and push the explicit Forever enum-ownership
follow-up, open the PR, and run normal CI before merging. If master advances again, fetch and
assess that delta separately. Do not silently discard merged behavior or broaden the branch.

### Review entry points

1. `src/corrections/manifest.lua`: central policy and grouped authoring locations.
2. `src/corrections/Wotlk/wotlkObjectFixes.lua`: representative combined native provider.
3. `src/corrections/register.lua`: native export composition into the existing registry.
4. `src/config.lua`, `src/corrections/prepare.lua`, and `generator/runtime.lua`: shared
   Source/Baked/offline selection and flavor-owned constant preparation.
5. `tools/distribution/strip-static.lua`: intentionally retained package-only rewriting.
6. `tools/dbc/convert.py` and `tools/dbc/validate.lua`: opt-in migration mapping and validation.
7. `tools/validation/correction-authoring.test.lua`: central ordering and error controls.

### Validation after integration

Run the focused gates from the new checkout:

```sh
lua5.1 generate.lua toc
lua5.1 test.lua --shared
uv run --no-project python tools/dbc/convert.test.py
uv run --no-project python tools/distribution/package.test.py
uv run --no-project python tools/distribution/forever.test.py
git diff --check
```

These fixture suites do not authorize running an installing DBC conversion. Perform any
full artifact comparison in a disposable checkout, using the checksum scope above. Then
run the normal CI/artifact checks before merging. Full localized Generation and live-client
acceptance remain unperformed in the original validation record, not implicitly completed
by these commands.

The agreed final direction is settled: native providers, central policy, familiar combined
files, and package stripping. Reintroducing fake Questie modules, distributing policy back
into provider footers, or splitting files again would be a new design decision, not unfinished
work from this branch.
