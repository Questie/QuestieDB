---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local Corrections = LibQuestieDB.Corrections
local Meta = LibQuestieDB.Meta
local QuestMeta = Meta.QuestMeta

---@class QuestFixesCata
local QuestFixes = {}


C_Timer.After(0, function()
  Corrections.RegisterCorrectionStatic("quest",
                                       "QuestFixes-ObjectiveOrder-Cata",
                                       QuestFixes.LoadQuestObjectiveOrder,
                                       Corrections.CataBaseStaticOrder + 49)

  -- Clear the table to save memory
  QuestFixes = wipe(QuestFixes)
end)

---@return table<QuestId, Correction>
function QuestFixes.LoadQuestObjectiveOrder()
  local questKeys = QuestMeta.questKeys
  local objectiveKeys = QuestMeta.objectiveKeys

  return {
    -- QuestieCorrections.objectObjectiveFirst[14125] = true
    -- Log data for 14125: Creature obj (1 instance), Object obj (3 instances)
    -- Desired order: Object 1, Object 2, Object 3, Creature 1
    [14125] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, }, -- Object objective, 1st instance of object type, display order 1
        { objectiveKeys.OBJECT, 2, 2, }, -- Object objective, 2nd instance of object type, display order 2
        { objectiveKeys.OBJECT, 3, 3, }, -- Object objective, 3rd instance of object type, display order 3
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[24817] = true
    -- Log data for 24817: Creature obj (1 instance), Object obj (1 instance)
    -- Desired order: Object 1, Creature 1
    [24817] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[25371] = true
    -- Log data for 25371: Creature obj (1 instance), Object obj (1 instance)
    -- Desired order: Object 1, Creature 1
    [25371] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- ! QuestieCorrections.objectObjectiveFirst[25813] = true
    -- ! Log data for 25813: Creature obj (1 instance), Object obj (1 instance)
    -- ! Desired order: Object 1, Creature 1
    [25813] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[26659] = true
    -- Log data for 26659: Creature obj (1 instance), Object obj (1 instance)
    -- Desired order: Object 1, Creature 1
    [26659] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[26809] = true
    -- Log data for 26809: Creature obj (1 instance), Object obj (1 instance)
    -- Desired order: Object 1, Creature 1
    [26809] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[27161] = true
    -- Log data for 27161: Creature obj (1 instance), Object obj (1 instance)
    -- Desired order: Object 1, Creature 1
    [27161] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
      },
    },
    -- QuestieCorrections.objectObjectiveFirst[30099] = true
    -- Log data for 30099: Creature obj (1 instance), Object obj (3 instances)
    -- Desired order: Object 1, Object 2, Object 3, Creature 1
    [30099] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.OBJECT, 1, 1, },
        { objectiveKeys.OBJECT, 2, 2, },
        { objectiveKeys.OBJECT, 3, 3, },
      },
    },

    -- QuestieCorrections.killCreditObjectiveFirst[52] = true
    -- Log data for 52: Creature obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1
    [52] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[13798] = true
    -- Log data for 13798: Creature obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1
    [13798] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[25015] = true
    -- Log data for 25015: Item obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Item 1
    [25015] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[25801] = true
    -- Log data for 25801: Item obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Item 1
    [25801] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[26058] = true
    -- Log data for 26058: Creature obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1
    [26058] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[26621] = true
    -- Log data for 26621: Creature obj (2 instances), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1, Creature 2
    [26621] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[26875] = true
    -- Log data for 26875: Creature obj (1 instance), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1
    [26875] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[27715] = true
    -- Log data for 27715: Creature obj (3 instances), KillCredit obj (1 instance)
    -- Desired order: KillCredit 1, Creature 1, Creature 2, Creature 3
    [27715] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
      },
    },
    -- QuestieCorrections.killCreditObjectiveFirst[29290] = true
    -- Log data for 29290: Creature obj (1 instance), KillCredit obj (2 instances)
    -- Desired order: KillCredit 1, KillCredit 2, Creature 1
    [29290] = {
      [questKeys.orderedObjectives] = {
        { objectiveKeys.KILLCREDIT, 1, 1, },
        { objectiveKeys.KILLCREDIT, 2, 2, },
      },
    },
  }
end
