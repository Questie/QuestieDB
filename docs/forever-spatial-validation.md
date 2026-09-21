# Forever support candidate validation

The initial validation below records the candidate implementation based on local branch
`forever`, provider HEAD `f1567bd384ff4c0d4dba2f3c8cc5a8756d05b4da`, subsequently committed
as `fd2a301`. Later sections record the parent-support extension and ownership simplification.
These are historical checkpoints; the latest workflow is in `tools/dbc/README.md`.
This is not a release or client acceptance record. The branch already contains the completed handoff, 40 compatibility pairs
and the two reviewed parent fixes; none was recreated or installed by this work.

## Initial generated files

Recorded initial hashes under `.out/forever-support/review/` (Git-ignored review artifacts).
The later parent-support extension replaces the report and adds a third Lua candidate:

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

## Parent-support extension

Based on provider commit `fd2a301`, the exporter now proposes the explicit parent links that
were in Questie's old zone overlay. Selecting direct AreaTable children of areas 616, 16591,
16593, 16606 and 16651 reproduces that overlay's complete set of 65 parent relationships.
The five-zone selection is reviewed policy; the individual links come from DBC, not a copied
production list. An independent test fixture retains the exact old overlay from Questie
commit `8f590aa47`.

The current owned parent table already contains one of the relationships. Generation adds
64 and preserves every existing base/override value and all original source bytes. Effective
parent conflicts fail rather than overwrite authored decisions. Running against an
already-adopted candidate adds no duplicates. Other deferred parent additions stay out of scope.

The new file is `.out/forever-support/review/Zones/subZoneToParentZone.lua`, SHA-256
`c0c59f1f291ebb91be1c076fc1030ca0090b4ed700b5a20f611f88dc673c833b`.
The updated `report.json` is SHA-256
`2a5b6bd97bbf3a5a9cac4fc99f581b87ea97818cf79de4fedd3b50389933def9`.
Forward/reverse candidate bytes are unchanged from the initial record.

Validation actually run after the extension:

- Support suite with the explicit local DBC snapshot: 21 passed. This includes actual Lua
  comparison against all 65 independent fixture links and every existing authored row,
  plus a negative control removing a required parent link.
- Rewriter suite: 9 passed.
- Contributor `dbc-support` command: added the parent candidate and updated the report;
  the next identical run changed zero files.
- Actual installed candidates: all four forward/reverse tables still match current support;
  parent base/override preservation and reviewed relationships pass the Lua comparison.
- Fresh read-only review found no blocking issues. Added its suggested overlapping
  base/override precedence cases, then reran the checks above.
- `git diff --check` passed; `git diff -- data src support l10n` is empty.

This extension is uncommitted. Active provider support and the Questie checkout were not
changed by it. These remain review candidates, not installed runtime data.

## Single-source override ownership

The parallel exception JSON has been removed from the working tree. Production now reads the
three current owned Lua support files, fingerprints them in the report, and preserves the
forward/reverse override payloads byte-for-byte, including comments. The five-zone parent scope
remains explicit and temporary in `parents.py`. Historical source hashes moved to a test-only
reference fixture; accepting another covered snapshot no longer requires editing configuration
hashes. This changes maintenance ownership, not the accepted mapping values.

Checks actually run after simplification and review:

- Support suite with the explicit local DBC snapshot: 26 passed. Fixtures prove that a new
  covered build and authored Lua override edits need no parallel policy update. Missing/failed
  coverage, malformed inputs, conflicting DBC facts and inconsistent compatibility pairs fail.
- Rewriter suite: 9 passed. Conversion/installer suite: 18 passed.
- CLI suite: 25 passed, 3 platform-specific skips.
- Fresh review found an overly strict reciprocal check for redundant descendant overrides.
  Fixed it and added direct/descendant coverage preserving the canonical ancestor reverse;
  the test results above include that fix.
- Generation updated forward/reverse comments to the owned payloads and refreshed the report.
  Parent candidate bytes remain unchanged. An identical rerun changed zero files.
- Actual Lua loading: all four map tables match owned support; all 65 reviewed parent
  relationships match the independent fixture, with 64 proposed additions and all existing
  base/override entries preserved.
- `git diff --check` passed. No active data, Corrections, support or localization changed.

The staged file/object listing and complete staged binary diff retained their starting hashes.
Only working-tree/untracked improvements were made; no staging or unstaging occurred.
Generated artifacts remain under `.out/forever-support/review/`, with current hashes in
`report.json`. Full Generation and live-client acceptance were not run.
