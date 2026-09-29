# Forever delta-base validation

## Reviewed import, 2026-09-29

This report records the complete disposable validation of the reviewed import. All requested
gates passed, including 15/15 gameplay checks with zero findings. This is not proof of complete
gameplay eligibility. The [guide](forever-delta-base.md) defines policy and the refresh procedure.

### Input identity and isolation

- Consumer HEAD: `5ecaf157ae51a117849bbf92b344194be241f71c`.
- Disposable directory: `/tmp/questiedb-reviewed-import.4yvj7xry`.
- Copied 578 tracked working files, 360,686,910 bytes, rather than archiving HEAD.
  The pre-existing modified `src/corrections/enum/expansions.lua` was preserved byte-for-byte.
  Its SHA-256 is `7b74fc283359cf734943be3ed5f88488d898f43ebadd094e62131745515cf526`.
- Original status remained the enum modification plus untracked `PLAN-forever-native-toc.md`
  and `hello.txt`. Both untracked files remained untouched and were not imported into the copy.
- All 76 reported baseline hash entries matched before and after validation. Candidate,
  generator, reader, helper, policy, extractor, coordinate and raw-input hashes also matched.
  Full original tracked-file hashes and HEAD/status are retained under disposable `.out/`.
- No network, source-cache changes, runtime changes, gameplay baseline changes, staging,
  commits, publication or installation were performed. Generated TOCs remain disposable.
  The copy has no `.git`, so its artifact build-commit header is forty zeroes; the input HEAD
  and working-byte manifest above identify the actual source independently.

Upstream report schema: **5**. Consumer provenance manifest schema: **3**. The
[provenance manifest](../src/corrections/Forever/generated/provenance.json) retains all current
report metadata needed to identify the import, including assumption and holdback policies.
SQLite databases were not hashed or refreshed; their paths and snapshot metadata are recorded.

| Kind | New | Updated | Relationship support | Rows |
| --- | ---: | ---: | ---: | ---: |
| npc | 2,928 | 463 | 3 | 3,394 |
| object | 20 | 24 | 8 | 52 |
| quest | 713 | 37 | 0 | 750 |
| item | 5,632 | 2,519 | 0 | 8,151 |

Total: **12,347 rows**, **9,293 new IDs**, **18,932 skips** and **478 unresolved references**
(397 NPC, 36 object, 43 quest, two item). Skips may describe individual fields, not omitted
entities. There are 5,577 table initializations, 763 `_add` fields and no `_remove` fields.

### Restrictions, assumptions and holdbacks

- Literal Source and Baked witnesses check quest 90902 (race 16, class 2), quest 94006
  (both Skyborne races, 12884901888), and quest 86585 (Alliance including Skyborne, 4294967373).
- Quest 94004 retains an explicit race zero and item starter 264011 in group 3, with nil
  holes in groups 1 and 2. The item points back to quest 94004.
- Research Access 97286 retains explicit `requiredRaces = 0` and Mage `requiredClasses = 128`.
- Generated and Static rows independently establish numeric presence. Public getters alone
  cannot distinguish absent numeric fields from zero.
- A complete run-specific check inspected all **245** emitted assumptions: each generated
  row contains zero; every post-Derived Source row still contains zero; all Source and Baked
  getters return zero. These values survive current inputs, not every possible future NPC edit.
  The runtime-zero policy (phase 5) and class-removal proposals remain unchanged and deferred.
- All **20** held quests are absent from the reported effective baseline, generated providers
  and composed Source/Baked inventories. Literal maintained witnesses cover 92534, 94901 and 3911.
  This is export withholding, not a consumer deletion mechanism.
- One not-in-game record (92534) and **19 deferred records** remain in their separate policies.
  The last 15 uncertain records were expressly deferred. No new source/client evidence in this
  import resolves any revisit question; no quest was reclassified.

Deferred IDs: 3911, 91901, 92454, 94898, 94901, 94902, 95771, 95816, 95819, 96395, 96735, 97065, 97066, 97067, 98072, 98208, 98372, 98447, 99145.
The manifest preserves each reason and revisit question. Read the upstream deferred policy
on future data work; passing validation must not make these questions disappear.

### Complete command results

