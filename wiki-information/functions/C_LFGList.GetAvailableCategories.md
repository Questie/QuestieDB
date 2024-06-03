## Title: C_LFGList.GetAvailableCategories

**Content:**
Returns a list of available LFG categories.
`categories = C_LFGList.GetAvailableCategories()`

**Parameters:**
- `filter`
  - *number?* - Bit mask to filter the results. If omitted the function returns all categories. See `C_LFGList.GetActivityInfo` for more information.

**Returns:**
- `categories`
  - *table* - A table containing the requested categoryIDs (not in order).