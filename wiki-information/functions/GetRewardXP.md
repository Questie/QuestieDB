## Title: GetRewardXP

**Content:**
Returns the experience reward for the quest in the gossip window.
`xp = GetRewardXP()`

**Parameters:**
None

**Returns:**
- `xp`
  - *number* - Amount of experience points to be received upon completing the quest, including any bonuses to experience gain such as Rest and .

**Description:**
This function is not related to your quest log.
The return values update when the `QUEST_DETAIL`, `QUEST_COMPLETE` events fire.