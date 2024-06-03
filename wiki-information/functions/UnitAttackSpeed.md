## Title: UnitAttackSpeed

**Content:**
Returns the unit's melee attack speed for each hand.
`mainSpeed, offSpeed = UnitAttackSpeed(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to get information from. (Verified for "player" and "target")

**Returns:**
- `mainSpeed`
  - *number* - The unit's base main hand attack speed (seconds)
- `offSpeed`
  - *number* - The unit's offhand attack speed (seconds) - nil if the unit has no offhand weapon.