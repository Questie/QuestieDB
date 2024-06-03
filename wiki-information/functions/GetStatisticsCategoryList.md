## Title: GetStatisticsCategoryList

**Content:**
Returns the list of statistic categories.
`categories = GetStatisticsCategoryList()`

**Returns:**
- `categories`
  - *table* - list of all the categories

**Usage:**
The snippet below prints info about the category IDs.
```lua
local categories = GetStatisticsCategoryList()
for i, id in next(categories) do
  local key, parent = GetCategoryInfo(id)
  print("The key %d has the parent %d", key, parent)
end
```