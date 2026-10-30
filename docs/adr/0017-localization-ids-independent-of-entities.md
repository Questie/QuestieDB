# 17. Localization IDs independent of baked entity membership

Date: 2026-10-17. Status: accepted.

## Context

Generation filtered lookup translations against the baked entity ID list, and the read overlay
resolved column positions from the same list. An entity a Dynamic Correction adds is absent from
the baked database by construction, so its lookup translation was discarded at Generation and
had no position to be read from — even when `l10n/` already carried the text. Titan Reforged
worked around this by copying ordinary lookup rows into a runtime Dynamic Translation Correction
(PR #67), which duplicates maintained data in a second table and does not generalize.

ADR 0011 chose columns indexed by the entity ID list specifically so a Correction-added entity
could not pick up an accidental Base translation. That storage decision is what this record
changes; ADR 0013's read precedence, and the rule that a translation cannot make an entity
exist, both stay in force.

## Decisions

### 1. Localization owns one ascending ID list per entity type

`X-l10nIds-<Type>` holds base64 of zlib-compressed deterministic CBOR — the same encoding as an
entity `IDS` header. It lists every ID any locale translates for that type, including IDs the
baked entity database lacks. Columns index this list. One list serves all nine locale columns of
its type, so it is stored once rather than repeated per locale.

The key is spelled `l10nIds`, not `l10n-IDS`, so it cannot match the locale-block pattern
`^X%-l10n%-%a+%-%a+$`. Every existing "is this a localization block?" scan stays correct with no
change, and no second key predicate is needed.

The list is decoded when a stored locale is loaded, so a missing or corrupt list fails the locale
switch atomically. enUS loads no blocks and therefore decodes no list, and the lists are released
when the effective locale becomes enUS — an enUS client retains no localization at all.

### 2. Retention is by translation membership, not entity membership

`l10n.extract` no longer takes a `knownIds` filter. Generation retains every translated ID that
the flavor's applicable localization sources provide, which is what makes the fix general rather
than a list of extra IDs to maintain. Static Translation Corrections still fold in and still
clear fields with `false`.

### 3. A translation still cannot create an entity

Storage membership and runtime existence are separate questions. The provider resolves a stored
translation only while `entity.Exists(id)` holds in the composed runtime database — the union of
backend IDs and overlay-added IDs. An ID present in the localization list but in neither reads
`nil` for every field, exactly like any other unknown ID, and a seasonal-only entity stays
invisible on an inactive season. Dynamic addition and withdrawal continue to control existence
on their own.

This gate also covers the Dynamic translation layer, which previously checked existence only
there. Positions no longer come from the entity ID list, so nothing else implies existence.

### 4. The format version moves to 2

`X-l10n-Version: 2` declares the new layout, because a column position changed meaning. The two
layouts are incompatible in both directions, so they must not share a version number.

Both failure modes below are what happens **if both layouts declare the same version**, which is
the state this decision prevents. Each was reproduced with version 1 on both sides:

- an older reader given a version-2 artifact passes the header check and then indexes the new
  columns with baked entity IDs. With this branch's Vanilla artifact, Npc `name` for 30 in deDE
  returned `Rohling der Defias` instead of `Waldspinne`, and item 159 returned `Garricks Kopf`
  instead of `Erfrischendes Quellwasser` — a wrong translation, silently.
- this reader given a version-1 artifact had no ID list to index with, and a non-English
  startup aborted with `missing localization ID list X-l10nIds-Quest`.

With the versions distinct, neither pairing reaches those paths: a version-1 reader rejects a
version-2 artifact at its existing header comparison, and this reader declines a version-1
artifact before it needs an ID list, reading base English instead. A mixed-version test asserts
both directions.

Entity storage is untouched and keeps its contract version; only the localization block layout
changed.

## Consequences

Generation retains translations for IDs the baked database does not contain, so a Dynamic
Correction's entity resolves its lookup translation without a duplicated runtime table.

Measured offline against the shipped reader, comparing the pre-change artifact with the new
layout for the same inputs:

| Artifact | Total | l10n blocks | l10n ID lists | deDE decoded blocks | deDE decoded ID lists |
| --- | --- | --- | --- | --- | --- |
| Vanilla, before | 12.42 MB | 4.11 MB | — | 2.83 MB | — |
| Vanilla, after | 13.49 MB | 4.98 MB | 176.0 KB (1.3%) | 3.39 MB | 1.41 MB |
| Wrath, after | 28.86 MB | 10.29 MB | 272.2 KB (0.9%) | 6.66 MB | 2.81 MB |

Retained localization IDs per artifact, and how many the baked entity database lacks:

| Flavor | Quest | Npc | Item | Object | Total extra |
| --- | --- | --- | --- | --- | --- |
| Vanilla | 117 | 6,992 | 8,340 | 6,040 | 21,489 |
| Wrath | 263 | 6 | 494 | 5,691 | 6,454 |

The ID lists themselves are 0.9-1.3% of the artifact; most of the growth is the retained
translations, which is the point of the change. The decoded ID lists are the notable runtime
cost — about 1.4 MB on Vanilla and 2.8 MB on Wrath for the active locale, retained for the
session. They are released when the effective locale becomes enUS, so an enUS client still
retains no localization at all.

The localization ID list is neither a subset nor a superset of the entity ID list: it carries
IDs the baked database lacks, and omits baked IDs no locale translates.

The 58 Titan Reforged rows that are byte-identical to the owned zhCN lookup are now redundant in
both modes — the test suite proves all 48 Quest rows still resolve after the runtime slot is
withdrawn, from the stored Baked blocks and from Source mode's own lookups. They are kept;
removing them is a separate decision. The genuine seasonal overrides — the 18 quests and 2
remapped items whose text differs from the lookup — stay regardless.
