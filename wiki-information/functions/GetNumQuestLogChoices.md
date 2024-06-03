## Title: GetNumQuestLogChoices

**Content:**
Returns the number of options someone has when getting a quest item.
`numQuestChoices = GetNumQuestLogChoices(questID)`

**Parameters:**
- `questID`
  - *number* - Unique QuestID for the quest to be queried.
- `includeCurrencies`
  - *boolean?* - Optional parameter to include currencies in the count.

**Returns:**
- `numQuestChoices`
  - *number* - The number of quest item options for this quest.