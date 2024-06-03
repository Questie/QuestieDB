## Title: UnitIsFriend

**Content:**
Returns true if the specified units are friendly to each other.
`isFriend = UnitIsFriend(unit1, unit2)`

**Parameters:**
- `unit1`
  - *string* : UnitId
- `unit2`
  - *string* : UnitId - The unit to compare with the first unit.

**Returns:**
- `isFriend`
  - *boolean*

**Example Usage:**
This function can be used in a variety of scenarios, such as determining if a player can cast beneficial spells on another unit or if two units are part of the same faction.

**Addons:**
Many large addons, such as HealBot and Grid, use `UnitIsFriend` to determine if a unit is friendly and thus eligible for healing or other beneficial actions.