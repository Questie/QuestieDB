## Event: QUEST_TURNED_IN

**Title:** QUEST TURNED IN

**Content:**
This event fires whenever the player turns in a quest, whether automatically with a Task-type quest (Bonus Objectives/World Quests), or by pressing the Complete button in a quest dialog window.
`QUEST_TURNED_IN: questID, xpReward, moneyReward`

**Payload:**
- `questID`
  - *number* - QuestID of the quest accepted.
- `xpReward`
  - *number* - Number of Experience point awarded, if any. Zero if character is max level.
- `moneyReward`
  - *number* - Amount of Money awarded, if any. Amount in coppers.