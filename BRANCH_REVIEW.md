# Native correction migration: branch review

This document records the scope, decisions, alternatives, and validation for
`simplify-correction-execution`. It describes the final combined-file implementation,
not the intermediate Static/Dynamic file split.

The branch starts at `d983a8025eca2e55ca1f61886307745f9db15a2c`. Earlier zone-ID
consolidation was already in that baseline. Field-key consolidation, expansion-order
consolidation, raw-data loader simplification, and structured validator findings were
separate workstreams, not changes to bundle into this branch.

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
- Forever owns its inputs and uses Classic rules where configured. It does not inherit live Era
  providers, and this migration does not switch it to the separate Forever race-mask table.
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

The comparison baseline was the original branch base, not one of the intermediate
implementations. Generation and mutation experiments ran in disposable directories,
not over development Baked artifacts or live data.

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

These SHA-256 values matched both the original baseline and the final combined-layout
candidate. They cover sorted entity directives only, with the exact normalization shown
below. They are migration evidence, not permanent expectations for future data edits.

| Flavor | SHA-256 |
| --- | --- |
| Vanilla | `768f8978dbeda091fae87c2a93abc95d132c7d8fa4c40fc5d92ea29330e99336` |
| TBC | `c2bcbef8943173ab655c822432630e0f8495675c8a95d1645777691640f92fb9` |
| Wrath | `35de1a6b1b1b8efb82dd6116ec7cea1e9d9db5cdf7957abee5a966be10c87c8f` |
| Cata | `945d6fafdd3ba635699dfd600d9da42b3f62dbf3fa603f9d18e675ef48b5993b` |
| Mists | `3a8dc917a494d936297e41f19bed70fbf2c739b88a6b354ec9b7d01ce6cdefa7` |
| Forever | `590d53135b216188874e8b1df718726979d756b91fff6c4b115f71d5ce8f0041` |

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
| `0ca2226` | All 45 correction provider files. Intentionally incomplete by itself so reviewers can inspect the large data-file adaptation separately. |
| `7c64230` | Central loading, manifest, tooling, tests, comments, and documentation. Completes the migration. |
| `ee51ff0` | Pins the legacy-content guard to `7c6423077d8d26b639a1a6269bf35e85feee473b` and records that acceptance. |

The first commit is deliberately not a buildable checkpoint. The final branch is the
validated unit. The new pin accepts the reviewed provider bytes; subsequent legacy Lua
edits still fail. New Forever corrections belong in authored `forever*Fixes.lua` files.

If a rebase changes the migration commit's identity, update the pin to the corresponding
rebased commit before opening or updating the PR. The recorded before/after baseline is
still the original comparison baseline, not silently replaced by the latest `master`.

## Work deliberately left outside this branch

- Static/Dynamic file separation and eventual removal of the stripper.
- Converter registration-expectation deduplication.
- General flavor-inventory and Lua executable-discovery consolidation.
- The separate field-key and expansion-order consolidation PRs.
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
- No PR was opened for this native correction branch during this work. Its commits must be
  pushed before another computer can fetch them. No push was performed as part of this handoff.
- `/tmp` directories in this document do not transfer with Git. They contain detailed local
  proof, not files required by the implementation or normal tests. Preserve them separately
  if the complete original observation logs/scripts are needed on the new machine.

### Next step: integrate current master

At handoff, the locally known `origin/master` is
`434ac22aa03705e4ed9c29c7311efc32da42faeb`. It includes both:

- PR #59, field-key consolidation (`6510062`, merged as `434ac22`).
- PR #60, expansion-order consolidation (`7a6a158`, merged as `fe91e36`).

This branch still starts from `d983a80`; it has not been rebased onto those merges. Fetch
current remote state before proceeding. During rebase:

- Keep this branch's removal of correction compatibility loading. Do not restore
  `compat.lua` merely to resolve its overlap with PR #59.
- Keep PR #59's removal of `enum/fieldKeys.lua` and its file-list entries. Native providers
  already use canonical schema keys. Do not add schema loading to standalone enum consumers.
- Keep PR #60's `config.expansionOrder` ownership rather than restoring duplicate ordering
  tables. Preserve provider-facing aliases used by unrelated support loading.
- Reconcile manifest/TOC composition and tests by behavior, not by choosing one entire side
  of a conflict. Regenerate the Source TOC from the resolved config/generator.
- Preserve the requested reviewable commit split: provider files first, machinery second,
  accepted legacy-content pin afterward. The first commit is intentionally incomplete.
- Update the legacy workflow pin and documentation to the rebased completed-migration commit
  if its hash changes. A normal subsequent documentation commit does not require a new pin.

Do not silently discard either merged cleanup or broaden this branch to unrelated work.

### Review entry points

1. `src/corrections/manifest.lua`: central policy and grouped authoring locations.
2. `src/corrections/Wotlk/wotlkObjectFixes.lua`: representative combined native provider.
3. `src/corrections/register.lua`: native export composition into the existing registry.
4. `src/config.lua` and `generator/runtime.lua`: shared Source/Baked/offline selection.
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
