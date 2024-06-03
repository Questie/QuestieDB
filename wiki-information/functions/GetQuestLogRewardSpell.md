## Title: GetQuestLogRewardSpell

**Content:**
Returns the spell reward for a quest.
`texture, name, isTradeskillSpell, isSpellLearned, hideSpellLearnText, isBoostSpell, garrFollowerID, genericUnlock, spellID = GetQuestLogRewardSpell(rewardIndex, questID)`

**Parameters:**
- `rewardIndex`
  - *number* - The index of the spell reward to get the details for, from 1 to GetNumRewardSpells
- `questID`
  - *number* - Unique QuestID for the quest to be queried.

**Returns:**
- `texture`
  - *string* - The texture of the spell icon
- `name`
  - *string* - The spell name
- `isTradeskillSpell`
  - *boolean* - Whether the spell is a tradeskill spell
- `isSpellLearned`
  - *boolean* - Whether the spell has been learned already
- `hideSpellLearnText`
  - *unknown*
- `isBoostSpell`
  - *boolean* - Unknown
- `garrFollowerID`
  - *number* - If the spell grants a Garrison follower, it's ID.
- `genericUnlock`
  - *unknown*
- `spellID`
  - *number* - Unknown

**Description:**
Returns information about the spell reward of the current selected quest.