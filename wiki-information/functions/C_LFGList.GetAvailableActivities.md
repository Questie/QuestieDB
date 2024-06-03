## Title: C_LFGList.GetAvailableActivities

**Content:**
Returns a list of available LFG activities.
`activities = C_LFGList.GetAvailableActivities()`

**Parameters:**
- `categoryID`
  - *number?* - Use to only get activityIDs associated with a specific category. Use `C_LFGList.GetAvailableCategories()` to get a list of all available categoryIDs. If omitted, the function returns activities of all categories.
- `groupID`
  - *number?* - Use to only get activityIDs associated with a specific group. See `C_LFGList.GetActivityGroupInfo` for more information. If omitted, the function returns activities of all groups.
- `filter`
  - *number?* - Bit mask to filter the results. See `C_LFGList.GetActivityInfo` for more information.

**Returns:**
- `activities`
  - *table* - A table containing the requested activityIDs (not in order).