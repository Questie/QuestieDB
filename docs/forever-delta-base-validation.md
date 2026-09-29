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


## Quest category enrichment

Upstream: `/home/logon/projects/forever-base-db/generated/quest-category-enrichment/`.
Report schema **8**, consumer provenance schema **3**. Prepared and tested entirely in
`/tmp/questiedb-category-import.jbwjgN`, from consumer HEAD
`79756f305442f957e2f2067ca94789d5af24c2b0`.

### Scope and input identity

The new values are exactly **729 numeric `zoneOrSort` fields**. Category evidence enriches
existing or independently selected quests, never selects missing quests by itself, and does
not establish physical geography. Existing nonzero categories remain authoritative.
`quest_categories.py`, its hash, the complete `category_catalog` and category policy are
recorded in provenance. No runtime, enum, maintained test, raw data, other provider or gameplay
baseline changes accompany this import.

All **579 tracked working files** were copied, not a HEAD archive. This retains the existing
`src/corrections/enum/expansions.lua` edit. No `.git`, prior `.out`, or untracked source files
were copied. The original HEAD, status, index, tracked working bytes, TOCs and protected
`PLAN-forever-native-toc.md` / `hello.txt` hashes match the parent's guard before and after.
All four old working provider hashes matched the old provenance before adaptation.
Only the Quest provider's module boundary differs from upstream: its entire body, alias
locals, comments, nil holes and numeric field order are retained byte-for-byte. NPC, Object
and Item imports remain byte-identical to the previous working import.

All **102 reported input hashes**, including **76 baseline entries**, match before and after:
generator, reader, three helpers, assumption/holdback policies, extractor, raw inputs,
coordinate manifest and snapshot manifest. Candidate and captured generator-file hashes are
retained in `.out/upstream-before.json`, `upstream-after.json`, `generator-before.json` and
`generator-after.json`. SQLite caches were not opened, hashed or refreshed. No network,
working TOC writes, staging, commit, publication or installation occurred. The disposable
TOCs use a forty-zero build-commit header because the copy has no `.git`; the source guard
identifies the actual input commit and working bytes.

Inventory remains **12,368 rows**: Quest **771**, NPC **3,394**, Object **52**, Item **8,151**;
**9,293 new IDs**, **19,445 skips**, and **478 unresolved references** (397 NPC, 36 Object,
43 Quest, two Item). Skips may describe withheld fields, not omitted entities. Table-field
counts are unchanged: 6,036 initializations, 17 complete replacements, 767 adds, no removes.

### Complete import checks

Disposable `.out/import-check.lua` compares every decoded field recursively across numeric
report values, standalone providers and registered imported providers, using the actual
Forever context. Quest standalone loading takes `QuestieDB`; the other three take their keys.
All **12,368 rows** match. Comparison with the previous working import confirms identical
IDs and **45,507 unchanged non-category fields**. Exactly 729 category fields are additions.

Every added category is checked in the generated provider, after Static composition, after
Derived Passes, in materialized Source rows, and through Source/Baked named, generic-name,
generic-index and raw getters. Current authored Forever Static and Dynamic providers contain
**zero category overrides**; no precedence exception was hidden. Literal witnesses pass:

| Quest | Category |
| --- | ---: |
| 86585 | 38 |
| 94004 | 16941 |
| 96031 | -666 |
| 92482 | -261 |
| 94947 | 1519 |
| 95350 | 1637 |

Inherited quest **6 = 9** and **384 = -304** remain unchanged. Category-only quest **78124**
is absent from generated, composed and public inventories. All **245** reviewed assumptions
remain explicitly present as numeric zero in generated, post-Static and post-Derived rows;
Source and Baked reads return zero. Research Access **97286** retains Mage **128**, and
quest **94006** retains race high bits **12,884,901,888**. All **20 holdbacks** remain absent.
Baked storage intentionally omits scalar zero slots, so numeric presence is checked in the
Generation inputs and Source rows, not inferred from Baked storage.

