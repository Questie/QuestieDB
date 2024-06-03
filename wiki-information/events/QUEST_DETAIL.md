## Event: QUEST_DETAIL

**Title:** QUEST DETAIL

**Content:**
Fired when the player is given a more detailed view of his quest.
`QUEST_DETAIL: questStartItemID`

**Payload:**
- `questStartItemID`
  - *number?* - The ItemID of the item which begins the quest displayed in the quest detail view.

**Content Details:**
To get the quest that is currently displayed use (tested with 10.0.5):
`questID = GetQuestID()`