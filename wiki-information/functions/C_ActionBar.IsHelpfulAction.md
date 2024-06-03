## Title: C_ActionBar.IsHelpfulAction

**Content:**
Returns true if the specified action is a helpful one.
`isHelpful = C_ActionBar.IsHelpfulAction(actionID, useNeutral)`

**Parameters:**
- `actionID`
  - *number*
- `useNeutral`
  - *boolean*

**Returns:**
- `isHelpful`
  - *boolean*

**Example Usage:**
This function can be used to determine if an action (such as a spell or ability) is beneficial, which can be useful for addons that manage action bars or automate certain actions based on the type of ability.

**Addon Usage:**
Large addons like Bartender4, which is a popular action bar replacement addon, might use this function to categorize and display helpful actions differently from harmful ones. This helps in organizing the action bars more effectively based on the type of action.