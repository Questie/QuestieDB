## Title: KBSetup_GetTotalArticleCount

**Content:**
Returns the number of articles.
`count = KBSetup_GetTotalArticleCount()`

**Parameters:**
- `()` 

**Returns:**
- `count`
  - *number* - The number of articles.

**Usage:**
```lua
local count = KBSetup_GetTotalArticleCount()
for i = 1, count do
  -- do something with the article
end
```

**Description:**
This will count the "most asked" articles, not the number of articles for the active query.