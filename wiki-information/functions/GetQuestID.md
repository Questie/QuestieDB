## Title: GetQuestID

**Content:**
Returns the ID of the displayed quest at a quest giver.
`questID = GetQuestID()`

**Returns:**
- `questID`
  - *number* - quest ID of the offered/discussed quest.

**Description:**
Only returns proper (non-zero) values:
- after `QUEST_DETAIL` for offered quests and `QUEST_PROGRESS` / `QUEST_COMPLETE` for accepted quests.
- before `QUEST_FINISHED`.

This function is not related to your quest log.