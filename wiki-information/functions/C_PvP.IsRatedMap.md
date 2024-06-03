## Title: C_PvP.IsRatedMap

**Content:**
Returns if the map is a rated battleground or arena.
`isRatedMap = C_PvP.IsRatedMap()`

**Returns:**
- `isRatedMap`
  - *boolean*

**Example Usage:**
This function can be used to determine if the current map is a rated battleground or arena, which can be useful for addons that track player performance or provide specific features for rated PvP environments.

**Addons:**
Many PvP-oriented addons, such as Gladius, use this function to adjust their behavior based on whether the player is in a rated match. For example, they might display additional statistics or enable certain features only in rated environments.