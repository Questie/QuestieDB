## Title: C_QuestInfoSystem.GetQuestShouldToastCompletion

**Content:**
Needs summary.
`shouldToast = C_QuestInfoSystem.GetQuestShouldToastCompletion()`

**Parameters:**
- `questID`
  - *number?*

**Returns:**
- `shouldToast`
  - *boolean*

**Example Usage:**
This function can be used to determine if a quest completion should trigger a toast notification. This can be particularly useful for addons that manage quest tracking and notifications, ensuring that important quest completions are highlighted to the player.

**Addon Usage:**
Large addons like "Questie" or "TomTom" might use this function to enhance the user experience by providing visual feedback when a quest is completed, ensuring players are aware of their progress and achievements.