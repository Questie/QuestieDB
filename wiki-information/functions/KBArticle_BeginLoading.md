## Title: KBArticle_BeginLoading

**Content:**
Starts the article load process.
`KBArticle_BeginLoading(id, searchType)`

**Parameters:**
- `(id, searchType)`
  - `id`
    - *number* - The article's ID
  - `searchType`
    - *number* - Search type for the loading process.

**Returns:**
- `nil`

**Description:**
The `searchType` can be either 1 or 2. 1 is used if the search text is empty, 2 otherwise.

**Usage:**
```lua
function KnowledgeBaseArticleListItem_OnClick()
  local searchText = KnowledgeBaseFrameEditBox:GetText();
  local searchType = 2;
  if (searchText == KBASE_DEFAULT_SEARCH_TEXT or searchText == "") then
    searchType = 1;
  end
  KBArticle_BeginLoading(this.articleId, searchType);
end
```
From Blizzard's KnowledgeBaseFrame.lua (l. 529 ff.)