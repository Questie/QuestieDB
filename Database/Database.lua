local _, dataa = ...
Database = {}
Database.debugEnabled = true


---@alias Id number @Generic id type

--- Does not actually contain id but the data associated with it.
--- 1 Quest, 2 Npc, 3 Object, 4 Item
---@type table<Id, { [1]: table, [2]: table, [3]: table, [4]: table }>
Database.glob = {}


local rangeSize = 50

local CreateFrame = CreateFrame
local frameType = "SimpleHTML"
local pcall = pcall
local strsplittable = strsplittable
local tConcat = table.concat

local coYield = coroutine.yield

local tonumber = tonumber
local loadstring = loadstring
local gMatch = string.gmatch

--? Fetch functions for the database
Database.getNumber = function(pObject)
  if pObject == nil then
    return nil
  end
  local text = pObject:GetText()
  if text == nil or text == "" or text == "nil" then
    return nil
  end
  return tonumber(text)
end
Database.getTable = function(pObject)
  if pObject == nil then
    return nil
  end
  local text = pObject:GetText()
  if text == nil or text == "" or text == "nil" then
    return nil
  end
  return loadstring("return " .. text)()
end


--- Initialize a database frame and load the data into a table
---@param FrameName "QuestData"|"ItemData"|"ObjectData"|"NpcData"
---@param maxId number @The maximum id to load, used when creating the ranges for files to load
---@return table
function Database.InitializeDB(FrameName, maxId)
  local retEntryData = {}
  local dataFilenameFrame = CreateFrame(frameType, nil, nil, FrameName .. "Files")
  local dataPartOne, dataPartTwo = dataFilenameFrame:GetRegions()
  local combinedString = dataPartOne:GetText() .. dataPartTwo:GetText()
  -- print(combinedString)
  for file in gMatch(combinedString, "%d+-%d+") do
    -- print(file)
    local dataFrame = CreateFrame(frameType, nil, nil, FrameName .. file)
    local dataRegions = { dataFrame:GetRegions() }
    -- This is very important to prevent the frame from updating and causing lag
    dataFrame:SetScript("OnUpdate", nil)
    dataFrame:Hide()
    dataFrame:UnregisterAllEvents()
    -- wipe(dataFrame)

    -- A test using gmatch instead of splitting
    local idLookupData = dataRegions[1]:GetText()
    local dataRegionsIndex = 2
    -- local ret = gMatch(idLookupData, "%d+-*%d*")
    -- DevTools_Dump(ret())
    --! We have to do this because of large one-liners :(
    -- for first, second in gMatch(idLookupData, "(%d+)-*(%d*)") do
    --   print(first, second)
    -- end
    
    -- return retEntryData
    for id in gMatch(idLookupData, "%d+") do
      --? The first element contains a list of indexes for the data
      --? e.g Name is index 1, Level is index 2, etc.
      local indexData = strsplittable(",", dataRegions[dataRegionsIndex]:GetText())
      -- Such as questId, npcId, etc.
      local dataId = tonumber(id)
      -- print("ID", dataId)
      if dataId then
        -- Contains the frame-handles for the data (The GetText functions)
        local entryData = {}
        -- Loop the indexdata and add the data at the correct index to the entryData table
        for i = 1, #indexData do
          local data = dataRegions[dataRegionsIndex + i]
          if data then
            entryData[tonumber(indexData[i])] = data
          end
        end
        retEntryData[dataId] = entryData
        -- Jump to the next entry (The + 1 jumps from the last datapoint onto the next entry)
        dataRegionsIndex = dataRegionsIndex + #indexData + 1
      else
        error("Invalid " .. FrameName  .. " id: " .. id)
      end
    end
  end
  C_Timer.After(0.5, function()
    dataFilenameFrame:SetScript("OnUpdate", nil)
    dataFilenameFrame:Hide()
    dataFilenameFrame:UnregisterAllEvents()
    dataFilenameFrame = nil
  end)

  return retEntryData
end

-- --- Initialize a database frame and load the data into a table
-- ---@param FrameName "QuestData"|"ItemData"|"ObjectData"|"NpcData"
-- ---@param maxId number @The maximum id to load, used when creating the ranges for files to load
-- ---@return table
-- function Database.InitializeDB(FrameName, maxId)
--   local retEntryData = {}
--   local rangeStringTable = { FrameName, 0, "-", 0 }
--   for range_low = 1, maxId, rangeSize do
--     -- local range = range_low .. "-" .. (range_low + (rangeSize - 1))
--     -- local success, dataFrame = pcall(CreateFrame, frameType, nil, nil, FrameName .. range)
--     rangeStringTable[2] = range_low
--     rangeStringTable[4] = range_low + (rangeSize - 1)
--     local success, dataFrame = pcall(CreateFrame, frameType, nil, nil, tConcat(rangeStringTable))


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
--         -- Such as questId, npcId, etc.
--         local dataId = tonumber(id)
--         if dataId then
--           -- Contains the frame-handles for the data (The GetText functions)
--           local entryData = {}
--           -- Loop the indexdata and add the data at the correct index to the entryData table
--           for i = 1, #indexData do
--             local data = dataRegions[dataRegionsIndex + i]
--             if data then
--               entryData[tonumber(indexData[i])] = data
--             end
--           end
--           retEntryData[dataId] = entryData
--           -- Jump to the next entry (The + 1 jumps from the last datapoint onto the next entry)
--           dataRegionsIndex = dataRegionsIndex + #indexData + 1
--         else
--           error("Invalid " .. FrameName  .. " id: " .. id)
--         end
--       end
--     end
--   end
--   return retEntryData
-- end

C_Timer.After(0, function()
  local previousTime = 0
  local start = time()
  print("-- Database Initialization --")
  local quest = time()
  local questData = Database.InitializeDB("QuestData", Quest.maxId)
  Quest.Initialize(questData)
  if Database.debugEnabled then
    local total, count = GetFunctionCPUUsage(Database.InitializeDB, true)
    print("  Quest data database loaded:", time() - quest, "s")
    print("    ", total / count, "ms")
    previousTime = total
  end
  local item = time()
  local itemData = Database.InitializeDB("ItemData", Item.maxId)
  Item.Initialize(itemData)
  if Database.debugEnabled then
    local total, count = GetFunctionCPUUsage(Database.InitializeDB, true)
    print("  Item data database loaded:", time() - item, "s")
    print("    ", (total / count) - previousTime, "ms")
    previousTime = total
  end
  print("  Item data database loaded:", time() - item, "s")
  -- local object = time()
  -- local objectData = Database.InitializeDB("ObjectData", Object.maxId)
  -- Object.Initialize(objectData)
  -- if Database.debugEnabled then
  --   local total, count = GetFunctionCPUUsage(Object.Initialize, true)
  --   print("    ", (total / count) - previousTime, "ms")
  --   previousTime = total
  -- end
  -- print("  Object data database loaded:", time() - object, "s")
  -- local npc = time()
  -- local npcData = Database.InitializeDB("NpcData", Npc.maxId)
  -- Npc.Initialize(npcData)
  -- if Database.debugEnabled then
  --   local total, count = GetFunctionCPUUsage(Npc.Initialize, true)
  --   print("    ", (total / count) - previousTime, "ms")
  --   previousTime = total / count
  -- end
  print("Total time elapsed:", time()-start, "s")
end)

-- C_Timer.After(5, function()
--   ThreadLib.Thread(function()
--     local start = time()
--     print("Start", start)
--     Quest.Initialize()
--     print("End", time())
--     print("Elapsed:", time() - start)
--   end, 0.05)
--   -- DevTools_Dump(data.disallowedQuestRanges)
-- end)


