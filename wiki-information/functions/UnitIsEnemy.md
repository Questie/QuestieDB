## Title: UnitIsEnemy

**Content:**
Returns true if the specified units are hostile to each other.
`isEnemy = UnitIsEnemy(unit1, unit2)`

**Parameters:**
- `unit1`
  - *string* : UnitId
- `unit2`
  - *string* : UnitId - The unit to compare with the first unit.

**Returns:**
- `isEnemy`
  - *boolean*

**Example Usage:**
This function can be used in a PvP addon to determine if a player is targeting an enemy unit. For instance, an addon could use `UnitIsEnemy("player", "target")` to check if the player's current target is an enemy and then display a warning or change the UI accordingly.

**Addons Using This Function:**
Many PvP-oriented addons, such as Gladius, use `UnitIsEnemy` to determine if the units in the arena are enemies and to update the UI elements to reflect the status of the opponents.