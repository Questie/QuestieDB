---@class LibQuestieDB
---@field Quest Quest
local LibQuestieDB = select(2, ...)

---@class Quest:QuestFunctions
local Quest = LibQuestieDB.Quest

--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText

local debug = DebugText:Get("Quest")

--*---------------------------
--- The nil value for the database
local _nil = Database._nil

---- Contains the data ----
local glob = {}
local override = {}

---- Contains the id strings ----
local AllIdStrings = {}

---- Local Functions ----
local tonumber = tonumber
local tConcat = table.concat
local tInsert = table.insert
local wipe = wipe
local loadstring = loadstring

function Quest.InitializeDynamic()
  -- This will be assigned from the initialize function
  local questData = Database.LoadDatafileList("QuestData")
  -- localized for faster access
  local loadFile = Database.LoadFile
  -- Get the binary search function
  local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(questData)

  ---@type table<QuestId, table<number, FontString>>
  glob = setmetatable({},
    {
      __index = function(t, k)
        return loadFile(binarySearch(k), t, k)
      end,
      __newindex = function()
        error("Attempt to modify read-only table")
      end
    }
  )
  Quest.glob = glob
  Quest.LoadOverrideData()
end

---comment
---@param includeDynamic boolean? @If true, include dynamic data Default true
---@param includeStatic boolean? @If true, include dynamic data Default false
function Quest.LoadOverrideData(includeDynamic, includeStatic)
  if includeDynamic == nil then
    includeDynamic = true
  end
  if includeStatic == nil then
    includeStatic = Database.debugEnabled or false
  end
  -- Clear the override data
  Quest.ClearOverrideData()

  print("Loading Quest Corrections")
  local loadOrder = 0
  local totalLoaded = 0
  -- Load all Quest Corrections
  for _, list in pairs(Corrections.GetCorrections("quest", includeStatic, includeDynamic)) do
    for id, func in pairs(list) do
      local correctionData = func()
      totalLoaded = totalLoaded + Quest.AddOverrideData(correctionData, Corrections.QuestMeta.questKeys)
      if Database.debugEnabled then
        debug:Print("  " .. tostring(loadOrder) .. "  Loaded", id)
      end
      loadOrder = loadOrder + 1
    end
  end
  if Database.debugEnabled then
    debug:Print("  # Quest Corrections", totalLoaded)
  end
  Quest.override = override
end

