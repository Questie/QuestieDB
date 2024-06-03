## Title: GetLFGDungeonEncounterInfo

**Content:**
Returns info about a specific encounter in an LFG/RF dungeon.
`bossName, texture, isKilled, unknown4 = GetLFGDungeonEncounterInfo(dungeonID, encounterIndex)`

**Parameters:**
- `dungeonID`
  - *number* - Ranging from 1 to around 2000 in patch 8.1.5
- `encounterIndex`
  - *number* - Index from 1 to `GetLFGDungeonNumEncounters()`. For multi-part raids, many bosses will never be accessible to players because they were in an earlier 'wing'.

**Returns:**
- `bossName`
  - *string* - The localized name of the encounter in question
- `texture`
  - *string* - The file path for a texture associated with the encounter, usually an achievement icon. If Blizzard hasn't designated one for the encounter, expect this return to be nil.
- `isKilled`
  - *boolean* - True if you have killed/looted the boss since the last reset period
- `unknown4`
  - *boolean* - Unused by Blizzard, has an unknown purpose, and seems to always be false

**Usage:**
```lua
/dump GetLFGDungeonEncounterInfo(610,1)
-- => "Jin'rokh the Breaker", nil, true, false
```

**Reference:**
- `GetSavedInstanceEncounterInfo` - A moderately similar function to this one, except it works off of saved instance indexes instead of dungeon IDs.
- `GetLFGDungeonInfo` - A more generic function; it allows you to pull up information on the dungeon itself instead of the individual encounters.