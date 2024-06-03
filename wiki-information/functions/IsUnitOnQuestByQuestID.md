## Title: C_QuestLog.IsUnitOnQuest

**Content:**
Returns true if the unit is on the specified quest.
`isOnQuest = C_QuestLog.IsUnitOnQuest(unit, questID)`

**Parameters:**
- `unit`
  - *string* : UnitId
- `questID`
  - *number*

**Returns:**
- `isOnQuest`
  - *boolean*

**Example Usage:**
This function can be used to check if a player or any other unit (like a party member) is currently on a specific quest. For instance, it can be useful in group questing scenarios to ensure all members are on the same quest before proceeding.

**Addons:**
Large addons like Questie or World Quest Tracker might use this function to verify quest status for players and party members, ensuring accurate tracking and display of quest progress.