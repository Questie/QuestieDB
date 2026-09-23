# Forever coordinate audit

## Scope and result

Audited the local QuestieDB and Questie runtime inputs for Era percentage coordinates that
still need the four known Forever map transforms. The audit started from QuestieDB
`3a1dc8886f85ffddba741cec84e9661c87ed87b1` and Questie
`c24dba53baeebbcbda2c965d2328fd1c3ef3ec35`, including the new coordinate helper working changes.

Two remaining sources were found and corrected:

- Seven Era-framed entrance points in `support/Forever/Zones/dungeons.lua`.
- Six Mulgore Darkmoon Faire NPC points in Questie's
  `Database/Corrections/QuestiePolicy/classicPolicyCorrections.lua`.

No other unconverted Era points in these four zone frames were found in active runtime inputs.
This is a source/frame audit, not live confirmation that landmarks stayed in place. Three
later-expansion entrance entries and six synthetic continent/world points remain unresolved.
Unchanged-map passthrough does not certify unknown coordinates or new Forever content.

## Converted entrances

The Forever-specific table stores the projected literals directly. There is no runtime
conversion of the support table, and the shared Era/legacy table remains unchanged.
Projection uses DBC bounds for `1.15.9.69722` to `1.60.1.69893`, recorded in
`data/Forever/conversion.json`, with two-decimal output as in the converted entity baseline.

| Dungeon entry | Coordinate AreaID | Era point | Forever point |
| --- | ---: | --- | --- |
| Stockade 717 | 1519 | 42.3, 58.9 | 52.41, 70.01 |
| Stratholme 2017, first entrance | 139 | 31.3, 15.7 | 26.52, 10.36 |
| Stratholme 2017, second entrance | 139 | 47.9, 23.9 | 41.45, 17.74 |
| Deeprun Tram 2257, Stormwind entrance | 1519 | 67.6, 4.1 | 71.98, 27.61 |
| Champions' Hall 2918 | 1519 | 72.7, 54 | 75.93, 66.22 |
| Naxxramas 3456 | 139 | 39.9, 25.8 | 34.25, 19.45 |
| Scarlet Enclave 16236 | 139 | 68.67, 87.84 | 60.14, 75.32 |

Use each entrance tuple's AreaID, not the dungeon ID or parent zone. Naxxramas retains
legacy parent 65 while its Era entrance uses EPL 139. The Tram's Ironforge entrance stays
`84.1, 53.1`. No entrance, alternative ID, map-suppression policy or dungeon record was removed.
Scarlet Enclave originated in SoD's Era frame; projecting its retained point does **not**
establish that the raid exists in Forever.

Questie's `ZoneDB:GetDungeonLocation()` returns these provider points to manual icons,
quest starters, finishers, objectives and nearest-entrance distance selection. Correcting the
provider source covers all those consumers without converting their read results again.

## Consumer-owned Darkmoon Faire points

Questie's calendar selects either a fresh Mulgore or Elwynn NPC replacement table.
Only the Mulgore branch on `Questie.IsForever` now calls `LibQuestieDB.EraToForever` before
publishing the rows. Other flavors and Elwynn remain unchanged. Repeated calls start from the
original Era literals, not previous results. The runtime helper retains full precision.

| NPC | Era Mulgore point | Forever point, approximate |
| --- | --- | --- |
| 14828 Gelvas Grimegate | 37.24, 37.67 | 38.095413, 44.606132 |
| 14829 Yebb Neblegear | 37.47, 39.56 | 38.287417, 46.184172 |
| 14832 Kerri Hicks | 37.82, 39.81 | 38.579597, 46.392907 |
| 14833 Chronos | 36.17, 35.15 | 37.202177, 42.502078 |
| 14841 Rinling | 37.09, 37.17 | 37.970193, 44.188661 |
| 14871 Morja | 35.92, 35.27 | 36.993477, 42.602271 |

The duplicate Mulgore literals in `tbcPolicyCorrections.lua` are not loaded or selected by
Forever. They remain TBC inputs. A generic transform in `SetCorrection`, map drawing, or entity
reads would double-convert native Forever data and is intentionally absent.

If the helper is unavailable, Questie returns the original Era rows so calendar initialization
can finish. Each fallback call schedules a visible update-QuestieDB reminder ten seconds
later; the fallback coordinates can be inaccurate on Forever. The helper is loaded by the
committed Source TOC and newly generated Baked TOCs. Regenerate existing Baked TOCs to enable
the accurate conversion.

## Entrances not eligible for the Era transform

The inherited table mixes expansion coordinate frames. Matching a changed AreaID is not enough.
These three entries remain unchanged and explicitly annotated pending their own review:

