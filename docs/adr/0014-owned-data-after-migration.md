# 14. Owned data after migration

Questie switched to QuestieDB on September 18, 2026. QuestieDB now maintains its own schema,
entity data, Corrections, localization, and support data. Matching the retired compiler is no
longer a correctness requirement. This supersedes the ongoing import, fidelity, and full-data
snapshot requirements in the original design and earlier ADRs, not their runtime contracts.

Compiler comparisons, full-data golden snapshots, import scripts, schema derivation, and the
pinned Questie checkout are removed rather than retained as optional gates. Repeatedly accepting
new hashes or divergence counts would burden legitimate data changes without proving them correct.
Small fixtures with literal expected results protect behavior; whole-database verification,
Source/Baked equivalence, reconstruction, validators, determinism, and package checks remain.
These checks do not establish that every authored gameplay fact is correct.

`src/meta/` is the canonical schema. Generation checks data-file field keys against it. Public
`compilerTypes` metadata remains for API compatibility, not as a dependency on the compiler.
Schema changes must update the owned data keys, correction constants, and LuaLS declarations
where affected. Corrections and translations are edited here, without re-importing Questie.

Build provenance identifies the producing QuestieDB commit. New TOCs omit
`X-QUESTIE-COMMIT`, and release manifests omit `questieCommit`; neither field describes a
current build input. Consumers should use `producerCommit` and artifact checksums.
Historical provenance remains in [`PROVENANCE.md`](../../PROVENANCE.md) and source headers:
the final recorded Questie reference, original source paths and tables, and derivation methods.
Removing the build dependency does not remove the record of where the data came from.

## Migration checkpoint

The annotated `migration-parity-complete` tag selects QuestieDB
`27e1212595060f47de28db3035984bbb3e9ba387`, near Questie's cutover in
[`547d790b6`](https://github.com/Questie/Questie/commit/547d790b64c0c78944e0c27c3301422e9134fc71).
That QuestieDB commit passed [CI](https://github.com/Questie/QuestieDB/actions/runs/35381158013)
and [Release](https://github.com/Questie/QuestieDB/actions/runs/35381158048), including the
migration gates. The tag preserves the tools, baselines, evidence, and completed review/buildout
documents; there is no legacy-tool archive in the active tree. Current findings recovered from
those documents were rechecked against code and transferred to GitHub issues
[#31](https://github.com/Questie/QuestieDB/issues/31) through
[#43](https://github.com/Questie/QuestieDB/issues/43), rather than kept in a parallel review ledger.

To inspect the old evidence without changing the working tree:

```sh
git show migration-parity-complete:docs/questie-handover.md
git show migration-parity-complete:tools/differential/compiler-baseline/Vanilla.tsv
```
