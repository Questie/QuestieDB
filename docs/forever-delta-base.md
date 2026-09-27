# Forever generated delta-base

`src/corrections/Forever/generated/` imports the offline candidates from
`/home/logon/projects/forever-base-db/generated/`. Only the policy header and module wrapper changed:
`QuestieLoader:CreateModule`, the QuestieDB key import, and a colon `Load()` method.
The correction values and inline entity names and Forever Wowhead URLs are retained.
The upstream `npc.lua`, `object.lua` and `quest.lua` files are imported as
`foreverBaseNpc.lua`, `foreverBaseObject.lua` and `foreverBaseQuest.lua`, with matching
`ForeverBaseNpc`, `ForeverBaseObject` and `ForeverBaseQuest` module names.

## Provenance

[`provenance.json`](../src/corrections/Forever/generated/provenance.json) records SHA-256
hashes of the three upstream Lua files, both upstream reports, the imported Lua files,
the generator, extractor, raw inputs and coordinate-conversion manifest. It also retains
source cache paths, registry metadata, English page counts, field policy and missing references.
Upstream artifact/report hashes identify historical inputs; their earlier integration policy
is not the current target order. SQLite databases were not hashed. The full field-level audit remains in the upstream
`report.json` and `report.md`, identified by their hashes; it is not duplicated here.

The Forever cache is the independent SQLite backup taken on 2026-09-27 at 15:18 UTC,
according to the generator README. Its English coverage is 15,002/15,003 NPCs,
2,056/2,056 objects and 6,150/6,150 quests. NPC 274675 (Nyx) is missing.
The Era comparison cache is separately recorded in the manifest, not a synchronized backup.

| Kind | New | Updated | Relationship support | Total |
| --- | ---: | ---: | ---: | ---: |
| NPC | 2,927 | 468 | 3 | 3,398 |
| Object | 20 | 24 | 8 | 52 |
| Quest | 732 | 40 | 0 | 772 |

There are 4,222 correction rows, 3,679 new IDs and 9,219 reported skips. Both missing
references concern NPC 14242 as starter and finisher of quest 98093; those relationships
were withheld. A skip can describe a field or uncertainty, not necessarily an omitted entity.

## Policy and limitations

The Static order is **raw base -> inherited legacy Corrections -> generated delta-base ->
authored Forever Corrections**. All six legacy providers, including generated reputation and
Item-start sets, precede the dedicated `ForeverDeltaBaseStatic` window (1300). Authored
`forever*Fixes.lua` Static Corrections follow in `ForeverStatic` (1400).
Dynamic Corrections still override all static data. Whole fields replace earlier fields;
reverse relationships are not recursively merged. Generated relationships can replace legacy
lists, and authored Forever replacements can supersede generated links.

The imported fields cover names for missing records, levels, explicit quest starter/finisher
links, reverse NPC/object links, and eligible new-record spawns. Existing names and existing
converted spawns are preserved. New spawns in changed map frames (areas 44, 139, 215 and
1519) are withheld rather than guessed or converted again.

This is not a complete gameplay database. Objectives, objective text, restrictions, chains,
rewards, drops, localization and item generation are outside this import. Missing restrictions
can expose quests too broadly. Missing objectives do not establish correct completion
behavior. Explicit infobox links can themselves be incomplete. New-ID evidence and coordinate
interpretation still depend on the supplied snapshots and need gameplay review.

## Current validation findings

With legacy Static Corrections first, the imported set passes Forever Generation,
Verification, Source/Baked Equivalence (including its Self-proof), Reconstruction and
artifact behavior tests. These checks establish structural and Source/Baked agreement,
not reviewed gameplay correctness. The gameplay validator remains **failing with 648 new
findings**: 626 quests lack `requiredRaces`, 19 starter-link findings affect nine NPCs
(nine missing reverse links and ten reverse links whose quest does not name that starter),
and three missing finisher links affect two NPCs. Twelve of fifteen checks are clean.

The generated fields now supersede legacy fields, but forward and reverse relationships
still disagree after all Corrections. For example, NPC 376's reverse lists omit starters
5631, 5634, 5645 and 5676 and finishers 5640 and 5678; its starter list includes 5641 and
8254 although those quests do not name it as starter. The previous generated-first order
had 640 findings; reordering does not make this partial data complete.
These findings are not accepted into the validation baseline. Restrictions and relationship
reconciliation require separate authored review, not invented defaults or a different
precedence rule.

## Refresh

1. Generate and review a complete upstream run, not a `--limit` sample. Review both reports,
   especially missing references, withheld coordinates and uncertain Era comparisons.
2. Replace only the three generated providers. Adapt their wrappers as above; retain row
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