All **19 deferred quests remain open**. Their revisit questions were read; this category-only
candidate adds no giver, eligibility or client acceptance evidence to resolve them. None was
reclassified or newly investigated. Phase 5's runtime-zero policy remains deferred, and current
zero-preservation does not guarantee preservation after future NPC evidence changes.

### Fresh sequential validation

All twelve commands exited zero. Full localization and default Self-proofs were enabled;
no sampling or baseline updates were used. `.out/<name>.command`, `.log` and `.time` record
command, output, exit, wall time and peak RSS; `.out/results.tsv` is the execution ledger.

| Log | Command | Exit | Seconds | Peak RSS (KiB) |
| --- | --- | ---: | ---: | ---: |
| `00-import-source` | `lua5.1 .out/import-check.lua` | 0 | 3.03 | 176668 |
| `01-audit` | `lua5.1 test.lua correction-audit` | 0 | 43.19 | 44132 |
| `02-source` | `lua5.1 test.lua corrections forever-delta-base native-toc` | 0 | 5.25 | 123020 |
| `03-generate` | `lua5.1 generate.lua Forever --no-base-toc` | 0 | 34.04 | 256936 |
| `04-alias` | `cmp QuestieDB_Forever.toc QuestieDB_Camelot.toc` | 0 | 0.01 | 1536 |
| `05-verify` | `lua5.1 verify.lua Forever` | 0 | 37.30 | 446672 |
| `06-equivalence` | `lua5.1 equivalence.lua Forever` | 0 | 35.98 | 294716 |
| `07-reconstruct` | `lua5.1 reconstruct.lua Forever` | 0 | 37.10 | 370156 |
| `08-artifact` | `lua5.1 test.lua --flavor=Forever` | 0 | 2.06 | 152036 |
| `09-baked` | `lua5.1 tools/validation/forever-delta-base.test.lua Baked` | 0 | 1.03 | 68420 |
| `10-validators` | `lua5.1 validators/run.lua Forever --self-check` | 0 | 0.65 | 103220 |
| `11-import-baked` | `lua5.1 .out/import-check.lua Baked` | 0 | 3.66 | 188300 |

- Correction audit: **24 checks**, 81 providers, eight scenarios times 44 personas,
  8,932 calls and 5,088,182 rows; zero failures.
- Correction/import/native-TOC suites: **2,464 checks**, zero failures.
- Generation: **46,115 entities and rows**, all nine locales and 36 Localization blocks.
  Forever and Camelot artifacts are byte-identical.
- Verification: **763,890 fields**, 937 chunked values, 326,837 localized reads; zero errors.
- Equivalence: **763,890 fields**, 579,672 localized reads (1,486 locale-shaped),
  39,307 name buckets; zero divergences and Self-proof passed.
- Reconstruction: **110,366 expected and actual data lines**, zero mismatches.
- Forever artifact tests: **four checks** passed; separate Baked import witnesses passed.
- Gameplay validators: **15/15 clean**, zero findings, zero baselined, zero new, zero fixed;
  fingerprint ownership/count/duplicate Self-check passed.

The upstream handoff reports **334 generator tests passed**, Ruff and focused review clean.
Those generator checks were not rerun here; this run freshly executed the consumer gates above.

### Ready-file identity

Only these four files are prepared for fresh parent review and an explicit allowlisted copy:
`src/corrections/Forever/generated/foreverBaseQuest.lua`, its sibling `provenance.json`,
`docs/forever-delta-base.md`, and this appended validation report. Historical report bytes are
preserved. The exact allowlist and final hashes are in `.out/copy-files.json` and
`.out/ready-sha256.json`. No disposable TOC or `.out/` file belongs to the copy set.

Disposable TOCs: **14,228,741 bytes** each, SHA-256
`edcc5c175ec21b4eaad25e8b8bb1092c09492ec188b1119134f5b77c46e61381`.

