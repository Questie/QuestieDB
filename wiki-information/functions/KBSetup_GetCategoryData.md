## Title: KBSetup_GetCategoryData

**Content:**
Returns information about a category.
`id, caption = KBSetup_GetCategoryData(index)`

**Parameters:**
- `index`
  - *number* - Range from 1 to `KBSetup_GetCategoryCount()`

**Returns:**
- `id`
  - *number* - The category's id.
- `caption`
  - *string* - The category caption.

**Description:**
Seems to only work if `KBSetup_IsLoaded()` returns true.