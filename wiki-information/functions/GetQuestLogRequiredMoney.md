## Title: C_QuestLog.GetRequiredMoney

**Content:**
Returns the amount of money required for quest completion.
`requiredMoney = C_QuestLog.GetRequiredMoney()`

**Parameters:**
- `questID`
  - *number?* - Uses the selected quest if no questID is provided.

**Returns:**
- `requiredMoney`
  - *number*

**Example Usage:**
This function can be used to determine if a player has enough money to complete a quest that requires a monetary payment. For instance, if a quest requires a donation or a fee to proceed, you can use this function to check the required amount and compare it with the player's current money.

**Addon Usage:**
Large addons like Questie or WoW-Pro Guides might use this function to display additional information about quests, such as the required money for completion, directly in the quest log or quest tracker interface. This helps players manage their quests more effectively by providing all necessary information at a glance.