## Title: GetNumQuestLogRewards

**Content:**
Returns the number of unconditional rewards for the current quest in the quest log.
`numQuestRewards = GetNumQuestLogRewards()`

**Returns:**
- `numQuestRewards`
  - *number* - The number of rewards for this quest

**Description:**
This refers to items always awarded upon quest completion; for quests where the player is allowed to choose a reward, see `GetNumQuestLogChoices()`.