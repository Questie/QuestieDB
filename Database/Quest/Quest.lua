Quest = {}
Quest.maxId = 65610 -- This is different between expansions

-- This will be assigned from the initialize function
local glob = {}

function Quest.Initialize(dataGlob)
  glob = dataGlob
  print("Loaded Quest Data")
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

  ---Returns the quest name.
  ---@param id QuestId
  ---@return Name?
  function Quest.name(id)
    local data = glob[id]
    if data then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the entities that start the quest.
  ---@param id QuestId
  ---@return StartedBy?
  function Quest.startedBy(id)
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
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      return nil
    end
  end

  ---Returns the required classes to start the quest.
  ---@param id QuestId
  ---@return number?
  function Quest.requiredClasses(id)
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
    local data = glob[id]
    if data then
      return getNumber(data[29])
    else
      return nil
    end
  end
end

--? only <p> tags with data
-- function Quest.Initialize()
--   local retQuestData = {}
--   for range_low = 1, maxId, rangeSize do
--     local range = range_low .. "-" .. (range_low + (rangeSize - 1))
--     local success, dataFrame = pcall(CreateFrame, frameType, nil, nil, "QuestData" .. range)

--     if success then
--       local dataRegions = { dataFrame:GetRegions() }
--       dataFrame:SetScript("OnUpdate", nil)
--       dataFrame:Hide()
--       dataFrame:UnregisterAllEvents()

--       -- A test using gmatch instead of splitting
--       local idLookupData = dataRegions[1]:GetText()
--       local dataRegionsIndex = 2
--       for id in gMatch(idLookupData, "%d+") do
--         --? The first element contains a list of indexes for the data
--         --? e.g Name is index 1, Level is index 2, etc.
--         local indexData = strsplittable(",", dataRegions[dataRegionsIndex]:GetText())
--         local questId = tonumber(id)
--         if questId then
--           local questData = {}
--           -- Loop the indexdata and add the data at the correct index to the questData table
--           for i = 1, #indexData do
--             local data = dataRegions[dataRegionsIndex + i]
--             if data then
--               questData[tonumber(indexData[i])] = data
--             end
--           end
--           retQuestData[questId] = questData
--           -- Jump to the next quest the + 1 jumps from the last datapoint onto the next quest
--           dataRegionsIndex = dataRegionsIndex + #indexData + 1
--         else
--           error("Invalid quest id: " .. id)
--         end
--       end
--     end
--   end
--   print("Loaded Quest Data")
--   return retQuestData
-- end


-- function Quest.Initialize()
--   -- local max = 26100
--   local max = 65610
--   -- for _, range in pairs(filenames) do
--   for range_low = 1, max, 100 do
--     local range = range_low .. "-" .. (range_low + 99)
--     local success, indexData = pcall(CreateFrame, frameType, nil, nil, "QuestDataLookup" .. range)
--     -- if _G["QuestDataLookup" .. range] ~= nil then
--     if success then
--       -- local indexData = _G["QuestDataLookup" .. range]
--       --! These are required, otherwise you get choppyness
--       --? Unknown why but i think it is redrawing or triggering on events or something
--       -- indexData:SetScript("OnUpdate", nil)
--       -- indexData:Hide()
--       -- indexData:UnregisterAllEvents()
--       local regions = { indexData:GetRegions() }
--       local indexToQuestId = {}
--       for k, v in pairs(regions) do
--         local questId = tonumber(v:GetText())
--         indexToQuestId[k] = questId
--         -- print(k, v:GetText())
--         -- local text = v:GetText()
--       end
--       -- _G["QuestDataLookup" .. range] = nil
--       indexData = nil

--       local questData = CreateFrame(frameType, nil, nil, "QuestData" .. range)
--       -- local questData = _G["QuestData" .. range]
--       --! These are required, otherwise you get choppyness
--       --? Unknown why but i think it is redrawing or triggering on events or something
--       -- questData:SetScript("OnUpdate", nil)
--       -- questData:Hide()
--       -- questData:UnregisterAllEvents()

