## Title: ActionHasRange

**Content:**
Returns true if the action has a range requirement.
`hasRange = ActionHasRange(slotID)`

**Parameters:**
- `slotID`
  - *number* - The slot ID to test.

**Returns:**
- `hasRange`
  - *boolean* - True if the specified slot contains an action which has a numeric range requirement.

**Description:**
This function returns true if the action in the specified slot ID has a numeric range requirement as shown in the action's tooltip, e.g., has a numeric range of 20 yards. For actions like Attack which have no numeric range requirement in their tooltip (even though they only work within a certain range), this function will return false.