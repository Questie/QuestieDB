## Title: C_RaidLocks.IsEncounterComplete

**Content:**
Needs summary.
`encounterIsComplete = C_RaidLocks.IsEncounterComplete(mapID, encounterID)`

**Parameters:**
- `mapID`
  - *number* : UiMapID
- `encounterID`
  - *number* : JournalEncounterID
- `difficultyID`
  - *number?* : DifficultyID

**Returns:**
- `encounterIsComplete`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific encounter within a raid instance has been completed. This is particularly useful for raid tracking addons or for players who want to ensure they have completed all encounters in a raid for the week.

**Addons:**
Large addons like "DBM (Deadly Boss Mods)" or "BigWigs" might use this function to track encounter completions and provide alerts or updates to the player.