## Title: GetLFGDungeonInfo

**Content:**
Returns info for a LFG dungeon.
```lua
name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel, isScalingDungeon, lfgMapID = GetLFGDungeonInfo(dungeonID)
```

**Parameters:**
- `dungeonID`
  - *number* : LfgDungeonID

**Returns:**
1. `name`
   - *string* - The name of the dungeon/event
2. `typeID`
   - *number* - 1=TYPEID_DUNGEON or LFR, 2=raid instance, 4=outdoor area, 6=TYPEID_RANDOM_DUNGEON
3. `subtypeID`
   - *number* - 0=Unknown, 1=LFG_SUBTYPEID_DUNGEON, 2=LFG_SUBTYPEID_HEROIC, 3=LFG_SUBTYPEID_RAID, 4=LFG_SUBTYPEID_SCENARIO, 5=LFG_SUBTYPEID_FLEXRAID
4. `minLevel`
   - *number* - Earliest level permitted to walk into the instance portal
5. `maxLevel`
   - *number* - Highest level permitted to walk into the instance portal
6. `recLevel`
   - *number* - Recommended level to queue for this dungeon
7. `minRecLevel`
   - *number* - Earliest level to queue for this dungeon
8. `maxRecLevel`
   - *number* - Highest level to queue for this dungeon
9. `expansionLevel`
   - *number* - Refers to GetAccountExpansionLevel() values
10. `groupID`
    - *number* - Unknown
11. `textureFilename`
    - *string* - For example "Interface\\LFDFRAME\\LFGIcon-%s.blp" where %s is the textureFilename value
12. `difficulty`
    - *number* : DifficultyID
13. `maxPlayers`
    - *number* - Maximum players allowed
14. `description`
    - *string* - Usually empty for most dungeons but events contain descriptions of the event, like Love is in the Air daily or Brewfest, e.g. (string)
15. `isHoliday`
    - *boolean* - If true then this is a holiday event
16. `bonusRepAmount`
    - *number* - Unknown
17. `minPlayers`
    - *number* - Minimum number of players (before the group disbands?); usually nil
18. `isTimeWalker`
    - *boolean* - If true then it's Timewalking Dungeon
19. `name2`
    - *string* - Currently unknown. Note: seems to show the alternative name used by the Instance Lockout interface, as returned by GetSavedInstanceInfo().
20. `minGearLevel`
    - *number* - The minimum average item level to queue for this dungeon; may be 0 if item level is ignored.
21. `isScalingDungeon`
    - *boolean*
22. `lfgMapID`
    - *number* : InstanceID

**Reference:**
- `GetSavedInstanceInfo` - A similar function to this, except for the player's saved dungeon/raid lockout data (does not include Raid Finder)
- `GetSavedWorldBossInfo` - A similar function to this, except for the player's saved world boss lockout data
- `GetRFDungeonInfo` - Almost completely identical; this function uses Raid Finder indexes instead of dungeon IDs
- `GetLFGDungeonEncounterInfo` - A more specific function; this lets you check up on the individual encounters within a given LFG Dungeon