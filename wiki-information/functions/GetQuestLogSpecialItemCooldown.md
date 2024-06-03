## Title: GetQuestLogSpecialItemCooldown

**Content:**
Returns cooldown information about a special quest item based on a given index.
`start, duration, enable = GetQuestLogSpecialItemCooldown(questLogIndex)`

**Parameters:**
- `questLogIndex`
  - *number* - The index of the quest to query. The number of quests can be retrieved with `GetNumQuestLogEntries()`.

**Returns:**
- `start`
  - *number* - The value of `GetTime()` when the quest item's cooldown began (or 0 if the item is off cooldown).
- `duration`
  - *number* - The duration of the item's cooldown (is 0 if the item is ready).
- `enable`
  - *number* - 1 if the item is enabled, otherwise 0 (needs verification).