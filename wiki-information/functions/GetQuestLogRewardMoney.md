## Title: GetQuestLogRewardMoney

**Content:**
Returns the amount of money rewarded for a quest.
`money = GetQuestLogRewardMoney()`

**Parameters:**
- `QuestID`
  - *number?* - Unique identifier for a quest.

**Returns:**
- `rewardMoney`
  - *number?* - The amount of copper this quest gives as a reward.

**Description:**
The `questID` argument is optional. When called without a `questID`, it returns the reward for the most recently viewed quest in the quest log window.
Returns 0 if the `questID` is not currently in the quest log.