## Title: IsPlayerAttacking

**Content:**
Returns if the player is melee attacking the specified unit.
`isAttacking = IsPlayerAttacking(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `isAttacking`
  - *boolean*

**Example Usage:**
This function can be used in a combat addon to check if the player is currently attacking a specific unit. For instance, it can be used to trigger certain abilities or actions only when the player is actively engaged in melee combat with a target.

**Addon Usage:**
Large addons like "WeakAuras" might use this function to create custom triggers for auras or notifications based on whether the player is attacking a specific unit. This can help players optimize their combat performance by providing real-time feedback and alerts.