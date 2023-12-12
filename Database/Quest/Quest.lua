Quest = {}

-- This will be assigned from the initialize function
local glob = {}
local override = {}

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
  Quest.override = override
end

function Quest.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Quest database before adding override data")
  end
  Database.Override(dataOverride, override, overrideKeys)
end

function Quest.ClearOverrideData()
  if override then
    override = wipe(override)
  end
end

---Get all quest ids.
---@return QuestId[]
function Quest.GetAllQuestIds()
  local loadstringFunction = Database.GetAllEntityIdsFunction("Quest")
  -- Replace the function with the loadstringFunction
  ---@cast loadstringFunction fun():QuestId[]
  Quest.GetAllQuestIds = loadstringFunction
  return loadstringFunction()
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

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
  --   ['rewardReputation'] = 26,       --table: {{faction(int), value(int)},...}, a list of reputation rewarded upon quest completion
  --   ['extraObjectives'] = 27,        -- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
  --   ['requiredSpell'] = 28,          -- int: quest is only available if character has this spellID
  --   ['requiredSpecialization'] = 29, -- int: quest is only available if character meets the spec requirements. Use QuestieProfessions.specializationKeys for having a spec, or QuestieProfessions.professionKeys to indicate having the profession with no spec. See QuestieProfessions.lua for more info.
  -- }

  --? New
  -- QuestieDB.questKeys = {
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
  --   --['killCreditObjective'] = 5, -- table: {{creature(int), ...}, baseCreatureID, baseCreatureText}
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
  --   ['reputationReward'] = 26,       -- table: {{FACTION,VALUE}, ...}, A list of reputation reward for factions
  --   ['extraObjectives'] = 27,        -- table: {{spawnlist, iconFile, text, objectiveIndex (optional), {{dbReferenceType, id}, ...} (optional)},...}, a list of hidden special objectives for a quest. Similar to requiredSourceItems
  --   ['requiredSpell'] = 28,          -- int: quest is only available if character has this spellID
  --   ['requiredSpecialization'] = 29, -- int: quest is only available if character meets the spec requirements. Use QuestieProfessions.specializationKeys for having a spec, or QuestieProfessions.professionKeys to indicate having the profession with no spec. See QuestieProfessions.lua for more info.
  --   ['requiredMaxLevel'] = 30,       -- int: quest is only available up to a certain level
  -- }

  ---Returns the quest name.
  ---@param id QuestId
  ---@return Name?
  function Quest.name(id)
    if override[id] then
      return override[id]["name"]
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
  function Quest.startedBy(id)
    if override[id] then
      return override[id]["startedBy"]
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
  function Quest.finishedBy(id)
    if override[id] then
      return override[id]["finishedBy"]
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
  function Quest.requiredLevel(id)
    if override[id] then
      return override[id]["requiredLevel"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[4])
    else
      return nil
    end
  end

  ---Returns the level of the quest.
  ---@param id QuestId
  ---@return Level?
  function Quest.questLevel(id)
    if override[id] then
      return override[id]["questLevel"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[5])
    else
      return nil
    end
  end

  ---Returns the required races to start the quest.
  ---@param id QuestId
  ---@return number?
  function Quest.requiredRaces(id)
    if override[id] then
      return override[id]["requiredRaces"]
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
  function Quest.requiredClasses(id)
    if override[id] then
      return override[id]["requiredClasses"]
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
  function Quest.objectivesText(id)
    if override[id] then
      return override[id]["objectivesText"]
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
  function Quest.triggerEnd(id)
    if override[id] then
      return override[id]["triggerEnd"]
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
  function Quest.objectives(id)
    if override[id] then
      return override[id]["objectives"]
    end
    local data = glob[id]
    if data then
      return getTable(data[10])
    else
      return nil
    end
  end

  ---Returns the source item ID of the quest.
  ---@param id QuestId
  ---@return ItemId?
  function Quest.sourceItemId(id)
    if override[id] then
      return override[id]["sourceItemId"]
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
  function Quest.preQuestGroup(id)
    if override[id] then
      return override[id]["preQuestGroup"]
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
  function Quest.preQuestSingle(id)
    if override[id] then
      return override[id]["preQuestSingle"]
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
  function Quest.childQuests(id)
    if override[id] then
      return override[id]["childQuests"]
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
  function Quest.inGroupWith(id)
    if override[id] then
      return override[id]["inGroupWith"]
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
  function Quest.exclusiveTo(id)
    if override[id] then
      return override[id]["exclusiveTo"]
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
  function Quest.zoneOrSort(id)
    if override[id] then
      return override[id]["zoneOrSort"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[17])
    else
      return nil
    end
  end

  ---Returns the required skill of the quest.
  ---@param id QuestId
  ---@return SkillPair?
  function Quest.requiredSkill(id)
    if override[id] then
      return override[id]["requiredSkill"]
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
  function Quest.requiredMinRep(id)
    if override[id] then
      return override[id]["requiredMinRep"]
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
  function Quest.requiredMaxRep(id)
    if override[id] then
      return override[id]["requiredMaxRep"]
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
  function Quest.requiredSourceItems(id)
    if override[id] then
      return override[id]["requiredSourceItems"]
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
  function Quest.nextQuestInChain(id)
    if override[id] then
      return override[id]["nextQuestInChain"]
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
  function Quest.questFlags(id)
    if override[id] then
      return override[id]["questFlags"]
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
  function Quest.specialFlags(id)
    if override[id] then
      return override[id]["specialFlags"]
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
  function Quest.parentQuest(id)
    if override[id] then
      return override[id]["parentQuest"]
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
  function Quest.rewardReputation(id)
    if override[id] then
      return override[id]["rewardReputation"]
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
  function Quest.extraObjectives(id)
    if override[id] then
      return override[id]["extraObjectives"]
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
  function Quest.requiredSpell(id)
    if override[id] then
      return override[id]["requiredSpell"]
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
  function Quest.requiredSpecialization(id)
    if override[id] then
      return override[id]["requiredSpecialization"]
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
  function Quest.requiredMaxLevel(id)
    if override[id] then
      return override[id]["requiredMaxLevel"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[30]) or 0
    else
      return 0
    end
  end
end
