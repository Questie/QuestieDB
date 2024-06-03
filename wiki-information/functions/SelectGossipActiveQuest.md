## Title: SelectGossipActiveQuest

**Content:**
Selects an active quest from a gossip list.
`SelectGossipActiveQuest(index)`

**Parameters:**
- `index`
  - *number* - Index of the active quest to select, from 1 to `GetNumGossipActiveQuests()`; order corresponds to the order of return values from `GetGossipActiveQuests()`.

**Reference:**
`QUEST_PROGRESS` is fired when the details of the quest are available.