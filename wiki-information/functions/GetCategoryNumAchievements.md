## Title: GetCategoryNumAchievements

**Content:**
Returns the number of achievements for a category.
`total, completed, incompleted = GetCategoryNumAchievements(categoryId)`

**Parameters:**
- `categoryId`
  - *number* - Achievement category ID, as returned by GetCategoryList.
- `includeAll`
  - *boolean?* - If true-equivalent, include all achievements, otherwise, only includes those currently visible.

**Returns:**
- `total`
  - *number* - total number of achievements in the specified category.
- `completed`
  - *number* - number of completed achievements in the specified category.
- `incompleted`
  - *number* - number of incompleted achievements in the specified category.

**Usage:**
The snippet below prints the achievement IDs and names of all achievements in the World Events > Midsummer category:
```lua
for i=1, (GetCategoryNumAchievements(161)) do
  local id, name = GetAchievementInfo(161, i)
  print(id, name)
end
```

**Reference:**
- `GetCategoryList`
- `GetAchievementInfo(categoryId, index)`