Commands ran sequentially from the disposable root with full localization and default
Self-proofs enabled. `.out/<name>.command`, `.log` and `.time` retain the command, output,
exit code, elapsed/user/system time and peak RSS. `results.tsv` is the compact execution ledger.
The extra import checks live only in disposable `.out/import-check.lua`, not runtime providers.

| Log name | Command | Exit | Seconds | Peak RSS (KiB) |
| --- | --- | ---: | ---: | ---: |
| `00-import-source` | `lua5.1 .out/import-check.lua` | 0 | 0.62 | 62524 |
| `01-audit` | `lua5.1 test.lua correction-audit` | 0 | 44.25 | 44148 |
| `02-source` | `lua5.1 test.lua corrections forever-delta-base native-toc` | 0 | 4.99 | 127852 |
| `03-generate` | `lua5.1 generate.lua Forever --no-base-toc` | 0 | 34.38 | 260236 |
| `04-alias` | `cmp QuestieDB_Forever.toc QuestieDB_Camelot.toc` | 0 | 0.01 | 1792 |
| `05-verify` | `lua5.1 verify.lua Forever` | 0 | 38.18 | 442288 |
| `06-equivalence` | `lua5.1 equivalence.lua Forever` | 0 | 34.77 | 290460 |
| `07-reconstruct` | `lua5.1 reconstruct.lua Forever` | 0 | 36.99 | 381708 |
| `08-artifact` | `lua5.1 test.lua --flavor=Forever` | 0 | 2.05 | 151752 |
| `09-baked` | `lua5.1 tools/validation/forever-delta-base.test.lua Baked` | 0 | 1.07 | 69092 |
| `10-validators` | `lua5.1 validators/run.lua Forever --self-check` | 0 | 0.58 | 103148 |
| `11-import-baked` | `lua5.1 .out/import-check.lua Baked` | 0 | 1.37 | 68496 |

Measured results:

- Full decoded provider comparison: all 12,347 upstream `Load(keys)` rows equal imported
  `:Load()` tables using the real enums and registered provider runtime. Complete row bodies
  also match upstream bytes, including name/URL comments, assumption comments and nil holes.
- Correction audit: 81 providers, eight scenarios times 44 personas, 8,932 calls and
  5,087,258 rows; 24 checks passed. Source suites: 2,464 checks, zero failures.
- Generation: 46,115 entities and rows; all nine locales, 36 Localization blocks.
- Verification: 763,890 fields, 937 chunked values, 326,837 localized reads, zero errors.
- Equivalence: 763,890 fields, 579,672 localized reads (1,486 locale-shaped),
  39,307 name buckets, zero divergences; Self-proof passed.
- Reconstruction: 109,907 expected and actual data lines, zero mismatches.
- Artifact tests: four checks passed; separate Baked import witnesses passed.
- Gameplay validators: **15/15 clean, zero findings, zero baselined, zero new, zero fixed**.
  Fingerprint ownership/count/duplicate Self-check passed. No baseline was updated.
- Final file comparison: only six intended tracked files differ in the disposable copy.
  The NPC and Object providers are byte-identical to the previous consumer import; the validation
  report is new. These form a nine-file copy set. No whitespace errors or new policy helpers
  were introduced; restriction and presence checks remain beside their witnesses.

### Evidence hashes

Both disposable TOCs contain **14,205,911 bytes** and SHA-256
`ccd9f4117242582d25d77266359beab2647c0ae7eb7850c8d3d3f3949e771a1f`.
These artifacts are validation evidence, not files to copy into the working checkout.

| Upstream artifact | SHA-256 |
| --- | --- |
| `foreverBaseItem.lua` | `fb9af5a98a5f76d3035b322f6b63cc4856bd710b3c3aca9b78489c2fe32bb292` |
| `foreverBaseNpc.lua` | `cb2970582a1531bd777c1de1ab9bd9b5daf6e4995b729ac45d803715c3b3cd70` |
| `foreverBaseObject.lua` | `83f267363045c778d7e9a14da96f70b9e91f1c0af59d5c34350dc324420a4f39` |
| `foreverBaseQuest.lua` | `89273810e22eb2d41f1551d0f6c00fdca11c3974b71c5492c196dcf48264d3e9` |
| `report.json` | `956e9329305338b804bdeb3f48bb1a221d18106212bb99ec50dd7784fec0e90f` |
| `report.md` | `b24c23bcc459d6f90c195c3187aa0627876c09f70243646a3ff3b91f04113ac4` |

