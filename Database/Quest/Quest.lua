---@class LibQuestieDB
---@field Quest Quest
local LibQuestieDB = select(2, ...)

local Corrections = LibQuestieDB.Corrections
local l10n = LibQuestieDB.l10n

--- Multiple inheritance for Quest

---@class (exact) Quest:DatabaseType
---@class (exact) Quest:QuestFunctions
local Quest = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.Quest, "Quest", Corrections.QuestMeta.questKeys)

do
  -- ? Questie Data structure for Quests
  --   ['name'] = 1,      -- string
  --   ['startedBy'] = 2, -- table
  --   --['creatureStart'] = 1, -- table {creature(int),...}
  --   --['objectStart'] = 2, -- table {object(int),...}
  --   --['itemStart'] = 3, -- table {item(int),...}
  --   ['finishedBy'] = 3, -- table
  --   --['creatureEnd'] = 1, -- table {creature(int),...}
  --   --['objectEnd'] = 2, -- table {object(int),...}
  --   ['requiredLevel'] = 4,   -- int
  --   ['questLevel'] = 5,      -- int
  --   ['requiredRaces'] = 6,   -- bitmask
  --   ['requiredClasses'] = 7, -- bitmask
  --   ['objectivesText'] = 8,  -- table: {string,...}, Description of the quest. Auto-complete if nil.
  --   ['triggerEnd'] = 9,      -- table: {text, {[zoneID] = {coordPair,...},...}}
  --   ['objectives'] = 10,     -- table
  --   --['creatureObjective'] = 1, -- table {{creature(int), text(string)},...}, If text is nil the default "<Name> slain x/y" is used
  --   --['objectObjective'] = 2, -- table {{object(int), text(string)},...}
  --   --['itemObjective'] = 3, -- table {{item(int), text(string)},...}
  --   --['reputationObjective'] = 4, -- table: {faction(int), value(int)}
  --   --['killCreditObjective'] = 5, -- table: {{{creature(int), ...}, baseCreatureID, baseCreatureText}, ...}
  --   --['spellObjective'] = 6, -- table: {{spell(int), text(string)},...}
  --   ['sourceItemId'] = 11,           -- int, item provided by quest starter
  --   ['preQuestGroup'] = 12,          -- table: {quest(int)}
  --   ['preQuestSingle'] = 13,         -- table: {quest(int)}
  --   ['childQuests'] = 14,            -- table: {quest(int)}
  --   ['inGroupWith'] = 15,            -- table: {quest(int)}
  --   ['exclusiveTo'] = 16,            -- table: {quest(int)}
  --   ['zoneOrSort'] = 17,             -- int, >0: AreaTable.dbc ID; <0: QuestSort.dbc ID
  --   ['requiredSkill'] = 18,          -- table: {skill(int), value(int)}
  --   ['requiredMinRep'] = 19,         -- table: {faction(int), value(int)}
  --   ['requiredMaxRep'] = 20,         -- table: {faction(int), value(int)}
  --   ['requiredSourceItems'] = 21,    -- table: {item(int), ...} Items that are not an objective but still needed for the quest.
  --   ['nextQuestInChain'] = 22,       -- int: if this quest is active/finished, the current quest is not available anymore
  --   ['questFlags'] = 23,             -- bitmask: see https://github.com/cmangos/issues/wiki/Quest_template#questflags
  --   ['specialFlags'] = 24,           -- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags
  --   ['parentQuest'] = 25,            -- int, the ID of the parent quest that needs to be active for the current one to be available. See also 'childQuests' (field 14)
  --   ['reputationReward'] = 26,       --table: {{faction(int), value(int)},...}, a list of reputation rewarded upon quest completion
  --   ['extraObjectives'] = 27,        -- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
  --   ['requiredSpell'] = 28,          -- int: quest is only available if character has this spellID
  --   ['requiredSpecialization'] = 29, -- int: quest is only available if character meets the spec requirements. Use QuestieProfessions.specializationKeys for having a spec, or QuestieProfessions.professionKeys to indicate having the profession with no spec. See QuestieProfessions.lua for more info.
  --   ['requiredMaxLevel'] = 30,       -- int: quest is only available up to a certain level

  -- ? QuestieDB Data structure for Quests

  -- Class for all the public functions for the Quest namespace
  ---@class QuestFunctions
  local QuestFunctions = {}

  -- Used to return an empty table instead of nil
  ---@type table<number, table<number, FontString>>
  local emptyTable = LibQuestieDB.CreateReadOnlyEmptyTable()

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" then
    -- Function to get the name of the quest<br>
    -- Returns "The Lost Artifact"
    ---@type fun(id: QuestId):Name?
    QuestFunctions.name = Quest.AddStringGetter(1, "name")
  else
    local questName_enUS = Quest.AddStringGetter(1, "name")
    QuestFunctions.name = function(id)
      return l10n.questName(id) or questName_enUS(id)
    end
  end

  -- Function to get the entity that starts the quest<br>
  -- Return {{12345}, {67890}, nil}
  ---@type fun(id: QuestId):StartedBy?
  QuestFunctions.startedBy = Quest.AddTableGetter(2, "startedBy", emptyTable)

  -- Function to get the entity that finishes the quest<br>
  -- Returns {{12345}, nil}
  ---@type fun(id: QuestId):FinishedBy?
  QuestFunctions.finishedBy = Quest.AddTableGetter(3, "finishedBy", emptyTable)

  -- Function to get the required level to start the quest<br>
  -- Returns 10
  ---@type fun(id: QuestId):Level?
  QuestFunctions.requiredLevel = Quest.AddNumberGetter(4, "requiredLevel", 0)

  -- Function to get the level of the quest<br>
  -- Returns 15
  ---@type fun(id: QuestId):Level?
  QuestFunctions.questLevel = Quest.AddNumberGetter(5, "questLevel", 1)

  -- Function to get the required races to start the quest<br>
  -- Returns 77 (bitmask for Human, Dwarf, Night Elf, Gnome)
  ---@type fun(id: QuestId):number?
  QuestFunctions.requiredRaces = Quest.AddNumberGetter(6, "requiredRaces", 0)

  -- Function to get the required classes to start the quest<br>
  -- Returns 9 (bitmask for Warrior)
  ---@type fun(id: QuestId):number?
  QuestFunctions.requiredClasses = Quest.AddNumberGetter(7, "requiredClasses", 0)

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" then
    -- Function to get the text of the quest objectives<br>
    -- Returns {"Find the lost artifact", "Return to the qu
    ---@type fun(id: QuestId):string[]?
    QuestFunctions.objectivesText = Quest.AddTableGetter(8, "objectivesText")
  else
    local fallbackObjectives = Quest.AddTableGetter(8, "objectivesText")
    QuestFunctions.objectivesText = function(id)
      return l10n.questObjectivesText(id) or fallbackObjectives(id)
    end
  end

  -- Function to get the trigger that ends the quest<br>
  -- Returns {"Prisoner Transport", {[46]={{25.73,27.1}}
  ---@type fun(id: QuestId):{ [1]: string, [2]: table<AreaId, CoordPair[]>}?
  QuestFunctions.triggerEnd = Quest.AddTableGetter(9, "triggerEnd")

  -- Function to get the objectives of the quest<br>
  -- Returns {{{9021,"Kharan's Tale"},}, ...}
  ---@type fun(id: QuestId):RawObjectives?
  QuestFunctions.objectives = Quest.AddTableGetter(10, "objectives", emptyTable)

  -- Function to get the item ID that starts the quest<br>
  -- Returns 12345
  ---@type fun(id: QuestId):ItemId?
  QuestFunctions.sourceItemId = Quest.AddNumberGetter(11, "sourceItemId", 0)

  -- Function to get the group of quests that must be completed before this quest<br>
  -- Returns {111, 112, 113}
  ---@type fun(id: QuestId):QuestId[]?
  QuestFunctions.preQuestGroup = Quest.AddTableGetter(12, "preQuestGroup")

  -- Function to get the single quest that must be completed before this quest<br>
  -- Returns {114}
  ---@type fun(id: QuestId):QuestId[]?
  QuestFunctions.preQuestSingle = Quest.AddTableGetter(13, "preQuestSingle")

  -- Function to get the quests that are unlocked by this quest<br>
  -- Returns {125, 126}
  ---@type fun(id: QuestId):QuestId[]?
  QuestFunctions.childQuests = Quest.AddTableGetter(14, "childQuests")

  -- Function to get the quests that are in the same group as this quest<br>
  -- Returns {127, 128}
  ---@type fun(id: QuestId):QuestId[]?
  QuestFunctions.inGroupWith = Quest.AddTableGetter(15, "inGroupWith")

  -- Function to get the quests that are exclusive with this quest<br>
  -- Returns {129, 130}
  ---@type fun(id: QuestId):QuestId[]?
  QuestFunctions.exclusiveTo = Quest.AddTableGetter(16, "exclusiveTo")

  -- Function to get the zone or sort of the quest<br>
  -- Returns 12 (Stormwind)
  ---@type fun(id: QuestId):ZoneOrSort?
  QuestFunctions.zoneOrSort = Quest.AddNumberGetter(17, "zoneOrSort", 0)

  -- Function to get the required skill to start the quest<br>
  -- Returns {185, 50}
  ---@type fun(id: QuestId):SkillPair?
  QuestFunctions.requiredSkill = Quest.AddTableGetter(18, "requiredSkill")

  -- Function to get the minimum reputation required to start the quest<br>
  -- Returns {72,0}
  ---@type fun(id: QuestId):ReputationPair?
  QuestFunctions.requiredMinRep = Quest.AddTableGetter(19, "requiredMinRep")

  -- Function to get the maximum reputation allowed to start the quest<br>
  -- Returns {21,-5999}
  ---@type fun(id: QuestId):ReputationPair?
  QuestFunctions.requiredMaxRep = Quest.AddTableGetter(20, "requiredMaxRep")

  -- Function to get the items required to start the quest<br>
  -- Returns {12341,12342,12343,12347}
  ---@type fun(id: QuestId):ItemId[]?
  QuestFunctions.requiredSourceItems = Quest.AddTableGetter(21, "requiredSourceItems")

  -- Function to get the next quest in the chain<br>
  -- Returns 131
  ---@type fun(id: QuestId):QuestId?
  QuestFunctions.nextQuestInChain = Quest.AddNumberGetter(22, "nextQuestInChain")

  -- Function to get the flags of the quest<br>
  -- Returns 8 (Elite quest)
  ---@type fun(id: QuestId):number?
  QuestFunctions.questFlags = Quest.AddNumberGetter(23, "questFlags")

  -- Function to get the special flags of the quest<br>
  -- Returns 1 (Daily quest)
  ---@type fun(id: QuestId):number?
  QuestFunctions.specialFlags = Quest.AddNumberGetter(24, "specialFlags", 0)

  -- Function to get the parent quest of this quest<br>
  -- Returns 132
  ---@type fun(id: QuestId):QuestId?
  QuestFunctions.parentQuest = Quest.AddNumberGetter(25, "parentQuest", 0)

  -- Function to get the reputation reward of the quest<br>
  -- Returns <INSERT EXAMPLE>
  ---@type fun(id: QuestId):ReputationPair[]?
  QuestFunctions.reputationReward = Quest.AddTableGetter(26, "reputationReward")

  -- Function to get the extra objectives of the quest<br>
  -- Returns <INSERT EXAMPLE>
  ---@type fun(id: QuestId):ExtraObjective?
  QuestFunctions.extraObjectives = Quest.AddTableGetter(27, "extraObjectives")

  -- Function to get the spell required to start the quest<br>
  -- Returns 12345
  ---@type fun(id: QuestId):number?
  QuestFunctions.requiredSpell = Quest.AddNumberGetter(28, "requiredSpell", 0)

  -- Function to get the specialization required to start the quest<br>
  -- Returns 202 (ENGINEERING)
  ---@type fun(id: QuestId):number?
  QuestFunctions.requiredSpecialization = Quest.AddNumberGetter(29, "requiredSpecialization", 0)

  -- Function to get the maximum level allowed to start the quest<br>
  -- Returns 60
  ---@type fun(id: QuestId):number?
  QuestFunctions.requiredMaxLevel = Quest.AddNumberGetter(30, "requiredMaxLevel", 0)

  --? This function is used to export all the functions to the Public and Private namespaces
  --? It gets called at the end of this file
  local function exportFunctions()
    ---@class QuestFunctions
    local publicQuest = LibQuestieDB.PublicLibQuestieDB.Quest
    for k, v in pairs(QuestFunctions) do
      Quest[k] = v
      publicQuest[k] = v
    end
    publicQuest.AddOverrideData = Quest.AddOverrideData
    publicQuest.ClearOverrideData = Quest.ClearOverrideData
    publicQuest.GetAllIds = Quest.GetAllIds
  end

  exportFunctions()
end
