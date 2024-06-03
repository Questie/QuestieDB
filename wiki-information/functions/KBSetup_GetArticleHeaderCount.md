## Title: KBSetup_GetArticleHeaderCount

**Content:**
Returns the number of articles for the current page.
`count = KBSetup_GetArticleHeaderCount()`

**Parameters:**
- `()`

**Returns:**
- `count`
  - *number* - The number of articles for the current page.

**Usage:**
```lua
local count = KBSetup_GetArticleHeaderCount()
for i = 1, count do
  -- do something with the article
end
```

**Description:**
This will count the "most asked" articles, not the number of articles for the active query.