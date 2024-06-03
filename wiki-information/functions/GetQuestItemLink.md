## Title: GetQuestItemLink

**Content:**
Returns the item link for a required/reward/choice quest item.
`itemLink = GetQuestItemLink(type, index)`

**Parameters:**
- `(String "type", Integer index)`
  - `type`
    - *string* - "required", "reward" or "choice"
  - `index`
    - *number* - Quest reward item index.

**Returns:**
- `itemLink`
  - *string* - The link to the quest item specified.

**Usage:**
```lua
local link = GetQuestItemLink("choice", 1);
local link = GetQuestItemLink("choice", 1);
```

**Miscellaneous:**
Result:
```
|cff9d9d9d|Hitem:7073:0:0:0:0:0:0:0|h|h|r
```
Last updated: Patch 1.6.1