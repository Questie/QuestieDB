# Historical Forever implementation validation

## Scope of this record

This records the initial pre-rebase validation checkpoint on `forever-toc`, based on
`0529e8d82075316242b0796e2128afb40d300130`. The changes were uncommitted at that time.
The counts and results below apply to that snapshot, not to the current branch or a shipped
release. Its artifacts used the earlier hyphenated Forever/Camelot filenames.

The golden, compiler, import-fidelity, and pinned-checkout checks recorded below have since
been retired by [ADR 0014](adr/0014-owned-data-after-migration.md). They are historical evidence,
not current validation commands or requirements. Use the [current workflow](forever.md#offline-workflow)
and [fixed behavior fixtures](behavior-fixtures.md) for new changes.

Later work added TOC headings, the mixed-token live probe, underscore filenames, upstream
bundled Lua and per-flavor test scheduling, and the completed support-map refresh. The full
six-flavor run below does not validate those later changes. See the maintained
[implementation and client-acceptance guide](forever.md),
[current data workflow](forever-data.md#how-it-works-now), and
[map-refresh validation record](forever-map-override-audit.md#current-disposition-local-map-refresh).

The implementation worktree was `/home/logon/projects/Questie-clones/QuestieDB-forever-toc`.
The copied plan is a handoff document; its references to recovering the old implementation
were superseded by the user's instruction not to use it. No recovery implementation was used.

## Checks completed at the initial checkpoint

Full localized artifacts were generated in a disposable directory, never in an installed addon
or the original checkout. The final Git-backed validation worktree reused those artifacts;
subsequent changes were test scope, documentation, workflow wiring and converter messaging,
not entity data or generation behavior.

| Check | Result |
| --- | --- |
| `lua5.1 generate.lua all` | All six flavors generated; Forever/Camelot bytes identical. |
| Verification, Source/Baked equivalence, reconstruction | All six flavors passed, including equivalence self-proofs. A timed-out orchestration run was completed with a separate Wrath run; the Cata reconstruction log also completed successfully. |
| Additional Forever Horde equivalence | 35,944 entities, 590,128 fields, zero differences. |
| Validators with self-check | Forever and Vanilla: zero findings. Existing TBC/Wrath/Cata/Mists findings remained baselined. |
| Five existing Golden snapshots with self-check | No changes. |
| New Forever Golden with self-check | 35,944 entities; recorded from the Git-backed dirty worktree. |
| Full Lua suite, explicit project-owned Questie pin | **3,340 checks, zero failures.** |
| Real `questiedb.sh check Forever --sequential --budget-mb=2200` | All five applicable gates passed; no compiler oracle scheduled. |
| Full localized `questiedb.sh package all` | Seven ZIPs; manifest checksums and byte counts verified. Exact Forever/Camelot pair in Forever and combined ZIPs. |
| Real pinned schema materialization, Correction re-port and Source TOC regeneration | No byte drift, including owned Forever providers. |
| Vanilla compiler differential | No new regressions; all 20,220 known divergences baselined. |

The new Golden has the same entity IDs as Vanilla. Composed hashes differ for 12 Quests,
741 NPCs and 607 Objects; Items do not differ. Conversion semantic checks separately prove
that adopted source differences are confined to intended coordinates. The Golden is a reviewed
starting record, not an independent Forever game-content oracle.

Focused checks also passed:

- Native TOC parser and real emitted-file selection, handwritten cumulative applicability,
  missing/duplicate initializer failures, shim cleanup, ownership mutation and no-SoD cases.
- All 48 imported DBC Python fixture tests; actual adopted bytes validated across ten files
  and 30 Correction personas; Forever support dataset check and missing-reference self-proof.
- CLI suite: 18 passed, one PowerShell case skipped. Compiler-command rejection suite: seven passed.
- Package and bootstrap suites: 17 tests each. Real generation/stripping/package/bootstrap/read
  integration: one test. Owned-provider importer protection: two tests.
- Version, localization-input and pinned-checkout fixture suites.
- Both workflow YAML files parsed with Bun's existing YAML parser. Checked explicit unit-test
  pin paths, feature-test scheduling, six database flavors and five compiler-oracle flavors.
- `lua5.1 test.lua workflow-contracts`: five checks passed after the final workflow fix.
- `git diff --check` passed.

At that checkpoint, fresh focused reviews covered loading lifecycle, flavor isolation, importer protection,
distribution/bootstrap safety, CLI/workflows and converter/data adoption. Findings were fixed:
legacy fidelity no longer compares owned Forever files with Questie, feature integration tests
are scheduled, baselines are present, converter completion text is current, and workflow unit
tests explicitly use the checkout action's pinned Questie path.

## Historical validation locations

These local temporary paths identify the original runs; they are not durable release artifacts
or required inputs for future validation.

- First full generation and six-flavor gates:
  `/tmp/questiedb-native-validation-c7h9uj89/`.
- Final Git-backed suite, Forever CLI check, full packages and import drift checks:
  `/tmp/questiedb-native-final-MrMCeg/`.
- Final package directory:
  `/tmp/questiedb-native-final-MrMCeg/provider/.out/dist/`.
- Project-owned reference checkout:
  `/tmp/questiedb-native-validation-c7h9uj89/provider/.cache/questie/454b9d072965ee8f1a881429260fcf1fac8d60f7`.

These temporary artifacts are validation outputs from uncommitted snapshots, not published
release candidates. The reviewed Forever Golden and empty validator baseline were copied into
the implementation worktree; generated Baked TOCs were not.

## Limits and safety record at that checkpoint

These statements describe the initial run only. In particular, the later authorized mixed-token
probe and subsequent commits do not change what happened in this earlier validation session.
The narrow probe result and still-outstanding live checks are recorded in [Forever](forever.md#client-support-and-acceptance).

- Native client acceptance was **pending**: Source condition support on supported clients,
  Camelot suffix recognition, Baked precedence and map-landmark placement. Emulator results
  and Blizzard source examples are not client proof. See the implementation guide's checklist.
- Six synthetic coordinates, unconverted dungeon entrances, consumer-supplied coordinates,
  partial map coverage and new Forever content/race policy remain explicit data gaps.
- TBC, Wrath, Cata and Mists compiler differentials were not rerun locally. Their Generation,
  Verification, Equivalence, Reconstruction, validators, Golden and legacy fidelity checks ran.
- PowerShell/native Windows/macOS acceptance and remote GitHub workflow execution were not run.
  `actionlint` was unavailable; YAML parsing and focused workflow checks were used instead.
- An early invocation of the pre-existing ObjectiveFirst test consulted the implicit sibling
  Questie Git revision before rejecting its pin mismatch. No payload comparison ran and no
  external files were changed. The implicit test/importer fallback was removed; subsequent
  fidelity checks used the explicitly fetched project-owned pin above.
- Original checkout status remained `forever` with only the pre-existing untracked plan,
  TOC research document and `hello.txt`. No original checkout files or generated artifacts
  were reset, cleaned, stashed or overwritten. Approved external input directories remained
  read-only. No commits, pushes, publication, live addon installation or client reload occurred.
