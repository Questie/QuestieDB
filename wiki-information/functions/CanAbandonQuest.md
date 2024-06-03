## Title: CanAbandonQuest

**Content:**
Returns whether the player can abandon a specific quest.
`canAbandon = CanAbandonQuest(questID)`

**Parameters:**
- `questID`
  - *number* - quest ID of the quest to query, e.g. 5944 for In Dreams.

**Returns:**
- `canAbandon`
  - *boolean* - 1 if the player is currently on the specified quest and can abandon it, nil otherwise.

**Description:**
Some quests cannot be abandoned. These include some of the Battle Pet Tamers quests.