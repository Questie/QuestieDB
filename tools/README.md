# Tools

Tools are grouped by purpose, not implementation language. Start with the contributor
command at the repository root: `questiedb.sh` or `questiedb.ps1`. These are the only
launchers; tools below are implementations and tests, not parallel command interfaces.
See [the main README](../README.md#for-contributors).

| Directory | Owns |
| --- | --- |
| `cli/` | Contributor command orchestration and launcher support |
| `distribution/` | Packaging, Static Correction stripping, and release downloads/installations |
| `questie-sync/` | Imports and fidelity checks against the pinned legacy Questie checkout |
| `validation/` | QuestieDB's own behavior checks and shared test-fixture helpers |
| `differential/` | Entity comparisons, migration baselines, and permanent golden snapshots |
| `probe-addon/` | Live-client storage and API probes |

Tests for a tool stay beside its implementation. Python owns temporary directories, process
execution, and integration checks; substantial Lua assertions stay in Lua files. Adjacent
`fixtures/` directories hold the small child programs used by orchestration tests, rather than
hiding those programs inside escaped strings. Tiny interpreter probes can remain inline.

`validation/` holds checks without a corresponding tool here, plus shared test mechanics.
`questie-sync/` makes the remaining upstream dependency explicit; those checks are not all
permanent provider requirements.
