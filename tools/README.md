# Tools

Tools are grouped by purpose, not implementation language. Start with the contributor
command at the repository root; see [the main README](../README.md#for-contributors).

| Directory | Owns |
| --- | --- |
| `cli/` | Contributor command orchestration and launcher support |
| `distribution/` | Packaging, Static Correction stripping, and release downloads/installations |
| `questie-sync/` | Imports and fidelity checks against the pinned legacy Questie checkout |
| `validation/` | QuestieDB's own behavior checks and shared test-fixture helpers |
| `differential/` | Entity comparisons, migration baselines, and permanent golden snapshots |
| `probe-addon/` | Live-client storage and API probes |

Tests for a tool stay beside its implementation. `validation/` holds checks without a
corresponding tool here, plus shared test mechanics. `questie-sync/` makes the remaining
upstream dependency explicit; those checks are not all permanent provider requirements.
