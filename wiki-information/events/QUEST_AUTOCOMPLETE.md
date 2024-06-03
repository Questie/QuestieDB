## Event: QUEST_AUTOCOMPLETE

**Title:** QUEST AUTOCOMPLETE

**Content:**
Fires when a quest that can be auto-completed is completed.
`QUEST_AUTOCOMPLETE: questId`

**Payload:**
- `questId`
  - *number*

**Content Details:**
Quests eligible for auto-completion do not need to be handed in to a specific NPC; instead, the player can complete the quest, receive the rewards, and remove it from their quest log anywhere in the world.
Use `ShowQuestComplete` in conjunction with `GetQuestLogIndexByID` to display the quest completion dialog, allowing use of `GetQuestReward` after `QUEST_COMPLETE` has fired.