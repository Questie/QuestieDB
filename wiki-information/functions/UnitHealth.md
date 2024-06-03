## Title: UnitHealth

**Content:**
Returns the current health of the unit.
`health = UnitHealth(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken
- `usePredicted`
  - *boolean?* = true

**Returns:**
- `health`
  - *number* - Returns 0 if the unit is dead or does not exist.

**Description:**
Related Events:
- `UNIT_HEALTH`

Available after:
- `PLAYER_ENTERING_WORLD` (on login)

**Reference:**
- Kaivax 2020-02-18. UI API Change for UnitHealth.