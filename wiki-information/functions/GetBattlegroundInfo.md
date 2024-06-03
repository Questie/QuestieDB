## Title: GetBattlegroundInfo

**Content:**
Returns information about a battleground type.
`name, canEnter, isHoliday, isRandom, battleGroundID, info = GetBattlegroundInfo(index)`

**Parameters:**
- `index`
  - *number* - battleground type index, 1 to `GetNumBattlegroundTypes()`.

**Returns:**
- `localizedName`
  - *string* - Localized battleground name.
- `canEnter`
  - *boolean* - `true` if the player can queue for this battleground, `false` otherwise.
- `isHoliday`
  - *boolean* - `true` if this battleground is currently granting bonus honor due to a battleground holiday, `false` otherwise.
- `isRandom`
  - *boolean* - `true` if this battleground is the random.
- `battleGroundID`
  - *number* - the ID associated with the Battleground. See `BattlemasterList.db2` for full list.
- `mapDescription`
  - *string* - Localized information about the battleground map.
- `bgInstanceID`
  - *number* - InstanceID of the battleground map.
- `maxPlayers`
  - *number* - Maximum number of players allowed in the battleground.
- `gameType`
  - *string* - Type of the game (e.g., "CTF" for Capture the Flag). Empty string if none.
- `iconTexture`
  - *number* - Path to the icon texture representing the battleground.
- `shortDescription`
  - *string* - Short description of the battleground.
- `longDescription`
  - *string* - Long description of the battleground.
- `hasControllingHoliday`
  - *number* - `1` if there's a controlling holiday for the battleground, `0` otherwise.