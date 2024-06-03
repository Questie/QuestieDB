## Title: C_LFGList.GetCategoryInfo

**Content:**
Returns information about a specific category. Each category can contain many activity groups, which can contain many activities.
`name, separateRecommended, autoChoose, preferCurrentArea = C_LFGList.GetCategoryInfo(categoryID)`

**Parameters:**
- `categoryID`
  - *number* - The categoryID of the category you want to query. Use `C_LFGList.GetAvailableCategories()` to get a list of all available categoryIDs.

**Returns:**
- `name`
  - *string* - The name of the category.
- `separateRecommended`
  - *boolean*
- `autoChoose`
  - *boolean*
- `preferCurrentArea`
  - *boolean*