Generator/helper identity:

| Input | SHA-256 |
| --- | --- |
| `quest_holdbacks_sha256` | `e806fe283f5172525523306be09921b75df32d7b62fc07552439117507a513ac` |
| `race_assumptions_sha256` | `49cb9c583b2481e3b28240bfc90fd352b72a83b248e5d8e75372cdd70f83426b` |
| `raw_reader_sha256` | `b74139308d82abba2c3efa50abbab0894c22d34c712d3ddaf372579b58bffec3` |
| `sha256` | `47a511463b8eacbf97825a35c6eb8af1b71866f572e36072aeaee974951af178` |

All per-policy, imported-provider, raw-input and baseline hashes are in the provenance
manifest. Disposable `.out/source-tracked-sha256.json` SHA-256:
`7cc1484b637a43305429db5a6313fb8772d65d5811de981da420e28f6d7ed25f`.

## Historical imports, not current findings

The previous four-provider formatting refresh contained NPC 3,394, Object 52, Quest 758 and
Item 8,157 rows: 12,361 total, 9,312 new IDs, 17,610 skips and 478 unresolved references.
It had 5,416 table initializations and 765 `_add` fields. The following preserved history
describes those older imports. In particular, **625 is not the current finding count**.

After the master rebase, a disposable run passed Forever Generation, Verification,
Source/Baked Equivalence, Reconstruction and artifact tests. Gameplay validation failed on
625 quests missing `requiredRaces`; the other 14 checks were clean. That formatting-only
refresh did not resolve those findings. They were not accepted into the validation baseline.
The unresolved source references above also remain review work.

### Previous three-provider import

The earlier import passed Forever Generation, Verification, Source/Baked Equivalence
(including its Self-proof), Reconstruction and artifact behavior tests. Those results are
historical and predate the reviewed import above. Its gameplay validator failed with
648 new findings: 626 quests lack `requiredRaces`, 19 starter-link findings affect nine NPCs
(nine missing reverse links and ten reverse links whose quest does not name that starter),
and three missing finisher links affect two NPCs. Twelve of fifteen checks are clean.

In that earlier whole-field import, generated fields superseded legacy fields and forward
and reverse relationships disagreed after all Corrections. NPC 376's reverse lists omitted starters
5631, 5634, 5645 and 5676 and finishers 5640 and 5678; its starter list includes 5641 and
8254 although those quests did not name it as starter. The previous generated-first order
had 640 findings. These findings were not accepted into the validation baseline; their
counts describe the earlier import, not the current validation result above. Restrictions
and relationship reconciliation require separate authored review, not invented defaults or
a different precedence rule.


## Symbolic mask formatting refresh, 2026-09-29

This run changes quest race/class mask spelling only. It does not repeat or replace the
reviewed import's full artifact gates above. The historical report is preserved byte-for-byte.
The new upstream directory is `/home/logon/projects/forever-base-db/generated/symbolic-masks/`:
report schema **6**, consumer provenance schema **3**. Its `lua_rendering` metadata records
Quest `Load(QuestieDB)` with Forever `questKeys`, `raceKeys` and `classKeys`; other standalone
providers retain `Load(keys)`. Imported providers retain the existing colon `:Load()` contract.

### Isolation and input identity

- Disposable root: `/tmp/questiedb-symbolic-masks.4Qynbp`.
- Consumer HEAD: `5ecaf157ae51a117849bbf92b344194be241f71c`.
- Copied all 578 tracked **working files**, including the uncommitted reviewed import, staged
  provenance and targeted test bytes, existing enum edit and `test.lua` change. Explicitly
  copied the prior untracked `docs/forever-delta-base-validation.md` as historical evidence.
  `PLAN-forever-native-toc.md` and `hello.txt` were hashed and left untouched in the original.
- Original HEAD, status, tracked working bytes, index bytes, both existing TOCs and protected
  untracked files matched before and after. `.out/source-before.json`, `source-after.json`
  and `source-index-before` preserve that evidence. Index SHA-256:
  `560f086e3578021c3eb42e5e5f629b8b76a5c1c04f096862b7f7d5bcc7d58f39`.
