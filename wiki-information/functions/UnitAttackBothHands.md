## Title: UnitAttackBothHands

**Content:**
Returns information about the unit's melee attacks.
`mainBase, mainMod, offBase, offMod = UnitAttackBothHands(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - Tested with "player" and "target".

**Returns:**
- `mainBase`
  - *number* - The unit's base main hand weapon skill (not rating).
- `mainMod`
  - *number* - Any modifier to the unit's main hand weapon skill (not rating).
- `offBase`
  - *number* - The unit's base offhand weapon skill (not rating) (equal to unarmed weapon skill if unit doesn't dual wield).
- `offMod`
  - *number* - Any modifier to the unit's offhand weapon skill (not rating).