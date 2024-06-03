## Title: UnitIsFeignDeath

**Content:**
Returns true if the unit (must be a group member) is feigning death.
`isFeign = UnitIsFeignDeath(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `isFeign`
  - *boolean* - Returns true if the checked unit is feigning death, false otherwise.

**Description:**
Only provides valid data for friendly units.
Does not work for the player character. Use `UnitAura` instead:
`isFeign = UnitAura("player", "Feign Death") ~= nil`