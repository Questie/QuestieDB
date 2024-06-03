## Title: C_QuestLog.GetQuestObjectives

**Content:**
Returns info for the objectives of a quest.
`objectives = C_QuestLog.GetQuestObjectives(questID)`

**Parameters:**
- `questID`
  - *number* - Unique QuestID for the quest to be queried.

**Returns:**
- `objectives`
  - *table* - a table (can be an empty table for quests without objectives) containing: a subtable for each objective which in turn contains the below values
    - `Field`
    - `Type`
    - `Description`
    - `text`
      - *string* - the text displayed in the quest log and the quest tracker
    - `type`
      - *string* - "monster", "item", etc.
    - `finished`
      - *boolean* - true if the objective has been completed
    - `numFulfilled`
      - *number* - number of partial objectives fulfilled
    - `numRequired`
      - *number* - number of partial objectives required

**Description:**
For example, calling this function for the quest Colonel Kurzen returns a table with three subtables (with keys 1, 2, and 3), two with the type "monster" and one with the type "item".
Quests that have been encountered before (i.e. cached) are able to be queried instantly, however, if the function is supplied a quest ID of a quest that isn't cached yet, it will not return anything until called again. Sometimes three calls are needed to fully cache everything (such as text).
It returns an empty table for some quests without any objectives, for example, A Threat Within.