## Title: C_LFGList.GetAvailableActivityGroups

**Content:**
Returns a list of available LFG groups.
`groups = C_LFGList.GetAvailableActivityGroups(categoryID)`

**Parameters:**
- `categoryID`
  - *number* - The categoryID of the category you want to get available groups of. Use `C_LFGList.GetAvailableCategories()` to get a list of all available categoryIDs.
- `filter`
  - *number?* - Bit mask to filter the results. See `C_LFGList.GetActivityInfo` for more information.

**Returns:**
- `groups`
  - *table* - A table containing the requested groupIDs (not in order).