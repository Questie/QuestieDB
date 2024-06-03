## Title: IsAttackAction

**Content:**
Returns true if an action is the "Auto Attack" action.
`isAttack = IsAttackAction(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - The action slot to test.

**Returns:**
- `isAttack`
  - *Flag* - `nil` if the specified slot is not an attack action, or is empty. `1` if the slot is an attack action and should flash red during combat.