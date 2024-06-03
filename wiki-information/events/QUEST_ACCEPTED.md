## Event: QUEST_ACCEPTED

**Title:** QUEST ACCEPTED

**Content:**
Fires whenever the player accepts a quest.
`QUEST_ACCEPTED: questId`

**Payload:**
- `questLogIndex`
  - *number* - Classic only. Index of the quest in the quest log. You may pass this to `GetQuestLogTitle()` for information about the accepted quest.
- `questID`
  - *number* - QuestID of the accepted quest.