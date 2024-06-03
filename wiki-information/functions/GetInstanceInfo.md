## Title: GetInstanceInfo

**Content:**
Returns info for the map instance the character is currently in.
`name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()`

**Returns:**
1. `name`
   - *string* - The localized name of the instance—otherwise, the continent name (e.g., Eastern Kingdoms, Kalimdor, Outland, Northrend, Pandaria).
2. `instanceType`
   - *string* - "none" if the player is not in an instance, "scenario" for scenarios, "party" for dungeons, "raid" for raids, "arena" for arenas, and "pvp" for battlegrounds. Many of the following return values will be nil or otherwise useless in the case of "none".
3. `difficultyID`
   - *number* - The DifficultyID of the instance. Will return 0 while not in an instance.
4. `difficultyName`
   - *string* - The localized name for the instance's difficulty ("10 Player", "25 Player (Heroic)", etc.).
5. `maxPlayers`
   - *number* - Maximum number of players permitted within the instance at the same time.
6. `dynamicDifficulty`
   - *number* - The difficulty of dynamic enabled instances. This no longer appears to be used.
7. `isDynamic`
   - *boolean* - If the instance difficulty can be changed while zoned in. This is true for most raids after and including Icecrown Citadel.
8. `instanceID`
   - *number* - The InstanceID for the instance or continent.
9. `instanceGroupSize`
   - *number* - The number of players within your instance group.
10. `LfgDungeonID`
    - *number* - The LfgDungeonID for the current instance group, nil if not in a dungeon finder group.

**Description:**
Related API: `C_Map.GetBestMapForUnit`