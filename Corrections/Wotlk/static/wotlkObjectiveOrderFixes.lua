---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local Corrections = LibQuestieDB.Corrections
local Meta = LibQuestieDB.Meta
local QuestMeta = Meta.QuestMeta

---@class QuestFixesWotlk
local QuestFixes = {}


C_Timer.After(0, function()
  Corrections.RegisterCorrectionStatic("quest",
                                       "QuestFixes-ObjectiveOrder-Wotlk",
                                       QuestFixes.LoadQuestObjectiveOrder,
                                       Corrections.WotlkBaseStaticOrder + 49)

  -- Clear the table to save memory
  QuestFixes = wipe(QuestFixes)
end)

---@return table<QuestId, Correction[]>>
function QuestFixes.LoadQuestObjectiveOrder()
  local questKeys = QuestMeta.questKeys
  local objectiveKeys = QuestMeta.objectiveKeys

  return {
    [11652] = {
      -- QuestieCorrections.killCreditObjectiveFirst[11652] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
        { objectiveKeys.KILLCREDIT, 2, 2, },
      },
    },
    [12100] = {
      -- QuestieCorrections.killCreditObjectiveFirst[12100] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [12546] = {
      -- QuestieCorrections.killCreditObjectiveFirst[12546] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [12561] = {
      -- QuestieCorrections.killCreditObjectiveFirst[12561] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [12762] = {
      -- QuestieCorrections.killCreditObjectiveFirst[12762] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [12919] = {
      -- QuestieCorrections.killCreditObjectiveFirst[12919] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13086] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13086] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13373] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13373] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13376] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13376] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13380] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13380] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13382] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13382] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13404] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13404] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [13406] = {
      -- QuestieCorrections.killCreditObjectiveFirst[13406] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [24498] = {
      -- QuestieCorrections.killCreditObjectiveFirst[24498] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    [24507] = {
      -- QuestieCorrections.killCreditObjectiveFirst[24507] = true
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
  }
end
