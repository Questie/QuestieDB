## Title: GetRFDungeonInfo

**Content:**
Returns info about a Raid Finder dungeon by index. Limited by player level and other factors, so only Raid Finder dungeons listed in the LFG tool can be looked up.
`ID, name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimewalking, name2, minGearLevel, isScaling, lfgMapID = GetRFDungeonInfo(index)`

**Parameters:**
- `index`
  - *number* - index of a Raid Finder dungeon, from 1 to GetNumRFDungeons()

**Returns:**
- `ID`
  - *number* - Dungeon ID
- `name`
  - *string* - The name of the dungeon/event
- `typeID`
  - *number* - 1=TYPEID_DUNGEON or LFR, 2=raid instance, 4=outdoor area, 6=TYPEID_RANDOM_DUNGEON
- `subtypeID`
  - *number* - 0=Unknown, 1=LFG_SUBTYPEID_DUNGEON, 2=LFG_SUBTYPEID_HEROIC, 3=LFG_SUBTYPEID_RAID, 4=LFG_SUBTYPEID_SCENARIO, 5=LFG_SUBTYPEID_FLEXRAID
- `minLevel`
  - *number* - Earliest level you can enter this dungeon (using the portal, not LFD)
- `maxLevel`
  - *number* - Highest level you can enter this dungeon (using the portal, not LFD)
- `recLevel`
  - *number* - Recommended level to queue up for this dungeon
- `minRecLevel`
  - *number* - Earliest level you can queue up for the dungeon
- `maxRecLevel`
  - *number* - Highest level you can queue up for the dungeon
- `expansionLevel`
  - *number* - Referring to GetAccountExpansionLevel() values
- `groupID`
  - *number* - Unknown
- `textureFilename`
  - *string* - For example "Interface\\LFDFRAME\\LFGIcon-%s.blp" where %s is the textureFilename value
- `difficulty`
  - *number* - 0 for Normal and 1 for Heroic
- `maxPlayers`
  - *number* - Maximum players allowed
- `description`
  - *string* - Usually empty for most dungeons but events contain descriptions of the event, like Love is in the Air daily or Brewfest, e.g. (string)
- `isHoliday`
  - *boolean* - If true then this is a holiday event
- `bonusRepAmount`
  - *number* - Unknown
- `minPlayers`
  - *number* - Minimum number of players (before the group disbands?); usually nil
- `isTimeWalking`
  - *boolean* - If true then it's Timewalking Dungeon
- `name2`
  - *string* - Returns the name of the raid
- `minGearLevel`
  - *number* - The minimum average item level to queue for this dungeon; may be 0 if item level is ignored.
- `isScaling`
  - *boolean*
- `lfgMapID`
  - *number* - InstanceID

**Usage:**
- `/dump GetRFDungeonInfo(1)`
  - `=> 417, "Fall of Deathwing", 1, 3, 85, 85, 85, 85, 85, 3, 0, "FALLOFDEATHWING", 1, 25, "Deathwing must be destroyed, or all is lost.", false, 0, nil, false, "Dragon Soul", 0, false, 967`
- `/dump GetRFDungeonInfo(2)`
  - `=> 416, "The Siege of Wyrmrest Temple", 1, 3, 85, 85, 85, 85, 85, 3, 0, "SIEGEOFWYRMRESTTEMPLE", 1, 25, "Deathwing seeks to destroy Wyrmrest Temple and end the lives of the Dragon Aspects and Thrall.", false, 0, nil, false, "Dragon Soul", 0, false, 967`

**Reference:**
- `GetNumRFDungeons` - Counts of the number of Raid Finder dungeons the player can query with this function
- `GetSavedInstanceInfo` - A similar function to this, except for the player's saved dungeon/raid lockout data (does not include Raid Finder)
- `GetSavedWorldBossInfo` - A similar function to this, except for the player's saved world boss lockout data
- `GetLFGDungeonInfo` - Almost completely identical; this function uses dungeon IDs instead of Raid Finder indexes
- `GetLFGDungeonEncounterInfo` - A more specific function; this lets you check up on the individual encounters within a given LFG Dungeon