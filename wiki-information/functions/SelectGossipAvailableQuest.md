## Title: SelectGossipAvailableQuest

**Content:**
Selects an available quest from a gossip list.
`SelectGossipAvailableQuest(index)`

**Parameters:**
- `index`
  - *number* - Index of the available quest to select, from 1 to `GetNumGossipAvailableQuests()`; order corresponds to the order of return values from `GetGossipAvailableQuests()`.

**Reference:**
`QUEST_PROGRESS` is fired when the details of the quest are available.