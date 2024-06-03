## Title: C_Commentator.GetPlayerFlagInfoByUnit

**Content:**
Needs summary.
`hasFlag = C_Commentator.GetPlayerFlagInfoByUnit(unitToken)`

**Parameters:**
- `unitToken`
  - *string* : UnitId

**Returns:**
- `hasFlag`
  - *boolean*

**Description:**
This function checks if a player, identified by the `unitToken`, has a flag in a battleground or similar context. It returns `true` if the player has the flag, and `false` otherwise.

**Example Usage:**
This function can be used in addons that track player status in battlegrounds, such as determining if a player is carrying the flag in Warsong Gulch.

**Addons:**
Large PvP-oriented addons like "BattlegroundTargets" might use this function to provide real-time information about flag carriers to players.