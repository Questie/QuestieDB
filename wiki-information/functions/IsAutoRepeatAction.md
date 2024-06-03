## Title: IsAutoRepeatAction

**Content:**
Returns true if an action is currently auto-repeating (e.g. Shoot for wand and Auto Shot for Hunters).
`isRepeating = IsAutoRepeatAction(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - The action slot to query.

**Returns:**
- `isRepeating`
  - *boolean* - true if the action in the slot is currently auto-repeating, false if it is not auto-repeating or the slot is empty.

**Reference:**
- `IsAutoRepeatSpell`

**Example Usage:**
This function can be used to check if a Hunter's Auto Shot or a Mage's wand attack is currently active. For instance, an addon could use this to display an indicator when auto-repeating actions are active.

**Addon Usage:**
Large addons like WeakAuras might use this function to create custom alerts or visual effects when auto-repeating actions are active, enhancing the player's awareness during combat.