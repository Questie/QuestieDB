## Title: GetSavedInstanceEncounterInfo

**Content:**
Returns info about a specific encounter from a saved instance lockout.
`bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex)`

**Parameters:**
- `instanceIndex`
  - *number* - Index from 1 to `GetNumSavedInstances()`
- `encounterIndex`
  - *number* - Index from 1 to the number of encounters in the instance. For multi-part raids, this includes bosses that are not in that raid section, so the first boss in the second wing of a Raid Finder raid could actually have an `encounterIndex` of '4'.

**Returns:**
- `bossName`
  - *string* - The localized name of the encounter in question
- `fileDataID`
  - *number* - The ID number for a texture associated with the encounter, usually an achievement icon. If Blizzard hasn't designated one for the encounter, expect this return to be nil.
- `isKilled`
  - *boolean* - True if you have killed/looted the boss since the last reset period
- `unknown4`
  - *boolean* - Unused by Blizzard, has an unknown purpose, and seems to always be false

**Usage:**
```lua
/dump GetSavedInstanceEncounterInfo(1,1)
-- => "Vigilant Kaathar", nil, true, false
```

**Reference:**
- `GetNumSavedInstances` - Counts number of instances this function applies to
- `GetLFGDungeonEncounterInfo` - A moderately similar function to this one, except it works off of dungeon IDs instead of saved instance indexes
- `GetSavedInstanceInfo` - A more generic function; it allows you to pull up information on the dungeon itself instead of the individual encounters