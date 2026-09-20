# Forever support candidate validation

This records the uncommitted candidate implementation based on local branch `forever`,
provider HEAD `f1567bd384ff4c0d4dba2f3c8cc5a8756d05b4da`. It is not a release or client
acceptance record. The branch already contains the completed handoff, 40 compatibility pairs
and the two reviewed parent fixes; none was recreated or installed by this work.

## Generated files

Under `.out/forever-support/review/` (Git-ignored review artifacts):

| File | SHA-256 |
| --- | --- |
| `Zones/areaIdToUiMapId.lua` | `307ab49249768ab9697681ad6bad600f3f23ac48eedfca2de886d1f51c3b3c04` |
| `Zones/uiMapIdToAreaId.lua` | `b14541f5cffca81d10eb6f50e946143c875c3cfaae26e7caf76e19424bf826f5` |
| `report.json` | `76fafa4e1ff0a094e3b74e8a11bf4383e13aefc8746080627d180df99055c1af` |

Generation through the normal contributor launcher succeeded. Two subsequent identical runs
reported zero changed files. Actual installed candidate hashes match the report. Actual Lua
loading compared all four candidate base/override tables with owned support, with exact equality.

The separate protected-handoff comparison used disposable candidate bytes without the 40
consumer compatibility pairs. It matched all four handoff tables, all 1,064 route/ancestor
annotations and the exact unresolved inventories. The deliverable files retain all 40 pairs.
The protected handoff/report hashes match recorded provenance and their recovery copies.

## Checks actually run

From `QuestieDB/`, with temporary files confined to `.out/spatial-test-tmp/` and `LUA` selecting
the bundled Lua 5.1 executable:

| Command | Result |
| --- | --- |
| `FOREVER_DBC_DATABASE="$PWD/.cache/dbc/dbc-source.db" uv run --no-project python -B tools/dbc/support.test.py` | 15 passed, including real snapshot acceptance |
| `uv run --no-project python -B tools/dbc/coordinates.test.py` | 10 passed |
| `uv run --no-project python -B tools/dbc/rewrite.test.py` | 9 passed |
| `uv run --no-project python -B tools/dbc/convert.test.py` | 18 passed |
| `uv run --no-project python -B tools/dbc/download.test.py` | 11 passed; mocked transport |
| `uv run --no-project python -B tools/cli/questiedb.test.py` | 25 passed, 3 platform-specific skips |
| `uv run --no-project ./questiedb.sh dbc-support --database .cache/dbc/dbc-source.db --build 1.60.1.69893 --output .out/forever-support/review` | Candidates generated; subsequent runs unchanged |
| `tools/lua-binary/linux-x64/lua tools/dbc/fixtures/support-compare.lua .out/forever-support/review/Zones support/Forever/Zones` | All four mapping tables match |
| `git diff --check` | Passed |

Fresh focused review found a comment-escaping issue for consecutive `]` characters. It was
fixed, and a render-and-load fixture now covers it. The checks above ran after that fix.
Python 3.8 compatibility was inspected, not executed on a Python 3.8 interpreter. Full
Generation, packaging and live-client checks were not run because no runtime input changed.

## Covered meaning and deliberate failures

- Hawkwind's precise projection and `43.89,76.66` export remain covered by existing suites.
- Parent routing preserves direct assignments, selects the highest mapped ancestor and never
  assigns a frame to an authored point. Reverse mappings remain canonical.
- `{0,0}`, phases, instance presence and unsupported assignments are distinct. Prince
  Tortheldrin and object markers are position-meaning fixtures, not renderer acceptance.
- Missing/failed sources, invalid fields, broken references, cycles, ambiguous assignments,
  exception collisions, partial sentinels and changed source applicability fail visibly.
- Hand-edited output, symlink/traversal destinations and installation failure exercise protected
  output behavior. Existing installer cancellation/recovery tests still pass.
- The real-data comparison rejects an injected wrong target even with unchanged row counts.

## Remaining work

The report has 54 direct and 1,010 inherited routes, 54 canonical reverse mappings, 308
unresolved areas and unresolved UiMaps 1463, 1464 and 2665. It separately records 40 retained
retired-map compatibility pairs and 24 AreaTable references to absent world MapIDs. Legacy
area key 1585 is absent from the native AreaTable inventory and is not presented as a real area.

Next: the Questie sentinel-first consumer fix and renderer tests, followed by version-skew
safeguards and separately reviewed support adoption. Do not remove compatibility merely because
candidate generation passes. Entrances, six retained real synthetic-area points, client/content
coverage and the other release gates in the migration plan remain unresolved.

Active support hashes remain unchanged, and `git diff -- data src support l10n` is empty.
The protected handoff/recovery snapshot, Era inputs, excluded worktree and Questie's unrelated
staged work were untouched. No branch switch, commit, publication or live-client action occurred.