- Before editing, all four working provider hashes strictly matched the prior provenance.
  Unexpected provider edits would stop the refresh rather than overwrite user formatting.
- All 101 reported input hash entries matched before and after, including all 76 baseline
  entries, raw inputs, generator, reader, helper, policy, extractor, coordinate and snapshot
  manifest hashes. The complete 709-file upstream non-cache/non-database inventory also
  remained identical. `.out/upstream-before.json`, `upstream-after.json`, `reported-inputs.json`
  and the input-check logs retain the evidence. SQLite databases were neither opened nor hashed.
- Old and new reports differ only in `schema_version`, `generator.sha256` and `lua_rendering`.
  Numeric changes, skips, references, held quests, race/class mappings, assumptions, policies,
  baseline metadata and counts are identical. NPC, Object and Item upstream files are byte-identical.
  Their imported files and imported hashes are also unchanged.
- No original consumer, generator or scraper files were written. No staging, commit, push,
  network access, TOC Generation or gameplay baseline updates were performed. Only the quest
  provider, provenance, guide and this appended report differ in the disposable copy.

### Complete decoded equality and restriction checks

`.out/decoded-equality.lua` executes every provider using the real Forever compatibility
module context. It compares all nested keys and values in four forms: prior numeric standalone,
new symbolic standalone with its correct API, previous working imported wrappers, and new
imported wrappers. It does not substitute string comparison for execution.

All **12,347 rows** match: **750 Quest, 8,151 Item, 3,394 NPC and 52 Object**. Counts remain
9,293 new IDs, 18,932 skips, 478 unresolved references, 5,577 table initializations and 763
`_add` fields, with no `_remove` fields. The quest import's entire upstream body, including
locals, is byte-identical; only its module header is adapted. Comparing the previous quest
body after masking race/class expressions also proves every other byte remains unchanged,
including URLs, assumption comments, nil holes, map keys and other numeric fields.

All **245** explicit race zeroes remain literal zeroes in generated rows and remain present
as numeric zero after current Source Derived Passes and through Source getters. The check also
asserts race masks 12,884,901,888 and 4,294,967,373, Research Access class 128, and the writ's
item starter in group 3 with nil groups 1 and 2. All 20 held quests remain absent from both
generated providers and composed Source inventory. The **19 deferred quests remain open**;
this formatting refresh supplies no new eligibility evidence and reevaluates none of them.

Canonical decoded hashes below match across all four forms. The disposable encoder sorts
numeric table keys and uses type-tagged, length-prefixed strings and exact numeric spelling,
so sparse slots and absent-versus-zero remain distinct. Raw canonical files are under `.out/`.

| Provider | SHA-256 of decoded canonical bytes |
| --- | --- |
| Quest | `fcffb0f0a6508e24aaa8e2ea95377b4c73504ac98090484816f6f00a5f08c506` |
| Item | `511ad34793c1645f43e62192f5ca41d91f1b03f55aae385eb75bed513da98419` |
| Npc | `150f3898e5effe82acf5a942c52f8daab7bef612927a2860c9885608f612822a` |
| Object | `a06b8144606600a7fc81109dd7e74c07d0b59983d6cbef0ddf9b1aaef4d430f7` |

### Commands run for this refresh

All commands ran only in the disposable root. `.out/<name>.command`, `.log` and `.time`
record each command, output, exit status, elapsed time and peak RSS; `.out/results.tsv`
is the compact ledger.

| Log name | Command | Exit | Seconds | Peak RSS (KiB) |
| --- | --- | ---: | ---: | ---: |
| `00-equality` | `lua5.1 .out/decoded-equality.lua` | 0 | 2.59 | 90888 |
| `01-audit` | `lua5.1 test.lua correction-audit` | 0 | 47.85 | 47276 |
| `02-source` | `lua5.1 test.lua corrections forever-delta-base native-toc` | 0 | 5.61 | 126492 |
| `03-validators` | `lua5.1 validators/run.lua Forever --self-check` | 0 | 0.60 | 102468 |

- Correction audit: **24 checks**, zero failures; 81 providers, eight scenarios times 44
  personas, 8,932 calls and 5,087,258 rows.
