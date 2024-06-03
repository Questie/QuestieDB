## Title: IsQuestCompletable

**Content:**
Returns true if the displayed quest at a quest giver can be completed.
`isQuestCompletable = IsQuestCompletable()`

**Returns:**
- `isQuestCompletable`
  - *boolean* - true if the quest can be completed, false otherwise.

**Example Usage:**
This function can be used in an addon to check if the player has met all the requirements to complete a quest when interacting with a quest giver. For instance, an addon could automatically highlight the "Complete Quest" button when `IsQuestCompletable()` returns true.

**Addons Using This Function:**
Many quest-related addons, such as Questie, use this function to determine if a quest can be completed and to provide visual cues or automated actions for the player.