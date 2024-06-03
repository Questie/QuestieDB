## Title: GetScenariosChoiceOrder

**Content:**
Returns an ordered list of all available scenario IDs.
`allScenarios = GetScenariosChoiceOrder()`

**Parameters:**
- `allScenarios`
  - *table* - If provided, this table will be wiped and populated with return values; otherwise, a new table will be created for the return value.

**Returns:**
- `allScenarios`
  - *table* - an array containing LFG dungeon IDs of specific scenarios. Not all of these may be level-appropriate.

**Reference:**
- `GetLFGDungeonInfo`
- `GetRandomScenarioInfo`