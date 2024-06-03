## Title: UnitAffectingCombat

**Content:**
Returns true if the unit is in combat.
`affectingCombat = UnitAffectingCombat(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to check.

**Returns:**
- `affectingCombat`
  - *boolean* - Returns true if the unit is in combat or has aggro, false otherwise.

**Description:**
- Returns true when initiating combat.
- Returns true if aggroed, even if the enemy doesn't land a blow.
- For hunters, it returns true shortly after the pet enters combat.
- If using a timed spell such as aimed shot, it returns true when the spell fires (not during charge up).
- Returns to false on death.
- Returns false if the unit being checked for aggro is out of range, or in another zone.
- Returns false if a unit is proximity-aggroed. It won't return true until it either attacks or is attacked.