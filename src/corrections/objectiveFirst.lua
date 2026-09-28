-- Consumer hints are separate from entity data. Dynamic files populate these stable tables
-- after their seasonal guard, in both Source and Baked mode.
local _, LibQuestieDB = ...

LibQuestieDB.ObjectiveFirst = {
  killCreditObjectiveFirst = {},
  objectObjectiveFirst = {},
  itemObjectiveFirst = {},
  eventObjectiveFirst = {},
  spellObjectiveFirst = {},
}