--       local dataRegions = { questData:GetRegions() }
--       -- frameRange[range_low] = questData
--       -- print(range_low)
--       -- rangeData[range_low] = dataRegions
--       -- Loop over skipping each 29 index
--       local index = 1
--       for i = 1, #dataRegions, 29 do
--         local questId = indexToQuestId[index]
--         -- questStartIndex[questId] = i
--         local data = {
--           dataRegions[i],
--           dataRegions[i + 1],
--           dataRegions[i + 2],
--           dataRegions[i + 3],
--           dataRegions[i + 4],
--           dataRegions[i + 5],
--           dataRegions[i + 6],
--           dataRegions[i + 7],
--           dataRegions[i + 8],
--           dataRegions[i + 9],
--           dataRegions[i + 10],
--           dataRegions[i + 11],
--           dataRegions[i + 12],
--           dataRegions[i + 13],
--           dataRegions[i + 14],
--           dataRegions[i + 15],
--           dataRegions[i + 16],
--           dataRegions[i + 17],
--           dataRegions[i + 18],
--           dataRegions[i + 19],
--           dataRegions[i + 20],
--           dataRegions[i + 21],
--           dataRegions[i + 22],
--           dataRegions[i + 23],
--           dataRegions[i + 24],
--           dataRegions[i + 25],
--           dataRegions[i + 26],
--           dataRegions[i + 27],
--           dataRegions[i + 28],
--         }
--         globQuestData[questId] = data
--         index = index + 1
--       end
--       coroutine.yield()
--     end
--   end
--   print("Loaded Quest Data")
-- end
--? All <p> tags
-- function Quest.Initialize()
--   local processed = 0
--   for range_low = 1, maxId, rangeSize do
--     local range = range_low .. "-" .. (range_low + (rangeSize - 1))
--     local success, dataFrame = pcall(CreateFrame, frameType, nil, nil, "QuestData" .. range)
--     -- local dataFrame = _G["QuestData" .. range]

--     if success then
--     -- if dataFrame ~= nil then
--       local dataRegions = { dataFrame:GetRegions() }
--       dataFrame:SetScript("OnUpdate", nil)
--       dataFrame:Hide()
--       dataFrame:UnregisterAllEvents()

--       -- local indexData = strsplittable(",", dataRegions[1]:GetText())

--       -- local index = 1
--       -- for i = 2, #dataRegions, 29 do
--       --   glob[tonumber(indexData[index])] = {
--       --     dataRegions[i],
--       --     dataRegions[i + 1],
--       --     dataRegions[i + 2],
--       --     dataRegions[i + 3],
--       --     dataRegions[i + 4],
--       --     dataRegions[i + 5],
--       --     dataRegions[i + 6],
--       --     dataRegions[i + 7],
--       --     dataRegions[i + 8],
--       --     dataRegions[i + 9],
--       --     dataRegions[i + 10],
--       --     dataRegions[i + 11],
--       --     dataRegions[i + 12],
--       --     dataRegions[i + 13],
--       --     dataRegions[i + 14],
--       --     dataRegions[i + 15],
--       --     dataRegions[i + 16],
--       --     dataRegions[i + 17],
--       --     dataRegions[i + 18],
--       --     dataRegions[i + 19],
--       --     dataRegions[i + 20],
--       --     dataRegions[i + 21],
--       --     dataRegions[i + 22],
--       --     dataRegions[i + 23],
--       --     dataRegions[i + 24],
--       --     dataRegions[i + 25],
--       --     dataRegions[i + 26],
--       --     dataRegions[i + 27],
--       --     dataRegions[i + 28],
--       --   }
--       --   index = index + 1
--       -- end