| Upstream artifact | SHA-256 |
| --- | --- |
| `foreverBaseItem.lua` | `c6e7ef472fa931fa97fd1ab71b19ee42e0e73ec38d07489b1f672f3454ddd148` |
| `foreverBaseNpc.lua` | `18f4ee896613f1c399471e88c565dcb460e00ddfd72e78f6fa70da88b0a3aaee` |
| `foreverBaseObject.lua` | `25fafa10761cc3bb3130c9816c5d67ec436ae381e07c0fc714463e63da5a545b` |
| `foreverBaseQuest.lua` | `55796df34ab095f3cda2c9a0bc9b61f66073729f4cb99ef53462b88f75705eb2` |
| `report.json` | `3bfc637ae639283f80feb137f56b5c6f62e3969ec36a3d4d5ebe0aaa2fc895ae` |
| `report.md` | `4b46362b2641e6ceb258410321e5a4f9e199be1708fbf19e993c7730e94fdd0a` |

All imported-provider and reported-input hashes are retained in `provenance.json`.
These offline gates do not establish complete gameplay data or live-client acceptance.


## Symbolic categories and category-zero omission refresh

Prepared in `/tmp/questiedb-symbolic-categories.uVs2Ik` from tracked **working bytes** at
HEAD `79756f305442f957e2f2067ca94789d5af24c2b0`. The source checkout, staged index,
TOCs and protected untracked files were not written. No `.git`, existing `.out/` or
unrelated untracked files entered the disposable snapshot. Tracked symlinks were refused.
The four pre-existing import edits and the existing expansion-enum edit were preserved as
inputs, not replaced with HEAD versions.

The initial parent guard is `/tmp/questiedb-symbolic-category-guard.hpmqzlm9`.
Its only permitted difference at preparation was the parent's three zone constants:
`RUINS_OF_LORDAERON = 16611`, `THE_HALL_OF_THANES = 16919`, `CRAFTING = 16941`.
All old constants and all other guarded bytes matched. Required `zones.lua` SHA-256:
`dd738ec0c1a9785946c5574a5f7cb8d2a64745b099dffccebd00ee8864fbb88a`.
That enum is an input already edited by the parent, not part of this four-file copy set.
Final guards compare against both the initial guard and the current-input snapshot.

### Input identity and exact change boundary

Upstream: `/home/logon/projects/forever-base-db/generated/symbolic-categories/`, report
schema **9**. All **102** reported input hashes were verified before and after validation,
including **76** baseline entries, plus all six candidate files and 180 generator/report/policy
files. SQLite files were neither opened nor hashed. Provenance retains existing metadata and
records the new rendering contract, policies, category catalog, generator/helper hashes,
all upstream/imported hashes and required enum input. Any drift in these inputs invalidates
this validation; rerun before adopting a changed candidate.

Inventory remains **12,368 rows**: Quest **771**, NPC **3,394**, Object **52**, Item **8,151**;
**9,293 new IDs**, **19,445 skips**, **478 unresolved references** (397 NPC, 36 Object,
43 Quest, two Item). No maintained tests or expected counts changed. Table fields remain
6,036 initializations, 17 complete replacements and 767 adds, with no removes.

There are **721 nonzero category assignments**, all exact `zoneIDs.NAME` or `sortKeys.NAME`,
with no numeric fallback, extra negation or unused aliases. Only these eight raw category
assignments change from explicit `0` to absent: **78132, 78133, 78134, 91899, 91900, 91904,
91905, 93862**. The other **45,507 non-category fields**, all IDs and every nonzero category
value are unchanged. Race/class, level and reputation zeroes are unaffected.

Standalone Quest now takes `Load(QuestieDB, ZoneDB)`; other providers still take `Load(keys)`.
The imported Quest retains `:Load()` and its QuestieDB import, adding a real ZoneDB module
import before the function. The complete upstream function body is byte-identical, including
aliases, comments, nil holes and field order. NPC, Object and Item upstream and imported
files are byte-identical to the prior import. Compatibility and runtime code are unchanged.

