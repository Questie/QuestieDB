## Title: GetSavedInstanceInfo

**Content:**
Returns instance lock info.
`name, lockoutId, reset, difficultyId, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceId = GetSavedInstanceInfo(index)`

**Parameters:**
- `index`
  - *number* - index of the saved instance, from 1 to `GetNumSavedInstances()`

**Returns:**
1. `name`
   - *string* - the name of the instance
2. `lockoutId`
   - *number* - the ID of the instance lockout
3. `reset`
   - *number* - the number of seconds remaining until the instance resets
4. `difficultyId`
   - *number* : DifficultyID
5. `locked`
   - *boolean* - true if the instance is currently locked, false for a historic entry
6. `extended`
   - *boolean* - shows true if the ID has been extended
7. `instanceIDMostSig`
   - *number* - unknown
8. `isRaid`
   - *boolean* - shows true if it is a raid
9. `maxPlayers`
   - *number* - shows the max players
10. `difficultyName`
    - *string* - shows a localized string i.e. 10 Player (Heroic)
11. `numEncounters`
    - *number* - number of boss encounters in this instance
12. `encounterProgress`
    - *number* - farthest boss encounter in this instance for player
13. `extendDisabled`
    - *boolean* - returns whether this instance cannot be disabled
14. `instanceId`
    - *number* : InstanceID

**Reference:**
- `GetInstanceLockTimeRemaining` - Older, more limited version of this function
- `GetNumSavedInstances` - Counts number of instances this function applies to
- `GetSavedInstanceEncounterInfo` - A more specific function; this lets you check up on the individual encounters within a given saved instance
- `GetSavedWorldBossInfo` - A similar function to this, except for the player's saved world boss lockout data
- `GetLFGDungeonInfo` - A moderately similar function to this function, except it works off of dungeon IDs instead of saved instance indexes. It can also return Raid Finder instance info, unlike this function.
- `GetRFDungeonInfo` - Nearly identical to `GetLFGDungeonInfo`, except it uses Raid Finder indexes instead of dungeon IDs