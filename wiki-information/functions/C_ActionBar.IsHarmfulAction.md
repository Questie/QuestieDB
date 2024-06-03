## Title: C_ActionBar.IsHarmfulAction

**Content:**
Returns true if the specified action is a harmful one.
`isHarmful = C_ActionBar.IsHarmfulAction(actionID, useNeutral)`

**Parameters:**
- `actionID`
  - *number*
- `useNeutral`
  - *boolean*

**Returns:**
- `isHarmful`
  - *boolean*

**Example Usage:**
This function can be used to determine if an action on the action bar is harmful, which can be useful for addons that need to differentiate between harmful and beneficial actions. For example, an addon that automatically casts spells might use this function to ensure it only casts harmful spells on enemies.

**Addon Usage:**
Large addons like Bartender4, which is a popular action bar replacement addon, might use this function to provide additional customization options for users, such as highlighting harmful actions differently from beneficial ones.