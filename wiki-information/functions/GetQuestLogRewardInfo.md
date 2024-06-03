## Title: GetQuestLogRewardInfo

**Content:**
Returns info for an unconditional quest reward item in the quest log.
`itemName, itemTexture, numItems, quality, isUsable, itemID, itemLevel = GetQuestLogRewardInfo(itemIndex)`

**Parameters:**
- `itemIndex`
  - *number* - Index of the item reward to query, up to GetNumQuestLogRewards
- `questID`
  - *number?* - Unique identifier for a quest.

**Returns:**
- `itemName`
  - *string* - The name of the quest item
- `itemTexture`
  - *string* - The texture of the quest item
- `numItems`
  - *number* - How many of the quest item
- `quality`
  - *number* - Quality of the quest item
- `isUsable`
  - *boolean* - If the quest item is usable by the current player
- `itemID`
  - *number* - Unique identifier for the item
- `itemLevel`
  - *number* - Scaled item level of the reward, based on the character's item level

**Description:**
This function is used for quest reward items that are rewarded unconditionally (mandatory) upon completion of a quest. For information about reward items a player can choose from, use `GetQuestLogChoiceInfo` instead.
This function appears to get info for the currently viewed quest completion dialog if called without a questID. Otherwise, it returns information about the supplied questID.