## Title: KBSetup_IsLoaded

**Content:**
Determine if the article list is loaded.
`loaded = KBSetup_IsLoaded()`

**Parameters:**
- `()` - No parameters.

**Returns:**
- `loaded`
  - *boolean* - True if the article list is loaded.

**Usage:**
```lua
function KnowledgeBaseFrame_Search(resetCurrentPage)
  if ( not KBSetup_IsLoaded() ) then
    return;
  end
  -- ...
end
```
From Blizzard's KnowledgeBaseFrame.lua (l. 217 ff.)