# Tools

Tools are grouped by purpose, not implementation language. Start with the contributor
command at the repository root: `questiedb.sh` or `questiedb.ps1`. Use `generate.sh` (Bash) or
`generate.cmd` (Windows) for Lua-only Generation without Python. Tools below are implementations,
tests, and the bundled interpreters. See [the main README](../README.md#for-contributors).

| Directory | Owns |
| --- | --- |
| `cli/` | Contributor command orchestration and launcher support |
| `lua-binary/` | Prebuilt Windows/Linux x64 Lua 5.1 interpreters, checksums, and notices |
| [`distribution/`](distribution/README.md) | Packaging, changelogs, publishing, Static Correction stripping, and release downloads/installations |
| [`dbc/`](dbc/README.md) | DBC source downloads, map-coordinate comparison, and separate Era-to-Forever source conversion |
| `validation/` | QuestieDB's own behavior checks and shared test-fixture helpers |
| `probe-addon/` | Live-client storage and API probes |

Tests for a tool stay beside its implementation. Python owns process orchestration and the
integration checks that drive Lua as a subprocess; substantial Lua assertions stay in Lua files.
The Lua unit suite stays Python-free: `validation/test-files.lua` covers the few filesystem
operations plain Lua lacks with the platform's own shell commands. Adjacent `fixtures/`
directories hold the small child programs used by orchestration tests, rather than hiding
those programs inside escaped strings. Tiny interpreter probes can remain inline.

`validation/` holds checks without a corresponding tool here, plus shared test mechanics.
The [behavior fixture inventory](../docs/behavior-fixtures.md) maps fixed data-shape examples
to the real Source/Baked reader checks and the existing behavior suites.
Migration tools and full-data snapshots are preserved at the checkpoint described in
[ADR 0014](../docs/adr/0014-owned-data-after-migration.md), not in the active toolchain.