- Source suites: **2,464 checks**, zero failures (2,463 corrections, one import suite;
  native-TOC assertions passed but contribute zero to the runner's check counter).
- Gameplay validators: **15/15 clean, zero findings, zero baselined, zero new, zero fixed**.
  Fingerprint ownership/count/duplicate Self-check passed; no baseline was changed.
- No tests or runtime APIs were modified. No new production helpers were introduced; quest
  key and mask aliases remain visible beside the provider body.

Generation, Verification, Source/Baked Equivalence, Reconstruction, artifact tests and Baked
witnesses were **not rerun** for this formatting-only refresh. The full decoded equality and
unchanged policy inputs support reusing the reviewed import's full-artifact evidence above;
they do not establish new live-client behavior, gameplay completeness or future zero-preservation
under changed NPC evidence. The runtime-zero policy remains deferred.

### Refresh artifact identity

| Artifact/input | SHA-256 |
| --- | --- |
| Upstream `foreverBaseQuest.lua` | `276dbead21fb3e3317627655394fdb5ba167222f2a008aff63ed44acf22642cc` |
| Upstream `report.json` | `b063b57a6d6f1080be20ff3671be4f66d1e8aefb6b4017153ec91b1e75222c2a` |
| Upstream `report.md` | `b24c23bcc459d6f90c195c3187aa0627876c09f70243646a3ff3b91f04113ac4` |
| Imported `foreverBaseQuest.lua` | `7d126ccd90519322f2b2ae416839aaab82fc9a66d380828f32b73d21378f0202` |
| Generator `forever_delta.py` | `0aba37a4985b787e6e5abda4c69b2c7410eae030d7070821ced7d2420477f0be` |

All other provider and input hashes are retained in `provenance.json`. The exact four-file
copy set and its final SHA-256 values are in disposable `.out/ready-sha256.txt`. Copy only
those reviewed files, not `.out/`, TOCs or any other disposable files.

## Numeric field-order refresh

Upstream: `/home/logon/projects/forever-base-db/generated/index-order/`.
Disposable copy: `/tmp/questiedb-index-order.w3fyw9rv`.

All four providers now list fields by their consumer authoring index: removes,
ordinary sets, then adds; each group follows schema order. The baseline reader
returns the actual authoring keys, including operation aliases. No index map is
hard-coded in the generator. Standalone and imported provider APIs are unchanged.

A full upstream extraction produced the same 12,347 rows. Old/new reports differ
only in generator/reader hashes and `lua_rendering` metadata. Every provider is
exactly a permutation of existing field lines within the same rows, preserving
wrappers, values, symbolic expressions, URLs, assumption comments and nil holes.

Disposable validation passed:

- Complete four-way Lua equality: previous/new standalone and previous/new imports.
  All 12,347 rows and 45,027 fields match. Every emitted row's field indices increase
  strictly in both new forms, checked against real runtime keys.
- All 245 authored race zeroes survive current Source Derived Passes; Mage 128 remains.
  All 20 held quests remain absent. The 19 deferred questions remain open.
- `lua5.1 test.lua correction-audit`: 24 checks passed.
- `lua5.1 test.lua corrections forever-delta-base native-toc`: 2,464 checks passed.
- `lua5.1 validators/run.lua Forever --self-check`: 15/15 clean, zero findings.
- All 101 reported input hashes match, including 76 baseline entries. Imported and
  upstream artifact hashes match provenance. Generator tests: 249 passed; Ruff clean.

The prepared copy set is the four generated providers, provenance, the import guide
and this report. Source state and index hashes are recorded in `.out/source-before.json`;
commands, logs and results are in `.out/`. Existing enum/test-scope edits and protected
untracked files are outside that copy set. No TOCs, runtime code, consumer tests or
validation baselines change. Full artifact gates were not rerun for this order-only
refresh; complete value equality supports reusing the prior full-gate evidence.

## Reputation reward import

Upstream: `/home/logon/projects/forever-base-db/generated/reputation-rewards/`.
Report schema **7**, consumer provenance schema **3**. Disposable checkout:
`/tmp/questiedb-reputation.lnqfoevw`, copied from consumer working bytes at HEAD
`cc8869c569ac4e34ec9956047216c8255f3c1202`, including the existing enum edit.

The import supplies 696 faction/amount pairs on 459 new quests. Four existing quests
receive another faction reward; 17 existing quests change an amount with an exact
old-pair removal plus new-pair addition. Source and target agree on every removed
Era amount. No source-only faction removal is applied. Ambiguous duplicate source
factions are withheld whole. Signed amounts and explicit zero are supported without
inventing bonuses, spillover, caps or requirements.

Inventory: NPC 3,394, Object 52, Quest **771**, Item 8,151; **12,368** correction rows,
9,293 new IDs, 19,003 skips and 478 unresolved references. Table-field counts:
6,036 initializations, 784 adds, 17 removes. Compared with the index-order import,
all old correction rows and non-reputation fields are unchanged; the 21 additional
rows modify reputation only. NPC, Object and Item provider bytes are identical.

### Fresh full validation

All 12 commands recorded in `.out/results.tsv` exited zero, with command text,
output, exit status, elapsed time and peak RSS retained alongside it. Unlike the
formatting refreshes, this run repeated the full artifact gates with localization
and Self-proofs enabled. No gameplay baseline was updated.

- Numeric-report, standalone and imported tables match for all **12,368 rows**.
- All **480** affected quests match their expected reward lists through both
  composed Source and freshly generated Baked getters, including replacements
  without duplicate factions and additions preserving inherited rewards.
- All 245 authored race zeroes survive current Source Derived Passes and Baked
  reads. Research Access remains Mage-restricted; all 20 held quests remain absent.
- Correction audit: 24 checks, 81 providers, 8,932 calls; zero failures.
- Correction/delta-base/native-TOC suites: 2,464 checks passed. Maintained literal
  Source/Baked witnesses cover quests 86585, 94004, 8368 and 6562.
- Generation: 46,115 entities and rows, all nine locales; Forever/Camelot TOCs match.
- Verification: 763,890 fields, 937 chunked values, 326,837 localized reads; zero errors.
- Equivalence: 763,890 fields, 579,672 localized reads, 39,307 name buckets;
  zero divergences and Self-proof passed.
- Reconstruction: 110,366 expected/actual data lines; zero mismatches.
- Forever artifact tests: four checks passed; separate Baked witnesses passed.
- Gameplay validators: **15/15 clean, zero findings**, Self-check passed.
- Generator: **290 tests passed**, Ruff lint/format clean. Independent code review
  found no actionable implementation issue.
- All 101 reported input hashes, including 76 baseline entries, and every candidate
  and imported-provider hash match provenance. `.out/source-before.json` records
  original working-tree/index/TOC hashes for the final copy guard.

Only generated providers/provenance, the focused import witness test, this report
and the guide belong to the copy set. Do not copy disposable TOCs or `.out/` files.
No runtime, schema, raw-data, legacy/manual provider, enum or unrelated user edit
is part of this change. The 19 deferred quests remain open; reward evidence does
not resolve their acceptance or availability questions.

## Complete reputation replacements

`generated/reputation-sets/` collapses the 17 complete target-list replacements to
plain `reputationReward` fields. No partial change is collapsed; all four faction
additions remain `_add`. It emits only accepted additions, not unchanged source
rewards missing from the target. Future baseline changes require regeneration:
a plain set does not preserve newly added upstream entries like partial operations do.

Disposable validation: `/tmp/questiedb-reputation-sets.h1an6_rc`. All 14 commands in
`.out/results.tsv` passed, including a fresh full Generation, Verification,
Equivalence with Self-proof, Reconstruction, artifact tests, Baked witnesses and
15/15 clean gameplay validators. Generator tests: **292 passed**, Ruff clean.

Old/new complete Static composition matches for all 4,989 quests. The new artifact
is byte-identical to the previous fully validated reputation artifact except for
`X-BUILD-TIME`. All 480 reward results, 245 zeroes, Mage restriction and holdbacks
still pass Source/Baked checks. Counts remain 12,368 correction rows; table fields
now comprise 6,036 initializations, 17 complete replacements, 767 adds and no removes.
Provenance distinguishes `replace` from `initialize` rather than calling all plain
fields initializations. All 101 input hashes and artifact hashes match provenance.

Only the quest provider, provenance, guide and this report change. Consumer tests,
runtime, raw data, other providers and working TOCs are outside the copy set.
The 19 deferred quests remain open and no eligibility evidence was added.
