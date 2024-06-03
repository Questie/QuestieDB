## Title: C_PlayerInfo.GUIDIsPlayer

**Content:**
Returns true if the GUID belongs to a player.
`isPlayer = C_PlayerInfo.GUIDIsPlayer(guid)`

**Parameters:**
- `guid`
  - *string* - The GUID to be checked.

**Returns:**
- `isPlayer`
  - *boolean* - True if the GUID represents a player unit, or false if not.

**Description:**
This function currently as of patch 9.0.2 only validates that the supplied GUID begins with the string "Player-".