### Complete decoded and runtime checks

Run-specific `.out/import-check.lua` compares all rows and fields recursively among the
old numeric standalone providers, new standalone providers, previous working imports,
new registered imports and independently serialized numeric report values. Only the eight
listed zero-to-absent changes are accepted. Actual consumer module contexts are used; zone
constants are not attached to QuestieDB or supplied through fake global enums.

Every nonzero category agrees in generated tables, post-Static rows, post-Derived rows,
materialized Source rows and Source/Baked getters. The eight omitted fields are explicitly
**absent** after Static and Derived and in materialized Source rows, while getters return
zero. This was not inferred from normalized getter values. Authored Forever Static/Dynamic
category overrides remain **zero**.

All **4,989 existing quests** match the previous full-validated numeric import in Source and
Baked modes across eight category read forms: named, generic-name, generic-index,
`GetByIndex`, raw-name, raw-index, batch-name and batch-index. Inventories match in both
directions. The full Equivalence sweep independently checks current Source/Baked equality.

Literal witnesses: **94004 = CRAFTING 16941**, **96031 = CAMPING -666**, **86585 = 38**,
**92482 = -261**, **94947 = 1519**, **95350 = 1637**. Baseline quests **6 = 9** and
**384 = -304** remain unchanged. Category-only **78124** stays absent. All **245** reviewed
race assumptions remain explicitly present as `0` after Static/Derived and in Source rows;
Source/Baked reads remain zero. Quest **94006** retains Skyborne **12,884,901,888**,
**79008** retains Alliance **4,294,967,373**, and **97286** retains Mage **128**.
All **20 holdbacks** remain absent. Baked scalar storage intentionally omits zero slots;
raw numeric presence was checked before storage rather than asserted from getters.

The 19 deferred quest revisit questions were read and remain open. This rendering refresh
provides no new giver, eligibility or client-acceptance evidence; none was reclassified.
Phase 5's runtime-zero policy remains deferred. Current zero preservation does not guarantee
preservation if future NPC evidence changes the existing Derived Pass.

### Fresh sequential validation

All twelve commands exited zero. No localization skipping, sampling, baseline updates or
Self-proof bypasses were used. Full commands, output, exit codes, wall times and peak RSS
are in `.out/<name>.command`, `.log`, `.time` and `.out/results.tsv`.

| Log | Command | Exit | Seconds | Peak RSS (KiB) |
| --- | --- | ---: | ---: | ---: |
| `00-import-source` | `lua5.1 .out/import-check.lua` | 0 | 4.65 | 233788 |
| `01-audit` | `lua5.1 test.lua correction-audit` | 0 | 44.79 | 48332 |
| `02-source` | `lua5.1 test.lua corrections forever-delta-base native-toc` | 0 | 5.48 | 126756 |
| `03-generate` | `lua5.1 generate.lua Forever --no-base-toc` | 0 | 34.23 | 252988 |
| `04-alias` | `cmp QuestieDB_Forever.toc QuestieDB_Camelot.toc` | 0 | 0.01 | 1536 |
| `05-verify` | `lua5.1 verify.lua Forever` | 0 | 38.59 | 446516 |
| `06-equivalence` | `lua5.1 equivalence.lua Forever` | 0 | 36.41 | 299148 |
| `07-reconstruct` | `lua5.1 reconstruct.lua Forever` | 0 | 36.64 | 369780 |
| `08-artifact` | `lua5.1 test.lua --flavor=Forever` | 0 | 2.12 | 152292 |
| `09-baked` | `lua5.1 tools/validation/forever-delta-base.test.lua Baked` | 0 | 1.09 | 68704 |
| `10-validators` | `lua5.1 validators/run.lua Forever --self-check` | 0 | 0.68 | 103092 |
| `11-import-baked` | `lua5.1 .out/import-check.lua Baked` | 0 | 6.87 | 227724 |

