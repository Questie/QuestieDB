## Title: IsActionInRange

**Content:**
Returns true if the specified action is in range.
`inRange = IsActionInRange(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - The action slot to test.

**Returns:**
- `inRange`
  - *boolean* - `nil` if the slot has no action, or if the action cannot be used on the current target, or if range does not apply; `false` if the action is out of range, and `true` otherwise.

**Reference:**
- `IsSpellInRange`
- `IsItemInRange`
- `CheckInteractDistance`
- `ActionHasRange`

**Example Usage:**
This function can be used in macros or addons to determine if a specific action (like a spell or ability) can be used on the current target. For instance, an addon could use this to display a warning if the player is out of range for their primary attack.

**Addons:**
Many combat-related addons, such as WeakAuras and Bartender4, use this function to provide feedback on action availability and range. For example, WeakAuras might use it to trigger visual alerts when an ability is out of range.