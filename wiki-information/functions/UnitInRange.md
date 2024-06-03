## Title: UnitInRange

**Content:**
Returns true if the unit is within 40 yards range (25 yards for Evokers).
`inRange, checkedRange = UnitInRange(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `inRange`
  - *boolean* - true if the unit is within 40 (25 for Evokers) yards of the player
- `checkedRange`
  - *boolean* - true if a range check was actually performed; false if the information about distance to the queried unit is unavailable.

**Note:**
UnitInRange("player") will return false, false outside of a group.