- Correction audit: 24 checks, 81 providers, eight scenarios times 44 personas,
  8,932 calls and 5,088,182 rows; zero failures.
- Correction/import/native-TOC suites: 2,464 checks; zero failures.
- Generation: 46,115 entities/rows, all nine locales and 36 Localization blocks.
  Forever and Camelot artifacts are byte-identical.
- Verification: 763,890 fields, 937 chunked values, 326,837 localized reads; zero errors.
- Equivalence: 763,890 fields, 579,672 localized reads (1,486 locale-shaped),
  39,307 name buckets; zero divergences, Self-proof passed.
- Reconstruction: 110,366 expected/actual data lines; zero mismatches.
- Artifact tests: four checks passed; separate Baked import witnesses passed.
- Gameplay validators: 15/15 clean; zero findings, baselined, new or fixed;
  fingerprint ownership/count/duplicate Self-check passed.

Upstream reports 394 generator tests, Ruff and fresh focused review passing; those Python
gates were not rerun here. Small hash, report and formatting checks were run with `uv`.

### Prior artifact comparison and copy boundary

The new Forever TOC has 14228741 bytes and 110,443 lines. Compared with
`/tmp/questiedb-category-import.jbwjgN/QuestieDB_Forever.toc`, **only line 24's
`## X-BUILD-TIME` differs**. Every other byte matches, including all entity and Localization
data, metadata and file-list directives. This is not a claim of whole-file byte equality.
The first comparison helper used incorrect capitalization for that metadata key; its assertion
was corrected to the actual `X-BUILD-TIME` spelling and the complete comparison passed.
Exact comparison evidence is in `.out/prior-artifact-comparison.json`.

Current TOC SHA-256: `0f841407f1b9babce00e88103ad180679d27f6585e398fbc4bdb29931cc1726a`.
Previous TOC SHA-256: `edcc5c175ec21b4eaad25e8b8bb1092c09492ec188b1119134f5b77c46e61381`.

Only four files are prepared for parent review and guarded copy:
`src/corrections/Forever/generated/foreverBaseQuest.lua`, its sibling `provenance.json`,
`docs/forever-delta-base.md`, and this appended validation report. All previous report bytes
are preserved. `.out/copy-files.json` and `.out/ready-sha256.json` identify the copy set;
`.out/required-enum-input.json` records the separate zone-enum prerequisite. No TOC, test,
compatibility/runtime file or disposable evidence file belongs to the copy set.

| Upstream artifact | SHA-256 |
| --- | --- |
| `foreverBaseItem.lua` | `c6e7ef472fa931fa97fd1ab71b19ee42e0e73ec38d07489b1f672f3454ddd148` |
| `foreverBaseNpc.lua` | `18f4ee896613f1c399471e88c565dcb460e00ddfd72e78f6fa70da88b0a3aaee` |
| `foreverBaseObject.lua` | `25fafa10761cc3bb3130c9816c5d67ec436ae381e07c0fc714463e63da5a545b` |
| `foreverBaseQuest.lua` | `0f4dfd18ecb2b4ef123134967741739e7ce50814dd6b836e25f37f1b0939be41` |
| `report.json` | `7e49be47e7faee3165938ca651d3f62d2b40cc52d32e98afdb754d7c65fd893e` |
| `report.md` | `768d889f82c4f18b65d6da05bd9938a4851990ec9f7c866dc4e49e2f32193efc` |

Offline validation does not establish complete gameplay data or live-client acceptance.


## NPC/Object primary-zone enrichment

Prepared in `/tmp/questiedb-entity-zone-import.irJ2Ci` from tracked **working bytes** at consumer
HEAD `7f2dac077b75cbb8f50ba3d304f9d7bf9b95bac2`, including the existing expansion-enum edit. Upstream:
`/home/logon/projects/forever-base-db/generated/entity-zones/`, generator HEAD `e00ee64`,
report schema **10**, consumer provenance schema **3**. This is a focused Source validation,
not a new full Baked validation. Earlier full-artifact results above remain historical.

