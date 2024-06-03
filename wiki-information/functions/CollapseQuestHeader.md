## Title: ExpandQuestHeader

**Content:**
Expands/collapses a quest log header.
`ExpandQuestHeader(index)`
`CollapseQuestHeader(index)`

**Parameters:**
- `index`
  - *number* - Position in the quest log from 1 at the top, including collapsed and invisible content.
- `isAuto`
  - *boolean* - Used when resetting the quest log to a default state.

**Description:**
Applies to all headers when the index does not point to a header, including out-of-range values like 0.
Fires `QUEST_LOG_UPDATE`. Toggle `QuestMapFrame.ignoreQuestLogUpdate` to suppress the normal event handler.

**Usage:**
Expand all quest headers:
```lua
ExpandQuestHeader(0)
```
Collapse the first quest header (always at position 1) while suppressing the normal event handler:
```lua
QuestMapFrame.ignoreQuestLogUpdate = true
CollapseQuestHeader(1)
QuestMapFrame.ignoreQuestLogUpdate = nil
```

**Reference:**
`QuestMapFrame_ResetFilters()` - FrameXML function to restore the default expanded/collapsed state.