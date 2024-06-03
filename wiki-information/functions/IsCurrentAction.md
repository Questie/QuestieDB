## Title: IsCurrentAction

**Content:**
Returns true if the specified action is currently being used.
`isCurrent = IsCurrentAction(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - action slot ID to query.

**Returns:**
- `isCurrent`
  - *boolean* - 1 if the action in the slot is currently executing, nil otherwise.

**Example Usage:**
This function can be used to check if a specific action (like a spell or ability) is currently being executed by the player. For instance, it can be useful in creating custom action bar addons to highlight or indicate the currently active action.

**Addon Usage:**
Many action bar addons, such as Bartender4 and Dominos, use this function to manage and display the state of action buttons, ensuring that the user interface accurately reflects the player's current actions.