### Identity and isolation

All 579 tracked working files were copied. Tracked symlinks were refused; `.git`, prior
`.out/` and untracked files were excluded. The original HEAD, status, index, all tracked
working bytes, working TOCs and protected `PLAN-forever-native-toc.md` / `hello.txt` hashes
are guarded in `.out/source-before.json` and `source-after.json`; the original index backup
is `.out/source-index-before`. Existing provider hashes strictly matched old provenance.
All **103 reported input hash entries**, including **76 baseline entries**, match before
and after, including the new `entity_zones.py`, generator, reader, other helpers, policies,
raw inputs, extractor, coordinate and snapshot manifests. Six candidate hashes and the
upstream narrative report hash also match. Evidence is retained in `.out/reported-inputs-*`
and `.out/upstream-*`. No original checkout, generator, scraper, cache, index or TOC was
written. No network, staging, commit, push, installation or gameplay baseline update ran.
SQLite files were neither opened nor hashed; separate zone-cache snapshot provenance is
copied from the report, not claimed freshly verified against a live database.

Only NPC/Object wrappers change: imported `:Load()` uses QuestieLoader's real QuestieDB
and ZoneDB modules. The complete upstream body remains byte-identical, including aliases,
comments, nil holes and field order. Quest/Item candidate bytes match symbolic-categories;
their imported files remain untouched. Runtime, schema, enums and counters are unchanged.

### Complete comparison and Source results

`.out/import-check.lua` executes all four standalone providers and registered imported
providers in the real Forever compatibility context, comparing all nested keys/values with
independently serialized numeric report values. It also executes the previous imported
wrappers against the same owning modules. All **12,368 rows** match report/upstream/import:
NPC **3,394**, Object **52**, Quest **771**, Item **8,151**. Compared with the prior import,
all IDs and **46,228 existing fields** are unchanged, including every spawn field.
The only additions are **1,501 NPC `zoneID`** and **22 Object `zoneID`** fields.
Counts remain 9,293 new IDs, 19,445 skips and 478 unresolved references. Table fields retain
6,036 initializations, 17 replacements and 767 adds, with no removes.

All **1,523** zones match after the real registered Static pipeline and after Derived
Passes in materialized Source rows, then through public named, generic-name and generic-index
getters. Source loads via `emulator/client.lua` and `emulator/metadata.lua`, as the maintained
witness suite does, independently of the offline comparison runtime. Preserved witnesses:
Copper Vein **1731 = 14**, Defias Watchman **1725 = 40**. Unselected Object **409731** is
absent from both generated imports, Static composition and Source inventory. All **20 held
quests** remain absent from old/new generated rows, Static composition and Source inventory.
Four maintained literal witnesses were added without changing expected counters:

| Entity | Zone | Evidence |
| --- | ---: | --- |
| NPC 269153 | 38 | Own-page location |
| NPC 251428 | 16593 | Explicit zone-row fallback |
| Object 424005 | 406 | Own-page location |
| Object 375548 | 331 | Explicit zone-row fallback |

The report records 1,394 direct NPC zones plus 107 fallback zones, and 21 direct Object
zones plus one fallback. It preserves 207 existing NPC zones and four existing Object
zones. The optional cache used 164 pages and skipped registry exclusions 13649 and 16772.
Four conflicting corroboration cases remain withheld. Full evidence stays in the
hash-identified upstream report; provenance retains the outcome/source/reason summary and
used/skipped page timestamps. Multi-zone selection remains deferred.

All **19 deferred quest questions remain open**. Their per-quest revisit questions were
read; this enrichment provides no new giver, eligibility or client-acceptance evidence
resolving them. No quest was reclassified. Phase 5's runtime-zero policy remains deferred.

### Focused commands

All commands ran sequentially only in the disposable root. `.out/<name>.command`, `.log`
and `.time` record commands, output, exit status, elapsed time and peak RSS;
`.out/results.tsv` is the compact ledger.

