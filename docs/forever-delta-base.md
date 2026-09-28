# Forever generated delta-base

`src/corrections/Forever/generated/` imports the offline candidates from
`/home/logon/projects/forever-base-db/generated/`. Only the policy header and module wrapper changed:
`QuestieLoader:CreateModule`, the QuestieDB key import, and a colon `Load()` method.
The correction values and inline entity names and Forever Wowhead URLs are retained.
Starter/finisher groups use positional tables, such as `{{211022, 211033}}` or
`{nil, {424005}}`, including add/remove operands. Spawn maps keep explicit zone keys.
This formatting refresh preserves every decoded correction value from the previous import.
The four upstream files retain their names: `foreverBaseNpc.lua`,
`foreverBaseObject.lua`, `foreverBaseQuest.lua` and `foreverBaseItem.lua`, with matching
`ForeverBaseNpc`, `ForeverBaseObject`, `ForeverBaseQuest` and `ForeverBaseItem` modules.

## Provenance

[`provenance.json`](../src/corrections/Forever/generated/provenance.json) records SHA-256
hashes of the four upstream Lua files, both upstream reports, the imported Lua files,
the generator, extractor, raw inputs and coordinate-conversion manifest. It also retains
source cache paths, registry metadata, English page counts, field policy, effective-baseline
inputs and missing-reference counts. SQLite databases were not hashed. The full field-level
audit and missing-reference list remain in upstream `report.json` and `report.md`, identified
by their hashes rather than duplicated here.

All recorded effective-baseline input hashes matched at this import, including raw data,
legacy providers, registration and runtime files. Imported values are also checked with the
current runtime rather than relying solely on those hashes.

The Forever cache is the independent SQLite backup refreshed on 2026-09-27 at 17:35 UTC
while scraping continued. Its English coverage is 29,195/29,195 items, 15,003/15,003 NPCs,
2,056/2,056 objects and 6,150/6,150 quests, all fresh against cached sitemap timestamps.
The Era comparison cache is separately recorded in the manifest, not a synchronized backup.

| Kind | New | Updated | Relationship support | Total |
| --- | ---: | ---: | ---: | ---: |
| NPC | 2,928 | 463 | 3 | 3,394 |
| Object | 20 | 24 | 8 | 52 |
| Quest | 732 | 26 | 0 | 758 |
| Item | 5,632 | 2,525 | 0 | 8,157 |

There are 12,361 correction rows, 9,312 new IDs and 17,610 reported skips. The report lists
478 unresolved references: 397 NPC, 36 object, 43 quest and two item references. Quest giver
links with unresolved endpoints are withheld; item source references are retained and
reported rather than silently pruned. A skip can describe a field or uncertainty, not
necessarily an omitted entity.

## Policy and limitations

The Static order is **raw base -> inherited legacy Corrections -> generated delta-base ->
authored Forever Corrections**. All six legacy providers, including generated reputation and
Item-start sets, precede the dedicated `ForeverDeltaBaseStatic` window (1300). Authored
`forever*Fixes.lua` Static Corrections follow in `ForeverStatic` (1400).
Dynamic Corrections still override all static data. Ordinary table fields initialize new
records or absent/empty fields in the effective raw-plus-legacy baseline. Populated fields
use `_add`/`_remove`, including when adding a new group alongside existing groups.
This snapshot contains 5,416 table initializations, 765 `_add` fields and no justified
`_remove` fields. Uncertain removals are report-only. Scalars remain replacements, and
authored Forever corrections can still override generated values.

The imported fields cover names for missing records, levels, explicit quest starter/finisher
links, inverse NPC/object links, eligible new-record spawns, and item categories, drop-source
IDs, vendors, quest relationships and explicit quest starters. Redundant memberships and
item relationships already represented by existing quest objectives are omitted. Existing
names and converted spawns are preserved. New spawns in changed map frames (areas 44, 139,
215 and 1519) are withheld rather than guessed or converted again. Item tabs with 200 or more
rows are withheld because Wowhead can cap source lists.

This is not a complete gameplay database. Objectives, objective text, restrictions, chains,
quest reward payloads, drop rates, detailed item stats and localization are outside this import. Missing restrictions
can expose quests too broadly. Missing objectives do not establish correct completion
behavior. Explicit infobox links can themselves be incomplete. New-ID evidence and coordinate
interpretation still depend on the supplied snapshots and need gameplay review.

## Validation status

This refresh checks imported provider values against their upstream tables and the previous
import, Source witnesses for all four entity types, native selection, Static precedence and
the correction-provider audit. No Baked artifacts are regenerated in the working checkout.

After the master rebase, a disposable run passed Forever Generation, Verification,
Source/Baked Equivalence, Reconstruction and artifact tests. Gameplay validation failed on
625 quests missing `requiredRaces`; the other 14 checks were clean. This formatting-only
refresh does not resolve those findings. They are not accepted into the validation baseline.
The unresolved source references above also remain review work.

### Previous three-provider import

The earlier import passed Forever Generation, Verification, Source/Baked Equivalence
(including its Self-proof), Reconstruction and artifact behavior tests. Those results are
historical, not validation of this four-provider refresh. Its gameplay validator failed with
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

## Refresh

1. Generate and review a complete upstream run, not a `--limit` sample. Review both reports,
   especially missing references, withheld coordinates and uncertain Era comparisons.
2. Replace only the four generated providers. Adapt their wrappers as above; retain row
   values and inline evidence. Never copy candidates into `legacy/`, `forever*Fixes.lua`,
   or conversion-protected raw files.
3. Update the small provenance manifest and this count/gap summary. Compare the imported
   `Load()` tables with the upstream `Load(keys)` tables using the same schema keys.
4. Run `lua5.1 test.lua corrections forever-delta-base` and the native Source-selection suite
   (`lua5.1 test.lua native-toc`). Generate and check only Forever in a disposable copy,
   including `lua5.1 test.lua --flavor=Forever`. Report validation findings; do not change
   baselines to hide unsupported or incomplete imported data.

Static-only generated providers are present in Source mode and folded into Generation.
Baked file lists omit them. Neither Generation nor client loading needs the external generator,
SQLite caches, scraper checkout or upstream reports.