--       -- for i = 2, #dataRegions, 29 do
--       --   glob[tonumber(indexData[index])] = {
--       --     dataRegions[i]:GetText() and dataRegions[i] or nil,
--       --     dataRegions[i + 1]:GetText() and dataRegions[i + 1] or nil,
--       --     dataRegions[i + 2]:GetText() and dataRegions[i + 2] or nil,
--       --     dataRegions[i + 3]:GetText() and dataRegions[i + 3] or nil,
--       --     dataRegions[i + 4]:GetText() and dataRegions[i + 4] or nil,
--       --     dataRegions[i + 5]:GetText() and dataRegions[i + 5] or nil,
--       --     dataRegions[i + 6]:GetText() and dataRegions[i + 6] or nil,
--       --     dataRegions[i + 7]:GetText() and dataRegions[i + 7] or nil,
--       --     dataRegions[i + 8]:GetText() and dataRegions[i + 8] or nil,
--       --     dataRegions[i + 9]:GetText() and dataRegions[i + 9] or nil,
--       --     dataRegions[i + 10]:GetText() and dataRegions[i + 10] or nil,
--       --     dataRegions[i + 11]:GetText() and dataRegions[i + 11] or nil,
--       --     dataRegions[i + 12]:GetText() and dataRegions[i + 12] or nil,
--       --     dataRegions[i + 13]:GetText() and dataRegions[i + 13] or nil,
--       --     dataRegions[i + 14]:GetText() and dataRegions[i + 14] or nil,
--       --     dataRegions[i + 15]:GetText() and dataRegions[i + 15] or nil,
--       --     dataRegions[i + 16]:GetText() and dataRegions[i + 16] or nil,
--       --     dataRegions[i + 17]:GetText() and dataRegions[i + 17] or nil,
--       --     dataRegions[i + 18]:GetText() and dataRegions[i + 18] or nil,
--       --     dataRegions[i + 19]:GetText() and dataRegions[i + 19] or nil,
--       --     dataRegions[i + 20]:GetText() and dataRegions[i + 20] or nil,
--       --     dataRegions[i + 21]:GetText() and dataRegions[i + 21] or nil,
--       --     dataRegions[i + 22]:GetText() and dataRegions[i + 22] or nil,
--       --     dataRegions[i + 23]:GetText() and dataRegions[i + 23] or nil,
--       --     dataRegions[i + 24]:GetText() and dataRegions[i + 24] or nil,
--       --     dataRegions[i + 25]:GetText() and dataRegions[i + 25] or nil,
--       --     dataRegions[i + 26]:GetText() and dataRegions[i + 26] or nil,
--       --     dataRegions[i + 27]:GetText() and dataRegions[i + 27] or nil,
--       --     dataRegions[i + 28]:GetText() and dataRegions[i + 28] or nil,
--       --   }
--       --   index = index + 1
--       -- end

--       -- A test using gmatch instead of splitting
--       local idLookupData = dataRegions[1]:GetText()
--       local dataRegionsIndex = 2
--       for id in gMatch(idLookupData, "%d+") do
--         glob[tonumber(id)] = {
--           dataRegions[dataRegionsIndex],
--           dataRegions[dataRegionsIndex + 1],
--           dataRegions[dataRegionsIndex + 2],
--           dataRegions[dataRegionsIndex + 3],
--           dataRegions[dataRegionsIndex + 4],
--           dataRegions[dataRegionsIndex + 5],
--           dataRegions[dataRegionsIndex + 6],
--           dataRegions[dataRegionsIndex + 7],
--           dataRegions[dataRegionsIndex + 8],
--           dataRegions[dataRegionsIndex + 9],
--           dataRegions[dataRegionsIndex + 10],
--           dataRegions[dataRegionsIndex + 11],
--           dataRegions[dataRegionsIndex + 12],
--           dataRegions[dataRegionsIndex + 13],
--           dataRegions[dataRegionsIndex + 14],
--           dataRegions[dataRegionsIndex + 15],
--           dataRegions[dataRegionsIndex + 16],
--           dataRegions[dataRegionsIndex + 17],
--           dataRegions[dataRegionsIndex + 18],
--           dataRegions[dataRegionsIndex + 19],
--           dataRegions[dataRegionsIndex + 20],
--           dataRegions[dataRegionsIndex + 21],
--           dataRegions[dataRegionsIndex + 22],
--           dataRegions[dataRegionsIndex + 23],
--           dataRegions[dataRegionsIndex + 24],
--           dataRegions[dataRegionsIndex + 25],
--           dataRegions[dataRegionsIndex + 26],
--           dataRegions[dataRegionsIndex + 27],
--           dataRegions[dataRegionsIndex + 28],
--         }
--         dataRegionsIndex = dataRegionsIndex + 29
--       end
--       -- processed = processed + index
--       -- if processed > 200 then
--       --   coYield()
--       --   processed = 0
--       -- end
--     end
--     -- break
--   end
--   print("Loaded Quest Data")
-- end