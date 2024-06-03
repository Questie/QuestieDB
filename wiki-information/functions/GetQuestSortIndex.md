## Title: GetQuestSortIndex

**Content:**
Returns the index of the collapsible category the queried quest belongs to.
`sortIndex = GetQuestSortIndex(questLogIndex)`

**Parameters:**
- `questLogIndex`
  - *number* - The index of the quest to query. The number of quests can be retrieved with `GetNumQuestLogEntries()`.

**Returns:**
- `sortIndex`
  - *number* - The index of the category starting from 1.

**Notes and Caveats:**
Quests are usually split per zone, so if for example there are quests from 5 zones present, `sortIndex` will range between 1-5.
Querying the category header itself will return the same `sortIndex` as the quests it lists.