## Title: KBSetup_GetArticleHeaderData

**Content:**
Returns header information about an article.
`id, title, isHot, isNew = KBSetup_GetArticleHeaderData(index)`

**Parameters:**
- `index`
  - *number* - The article's index for that page.

**Returns:**
- `id`
  - *number* - The article's id.
- `title`
  - *string* - The article's title.
- `isHot`
  - *boolean* - Show the "hot" symbol or not.
- `isNew`
  - *boolean* - Show the "new" symbol or not.

**Usage:**
```lua
local id, title, isHot, isNew = KBSetup_GetArticleHeaderData(1)
if isNew then
  ChatFrame1:AddMessage("The article " .. id .. "(" .. title .. ") is new.", 1.0, 1.0, 1.0)
end
```

**Description:**
This will work on the "most asked" articles, not the articles of the active query.