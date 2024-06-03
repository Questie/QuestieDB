## Title: UnitIsPlayer

**Content:**
Returns true if the unit is a player character.
`isPlayer = UnitIsPlayer(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `isPlayer`
  - *boolean* - true if the unit is a player, false otherwise.

**Example Usage:**
This function can be used in addons to check if a target or focus is a player. For instance, in a PvP addon, you might want to display different information if the target is a player versus an NPC.

**Addons Using This Function:**
Many large addons, such as "Recount" and "Details! Damage Meter," use this function to differentiate between player and NPC units when tracking combat statistics.