| Entry | Retained affected point | Source/frame evidence |
| --- | --- | --- |
| DMF Island 5861 | Mulgore 36.85, 35.86 | Questie commit `8b374f8c4` adds the Cata portal with a reference to object 210177; the point matches Cata/MoP object data. |
| Bizmo's Brawlpub 6618 | Stormwind 69.49, 31.2 | Added by MoP commit `76897328b`; the Stormwind point also matches the Cata Tram override. |
| Stratholme Gauntlet 10001 | EPL 43.5, 19.4 | `fd97b762c` places it in the Cata Stratholme override; `b7c1200d9` moves that backdoor point into synthetic entry 10001 for Cata quest fixes. |

By contrast, `64b1519d7` explicitly fixes ordinary Stratholme entrances for SoD/Era;
`7e8e042f7` separates legacy entrances from later overrides, and `4a1576382` updates the Era
Stockade point. `d100f0cff` introduces Scarlet Enclave as a SoD raid.
These are local Questie Git-history references, not live-placement evidence.

Do not silently Era-convert the three deferred points, delete their entries, or assume they
are correct Forever destinations. Later-expansion frame conversion or native Forever evidence
is needed. WotLK/Cata coordinate overrides later in the file do not execute under Forever's
Classic rules.

## Inventory of other coordinate paths

The Questie audit followed the Camelot TOC and XML include graph, then searched numeric and
symbolic map IDs, geographic literals, coordinate assignments, correction writers and render
calls. The resolved graph contained 278 Lua files and 22 XML files with no missing sources.
QuestieDB inputs were traced through the configured Forever entity, support and provider lists.

| Source/category | Disposition |
| --- | --- |
| `data/Forever/*DB.lua`, `src/corrections/Forever/legacy/*.lua` | Already converted. All ten output hashes still matched the manifest before this entrance change. Identity rewriting recognized 140,660 pairs without changing bytes. No second conversion. |
| Authored `src/corrections/Forever/forever*Fixes.lua` | Empty Static/Dynamic tables at audit time; no positions. |
| QuestieDB other Forever support files | IDs, relationships, XP, factions and drops, not additional points. Shared support is not selected for Forever. |
| Other expansion/season providers | Not selected for Forever. Later Cata/MoP/SoD literals are not implicit Forever source points. |
| `src/corrections/enum/waypoints.lua` | Icecrown/Deepholm presets only; the inherited Forever NPC provider does not use them. |
| `src/derived/waypoints.lua` | Simplifies/interpolates already-converted points. Stormwind subdivision scale is a sampling setting, not a position. |
| Questie holidays and event icons | Apart from the six DMF replacements, calendar/quest-ID selection uses provider entity points. |
| Questie other policy writers | Display suppression, prerequisites, strings and item repair; no additional geographic replacement points. |
| Questie `triggerEnd` / `extraObjectives` rendering | Reads converted provider quest fields; no consumer-owned point literals to migrate. |
| Townsfolk, trainers, mailboxes, moonwells, meeting stones | Entity-ID lists or names/ranges. Spawn points come from the provider. Meeting-stone menu returns no entries for Classic/Forever. |
| Journey/search, starter/finisher/objective/manual icons | Provider spawns or dungeon entrances. Do not transform at these shared rendering boundaries. |
| Live player/party/API positions | Already in the current client's frame; never Era-convert. |
| HBD zone geometry | Derived from live `C_Map` bounds. Continent fallback rectangles are world-space bounds, not zone percentages. |
| Map/clustering fallbacks | Normalized `(0.5,0.5)` denotes the current map center; world-coordinate `(0,0)` fallbacks are not Era-authored map points. |
| Minimap geometry, UI offsets/colors | Sizes, shape flags or screen coordinates, not geographic locations. |
| Tests, localization strings, docs and `ExternalScripts(DONOTINCLUDEINRELEASE)` | Not active geographic inputs. |

No additional consumer-owned Redridge coordinate source was found.

The six unresolved converter points on synthetic AreaIDs `10073`, `10074`, `10089` remain
unchanged. They belong to continent/world frames rather than one of the four zone frames.
Their entity IDs and values are listed in the
[adoption gap inventory](forever-data.md#coordinate-results-and-gaps-at-adoption).
Map routing alone cannot establish a transform for them.

## Validation and limits

- Questie full Busted suite: 2,061 successes, no failures or errors.
- Questie focused DMF/correction/event tests: 69 successes; touched files pass luacheck.
- QuestieDB `lua5.1 test.lua forever-data lua-types toc native-toc`: 731 counted checks pass,
  plus native TOC selection and provider-isolation checks. The entrance fixture asserts both
  Stratholme points, the mixed Stormwind/Ironforge route and the deferred non-Era points.
- Coordinate helper tests cover all four maps, ID namespaces, precision, passthrough and sentinels.
- An in-memory integration check loaded the real helper and Questie's DMF producer, verifying all
  six projected points, repeated calls, and unchanged Elwynn/Era output.
- All ten entity/legacy-provider output hashes still match the conversion manifest after the edits.
- Focused independent review found no actionable issues.

No live client, production data, release channel or generated Baked TOC was changed. Offline
projections do not prove landmark placement, content availability or continent-frame alignment.
Check several separated live landmarks per changed map before claiming full spatial accuracy.
