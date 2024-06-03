## Title: KBSetup_BeginLoading

**Content:**
Starts the loading of articles.
`KBSetup_BeginLoading(articlesPerPage, currentPage)`

**Parameters:**
- `articlesPerPage`
  - *number* - Number of articles shown on one page.
- `currentPage`
  - *number* - The current page (starts at 1).

**Returns:**
- `nil`

**Usage:**
In `KnowledgeBaseFrame_OnShow()`:
```lua
KBSetup_BeginLoading(KBASE_NUM_ARTICLES_PER_PAGE, KBASE_CURRENT_PAGE)
```
From Blizzard's `KnowledgeBaseFrame.lua` (l. 51)

**Description:**
This will start the article loading process and return immediately.
When all articles are loaded, the event `KNOWLEDGE_BASE_SETUP_LOAD_SUCCESS` is fired.
If an error occurs in the loading process, the event `KNOWLEDGE_BASE_SETUP_LOAD_FAILURE` is fired.