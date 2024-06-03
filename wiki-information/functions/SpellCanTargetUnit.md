## Title: SpellCanTargetUnit

**Content:**
Returns true if the spell awaiting target selection can be cast on the unit.
`canTarget = SpellCanTargetUnit(unitId)`

**Parameters:**
- `unitId`
  - *string (UnitId)* - The unit to check.

**Returns:**
- `canTarget`
  - *boolean* - Whether the spell can target the given unit.

**Description:**
This will check for range, but not for LOS (Line of Sight).