| Log | Command | Exit | Seconds | Peak RSS (KiB) |
| --- | --- | ---: | ---: | ---: |
| `00-import-source` | `lua5.1 .out/import-check.lua` | 0 | 2.59 | 219740 |
| `01-audit` | `lua5.1 test.lua correction-audit` | 0 | 41.90 | 46048 |
| `02-source` | `lua5.1 test.lua corrections forever-delta-base native-toc` | 0 | 5.18 | 189820 |
| `03-validators` | `lua5.1 validators/run.lua Forever --self-check` | 0 | 0.59 | 103064 |

- Correction audit: **24 checks**, 81 providers, eight scenarios times 44 personas,
  8,932 calls and 5,088,182 rows; zero failures.
- Correction/import/native-TOC suites: **2,464 checks**, zero failures.
- Gameplay validators: **15/15 clean**, zero findings, baselined, new or fixed;
  fingerprint ownership/count/duplicate Self-check passed. No baseline changed.

Generation, Verification, full Source/Baked Equivalence, Reconstruction, artifact tests
and Baked witnesses were **not rerun**, as authorized for this bounded enrichment. No
artifact was generated. These checks do not establish complete gameplay data or live-client
acceptance. Upstream reports 441 generator tests and Ruff passing; those Python suites
were not rerun for consumer adoption.

### Prepared copy boundary

Only six files differ from the working-byte snapshot: NPC/Object providers, provenance,
the import guide, this appended validation history and the maintained witness test.
`.out/copy-files.json` and `.out/ready-sha256.json` identify the exact reviewed copy set.
No TOC or `.out/` file belongs to it. Parent review and guarded copy remain separate.

| Upstream artifact | SHA-256 |
| --- | --- |
| `foreverBaseItem.lua` | `c6e7ef472fa931fa97fd1ab71b19ee42e0e73ec38d07489b1f672f3454ddd148` |
| `foreverBaseNpc.lua` | `ad738fbb4ffae654657a9c111ead0f1af44f93cc3ede62e313e8ed06e511758f` |
| `foreverBaseObject.lua` | `b3c2790785ec01bfbc7424d62c62356ccde3581a40be70f8072984db807d4776` |
| `foreverBaseQuest.lua` | `0f4dfd18ecb2b4ef123134967741739e7ce50814dd6b836e25f37f1b0939be41` |
| `report.json` | `68b820dbd811f78c3accc43fd1606bf7f9e1cd4462e79476de2116c73abf8d96` |
| `report.md` | `690e86ff8156f5e642953cbec600ee59ee558692c23588db50bdc579331e6d1a` |


## Objective summaries: focused authorized import

Regenerated from generator `f96c1c7` into
`/home/logon/projects/forever-base-db/generated/objectives-text-import/`, using the
same read-only entity snapshots and optional Forever zone cache as the prior import.
Report schema 11; consumer provenance schema 3.

Exactly **707 objective summaries** were added. All 12,368 correction IDs and every
non-text field match the prior import. NPC, Object and Item providers remain
byte-identical, preserving all 1,501 NPC and 22 Object zone assignments.

At the user's explicit request, this import used focused checks, not full artifact
gates. Actual Source getters return all 707 report strings exactly; quest 25's
paragraphs, quest 349's explicit clear and quest 97286's absent summary also pass.
Correction/import/native-TOC suites: **2,464 checks passed**. Gameplay validators:
**15/15 clean, zero findings**, Self-check passed. Fresh wrapper/provenance review
found no issues. Generation of consumer artifacts, Baked verification, Equivalence,
Reconstruction and the full correction audit were **not rerun**.

Only the Quest provider, provenance, guide and this report changed. Working TOCs,
index, existing enum edit and protected untracked files were preserved. No commit
or push. Backups and focused logs: `/tmp/questiedb-text-import-guard.y9phc8h5/`.
The 19 deferred quests remain open; all 20 export holdbacks remain unchanged.
