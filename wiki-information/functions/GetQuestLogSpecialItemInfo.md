## Title: GetQuestLogSpecialItemInfo

**Content:**
Returns information about a special quest item based on a given index.
`link, item, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(questLogIndex)`

**Parameters:**
- `questLogIndex`
  - *number* - The index of the quest to query. The number of quests can be retrieved with `GetNumQuestLogEntries()`.

**Returns:**
- `link`
  - *string?* - ItemLink
- `item`
  - *number* - The icon ID
- `charges`
  - *number* - The number of charges, or 0 if unlimited. If the item is consumed on use this seems to be -1 (e.g., Mana Remnants)
- `showItemWhenComplete`
  - *boolean* - Whether the item remains visible when complete