function Quest.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Quest database before adding override data")
  end
  local newIds = Database.GetNewIds(AllIdStrings, dataOverride)
  if #newIds ~= 0 then
    tInsert(AllIdStrings, tConcat(newIds, ","))
    if Database.debugEnabled then
      print("  # New Quest IDs", #newIds)
    end
  end
  return Database.Override(dataOverride, override, overrideKeys)
end

local function InitializeIdString()
  wipe(AllIdStrings)
  local func, idString = Database.GetAllEntityIdsFunction("Quest")
  tInsert(AllIdStrings, idString)
  assert(#func() == #Quest.GetAllQuestIds(), "Quest ids are not the same")
end

function Quest.ClearOverrideData()
  if override then
    override = wipe(override)
  end
  InitializeIdString()
end

---Get all quest ids.
---@return QuestId[]
function Quest.GetAllQuestIds()
  return loadstring(string.format("return {%s}", tConcat(AllIdStrings, ",")))()
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable
  -- Used to return an empty table instead of nil
  ---@type table<number, table<number, FontString>>
  local emptyTable = setmetatable({}, {
    __newindex = function()
      error("Attempt to modify read-only table")
    end
  })

  -- Class for all the GET functions for the Quest namespace
  ---@class QuestFunctions
  local QuestFunctions = {}

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
    publicQuest.GetAllQuestIds = Quest.GetAllQuestIds
  end

  -- questKeys = {
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
  -- }

  ---Returns the quest name.
  ---@param id QuestId
  ---@return Name?
  function QuestFunctions.name(id)
    if override[id] and override[id]["name"] then
      local name = override[id]["name"]
      return name ~= _nil and name or nil
    end
    local data = glob[id]
    if data and data[1] then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the entities that start the quest.
  ---@param id QuestId
  ---@return StartedBy?
  function QuestFunctions.startedBy(id)
    if override[id] and override[id]["startedBy"] then
      local startedBy = override[id]["startedBy"]
      return startedBy ~= _nil and startedBy or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[2])
    else
      return nil
    end
  end

  ---Returns the entities that finish the quest.
  ---@param id QuestId
  ---@return FinishedBy?
  function QuestFunctions.finishedBy(id)
    if override[id] and override[id]["finishedBy"] then
      local finishedBy = override[id]["finishedBy"]
      return finishedBy ~= _nil and finishedBy or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[3])
    else
      return nil
    end
  end

  ---Returns the required level to start the quest.
  ---@param id QuestId
  ---@return Level?
  function QuestFunctions.requiredLevel(id)
    if override[id] and override[id]["requiredLevel"] then
      local requiredLevel = override[id]["requiredLevel"]
      return requiredLevel ~= _nil and requiredLevel or nil
    end
    --TODO: Should this return 0 as default value?
    local data = glob[id]
    if data then
      return getNumber(data[4]) or 0
    else
      return 0
    end
  end

  ---Returns the level of the quest.
  ---@param id QuestId
  ---@return Level?
  function QuestFunctions.questLevel(id)
    if override[id] and override[id]["questLevel"] then
      local questLevel = override[id]["questLevel"]
      return questLevel ~= _nil and questLevel or nil
    end
    --TODO: Should this return 1 as default value?
    local data = glob[id]
    if data then
      return getNumber(data[5]) or 1
    else
      return 1
    end
  end

  ---Returns the required races to start the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.requiredRaces(id)
    if override[id] and override[id]["requiredRaces"] then
      local requiredRaces = override[id]["requiredRaces"]
      return requiredRaces ~= _nil and requiredRaces or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      -- If no requiredRace is set we return 0 (as in all races)
      return 0
    end
  end

  ---Returns the required classes to start the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.requiredClasses(id)
    if override[id] and override[id]["requiredClasses"] then
      local requiredClasses = override[id]["requiredClasses"]
      return requiredClasses ~= _nil and requiredClasses or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[7])
    else
      return nil
    end
  end

  ---Returns the objectives text of the quest.
  ---@param id QuestId
  ---@return string[]?
  function QuestFunctions.objectivesText(id)
    if override[id] and override[id]["objectivesText"] then
      local objectivesText = override[id]["objectivesText"]
      return objectivesText ~= _nil and objectivesText or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[8])
    else
      return nil
    end
  end

  ---Returns the trigger end of the quest.
  ---@param id QuestId
  ---@return { [1]: string, [2]: table<AreaId, CoordPair[]>}?
  function QuestFunctions.triggerEnd(id)
    if override[id] and override[id]["triggerEnd"] then
      local triggerEnd = override[id]["triggerEnd"]
      return triggerEnd ~= _nil and triggerEnd or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[9])
    else
      return nil
    end
  end

  ---Returns the raw objectives of the quest.
  ---@param id QuestId
  ---@return RawObjectives?
  function QuestFunctions.objectives(id)
    if override[id] and override[id]["objectives"] then
      local objectives = override[id]["objectives"]
      return objectives ~= _nil and objectives or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[10]) or emptyTable
    else
      return nil
    end
  end

  ---Returns the source item ID of the quest.
  ---@param id QuestId
  ---@return ItemId?
  function QuestFunctions.sourceItemId(id)
    if override[id] and override[id]["sourceItemId"] then
      local sourceItemId = override[id]["sourceItemId"]
      return sourceItemId ~= _nil and sourceItemId or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[11])
    else
      return nil
    end
  end

  ---Returns the pre-quest group of the quest.
  ---@param id QuestId
  ---@return QuestId[]?
  function QuestFunctions.preQuestGroup(id)
    if override[id] and override[id]["preQuestGroup"] then
      local preQuestGroup = override[id]["preQuestGroup"]
      return preQuestGroup ~= _nil and preQuestGroup or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[12])
    else
      return nil
    end
  end

  ---Returns the pre-quest single of the quest.
  ---@param id QuestId
  ---@return QuestId[]?
  function QuestFunctions.preQuestSingle(id)
    if override[id] and override[id]["preQuestSingle"] then
      local preQuestSingle = override[id]["preQuestSingle"]
      return preQuestSingle ~= _nil and preQuestSingle or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[13])
    else
      return nil
    end
  end

  ---Returns the child quests of the quest.
  ---@param id QuestId
  ---@return QuestId[]?
  function QuestFunctions.childQuests(id)
    if override[id] and override[id]["childQuests"] then
      local childQuests = override[id]["childQuests"]
      return childQuests ~= _nil and childQuests or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[14])
    else
      return nil
    end
  end

  ---Returns the quests that are in group with the quest.
  ---@param id QuestId
  ---@return QuestId[]?
  function QuestFunctions.inGroupWith(id)
    if override[id] and override[id]["inGroupWith"] then
      local inGroupWith = override[id]["inGroupWith"]
      return inGroupWith ~= _nil and inGroupWith or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[15])
    else
      return nil
    end
  end

  ---Returns the quests that are exclusive to the quest.
  ---@param id QuestId
  ---@return QuestId[]?
  function QuestFunctions.exclusiveTo(id)
    if override[id] and override[id]["exclusiveTo"] then
      local exclusiveTo = override[id]["exclusiveTo"]
      return exclusiveTo ~= _nil and exclusiveTo or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[16])
    else
      return nil
    end
  end

  ---Returns the zone or sort of the quest.
  ---@param id QuestId
  ---@return ZoneOrSort?
  function QuestFunctions.zoneOrSort(id)
    if override[id] and override[id]["zoneOrSort"] then
      local zoneOrSort = override[id]["zoneOrSort"]
      return zoneOrSort ~= _nil and zoneOrSort or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[17]) or 0
    else
      return 0
    end
  end

  ---Returns the required skill of the quest.
  ---@param id QuestId
  ---@return SkillPair?
  function QuestFunctions.requiredSkill(id)
    if override[id] and override[id]["requiredSkill"] then
      local requiredSkill = override[id]["requiredSkill"]
      return requiredSkill ~= _nil and requiredSkill or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[18])
    else
      return nil
    end
  end

  ---Returns the required minimum reputation of the quest.
  ---@param id QuestId
  ---@return ReputationPair?
  function QuestFunctions.requiredMinRep(id)
    if override[id] and override[id]["requiredMinRep"] then
      local requiredMinRep = override[id]["requiredMinRep"]
      return requiredMinRep ~= _nil and requiredMinRep or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[19])
    else
      return nil
    end
  end

  ---Returns the required maximum reputation of the quest.
  ---@param id QuestId
  ---@return ReputationPair?
  function QuestFunctions.requiredMaxRep(id)
    if override[id] and override[id]["requiredMaxRep"] then
      local requiredMaxRep = override[id]["requiredMaxRep"]
      return requiredMaxRep ~= _nil and requiredMaxRep or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[20])
    else
      return nil
    end
  end

  ---Returns the required source items of the quest.
  ---@param id QuestId
  ---@return ItemId[]?
  function QuestFunctions.requiredSourceItems(id)
    if override[id] and override[id]["requiredSourceItems"] then
      local requiredSourceItems = override[id]["requiredSourceItems"]
      return requiredSourceItems ~= _nil and requiredSourceItems or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[21])
    else
      return nil
    end
  end

  ---Returns the next quest in the chain of the quest.
  ---@param id QuestId
  ---@return QuestId?
  function QuestFunctions.nextQuestInChain(id)
    if override[id] and override[id]["nextQuestInChain"] then
      local nextQuestInChain = override[id]["nextQuestInChain"]
      return nextQuestInChain ~= _nil and nextQuestInChain or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[22])
    else
      return nil
    end
  end

  ---Returns the quest flags of the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.questFlags(id)
    if override[id] and override[id]["questFlags"] then
      local questFlags = override[id]["questFlags"]
      return questFlags ~= _nil and questFlags or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[23])
    else
      return nil
    end
  end

  ---Returns the special flags of the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.specialFlags(id)
    if override[id] and override[id]["specialFlags"] then
      local specialFlags = override[id]["specialFlags"]
      return specialFlags ~= _nil and specialFlags or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[24])
    else
      return nil
    end
  end

  ---Returns the parent quest of the quest.
  ---@param id QuestId
  ---@return QuestId?
  function QuestFunctions.parentQuest(id)
    if override[id] and override[id]["parentQuest"] then
      local parentQuest = override[id]["parentQuest"]
      return parentQuest ~= _nil and parentQuest or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[25])
    else
      return nil
    end
  end

  ---Returns the reward reputation of the quest.
  ---@param id QuestId
  ---@return ReputationPair[]?
  function QuestFunctions.reputationReward(id)
    if override[id] and override[id]["reputationReward"] then
      local reputationReward = override[id]["reputationReward"]
      return reputationReward ~= _nil and reputationReward or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[26])
    else
      return nil
    end
  end

  ---Returns the extra objectives of the quest.
  ---@param id QuestId
  ---@return ExtraObjective?
  function QuestFunctions.extraObjectives(id)
    if override[id] and override[id]["extraObjectives"] then
      local extraObjectives = override[id]["extraObjectives"]
      return extraObjectives ~= _nil and extraObjectives or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[27])
    else
      return nil
    end
  end

  ---Returns the required spell of the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.requiredSpell(id)
    if override[id] and override[id]["requiredSpell"] then
      local requiredSpell = override[id]["requiredSpell"]
      return requiredSpell ~= _nil and requiredSpell or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[28])
    else
      return nil
    end
  end

  ---Returns the required specialization of the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.requiredSpecialization(id)
    if override[id] and override[id]["requiredSpecialization"] then
      local requiredSpecialization = override[id]["requiredSpecialization"]
      return requiredSpecialization ~= _nil and requiredSpecialization or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[29])
    else
      return nil
    end
  end

  ---Returns the required max level of the quest.
  ---@param id QuestId
  ---@return number?
  function QuestFunctions.requiredMaxLevel(id)
    if override[id] and override[id]["requiredMaxLevel"] then
      local requiredMaxLevel = override[id]["requiredMaxLevel"]
      return requiredMaxLevel ~= _nil and requiredMaxLevel or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[30]) or 0
    else
      return 0
    end
  end
  exportFunctions()
end
