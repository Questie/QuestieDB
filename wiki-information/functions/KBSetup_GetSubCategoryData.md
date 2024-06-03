## Title: KBSetup_GetSubCategoryData

**Content:**
Returns information about a subcategory.
`id, caption = KBSetup_GetSubCategoryData(category, index)`

**Parameters:**
- `(category, index)`
  - `category`
    - *Integer* - The category's index.
  - `index`
    - *number* - Range from 1 to `KBSetup_GetSubCategoryCount(category)`

**Returns:**
- `id, caption`
  - `id`
    - *number* - The category's id.
  - `caption`
    - *string* - The category caption.

**Description:**
Only works if `KBSetup_IsLoaded()` returns true.