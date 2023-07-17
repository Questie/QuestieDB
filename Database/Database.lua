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
---@return table, number, number
function Database.InitializeDB(FrameName)
  local retEntryData = {}
  local totalCount = 0
  local totalFiles = 0
  local dataFilenameFrame = CreateFrame(frameType, nil, nil, FrameName .. "Files")
  -- print(FrameName .. "Files")

  -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
  local dataFilenameRegions = { dataFilenameFrame:GetRegions() }
  local combinedString = ""
  for i = 1, #dataFilenameRegions do
    combinedString = combinedString .. dataFilenameRegions[i]:GetText()
  end

  -- print(combinedString)
  for file in gMatch(combinedString, "%d+-%d+") do
    totalFiles = totalFiles + 1
    -- print(file)
    local dataFrame = CreateFrame(frameType, nil, nil, FrameName .. file)
    local dataRegions = { dataFrame:GetRegions() }
    -- This is very important to prevent the frame from updating and causing lag
    dataFrame:SetScript("OnUpdate", nil)
    dataFrame:Hide()
    dataFrame:UnregisterAllEvents()

    -- The first element contains a list of ids by index for the data
    -- local idLookupData = dataRegions[1]:GetText()
    -- This means we start at index 2 for the data
    local dataRegionsIndex = 2
    local idLookupData = strsplittable(",", dataRegions[1]:GetText())

    -- for id in gMatch(idLookupData, "%d+") do
    for idIndex = 1, #idLookupData do
      local id = idLookupData[idIndex]

      -- Such as questId, npcId, etc.
      local dataId = tonumber(id)
      if dataId then
        -- Contains the frame-handles for the data (The GetText functions)
        local entryData = {}

        --? The first element contains a list of indexes for the data
        --? e.g Name is index 1, Level is index 2, etc.
        -- Loop the indexdata and add the data at the correct index to the entryData table
        local dataIndexString = dataRegions[dataRegionsIndex]:GetText()
        -- print("IndexString:", dataIndexString)
        local count = 1

        ---@param partIndex string @The index of the segmented data or "e" for end
        for dataIndex, partIndex in gMatch(dataIndexString, "(%d+)-*(%w*)") do
          -- print("dataLoop", dataIndex, second)
          local dataIndexNumber = tonumber(dataIndex)
          -- if dataIndexNumber == nil then
          --   error("Invalid " .. FrameName .. " dataIndex: " .. dataIndex)
          -- end
          -- Frame Data object (The one with GetText)
          local data = dataRegions[dataRegionsIndex + count]
          if data then
            if partIndex ~= "" then
              -- We create a list of functions to call when we want to get the data
              -- Load all the segmented data into a table ending with the e partIndex
              if partIndex ~= "e" then
                --? Numbered Segmented data
                if not entryData[dataIndexNumber] then
                  entryData[dataIndexNumber] = {}
                end
                entryData[dataIndexNumber][tonumber(partIndex)] = data
              else
                --? End of Segmented data (The last element)
                -- Add the last element to the list
                entryData[dataIndexNumber][#entryData[dataIndexNumber] + 1] = data
                -- Create the function that will be called when we want to get the data
                local segments = entryData[dataIndexNumber]
                -- Replace the table with a function that returns the concatinated string
                entryData[dataIndexNumber] = {
                  -- This emulates the frame function name so we can use the same code for both
                  GetText = function()
                    -- TODO: Is tConcat faster than ..?
                    local ret = {}
                    for i = 1, #segments do
                      ret[i] = segments[i]:GetText()
                    end
                    --? Can this become polymorphic and cache the result?
                    --? This could be unnecessary due to most data that is big is just fetched once and used.
                    -- local concatinatedString = tConcat(ret)
                    -- entryData[dataIndexNumber].GetText = function()
                    --   return concatinatedString
                    -- end
                    return tConcat(ret)
                  end
                }
              end
            else
              entryData[dataIndexNumber] = data
            end
          end
          count = count + 1
        end
        retEntryData[dataId] = entryData
        -- Jump to the next entry (The + 1 jumps from the last datapoint onto the next entry)
        -- dataRegionsIndex = dataRegionsIndex + #indexData + 1
        dataRegionsIndex = dataRegionsIndex + count

        totalCount = totalCount + 1
      else
        error("Invalid " .. FrameName .. " id: " .. id)
      end
    end
  end
  C_Timer.After(0.5, function()
    dataFilenameFrame:SetScript("OnUpdate", nil)
    dataFilenameFrame:Hide()
    dataFilenameFrame:UnregisterAllEvents()
    dataFilenameFrame = nil
  end)

  return retEntryData, totalCount, totalFiles
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

function Database.Init(yield)
  local start = time()
  print("-- Database Initialization --")
  -- Quest
  debugprofilestart()
  local questData, questCount, fileQuestCount = Database.InitializeDB("QuestData")
  Quest.Initialize(questData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    print("  #(", questCount, ") files(", fileQuestCount, ") Quest data database loaded:", format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / questCount), "ms per quest")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Object
  debugprofilestart()
  local objectData, objectCount, fileObjectCount = Database.InitializeDB("ObjectData")
  Object.Initialize(objectData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    print("  #(", objectCount, ") files(", fileObjectCount, ") Object data database loaded:", format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / objectCount), "ms per object")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Item
  debugprofilestart()
  local itemData, itemCount, fileItemCount = Database.InitializeDB("ItemData")
  Item.Initialize(itemData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    print("  #(", itemCount, ") files(", fileItemCount, ") Item data database loaded:", format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / itemCount), "ms per item")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Npc
  debugprofilestart()
  local npcData, npcCount, fileNpcCount = Database.InitializeDB("NpcData")
  Npc.Initialize(npcData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    print("  #(", npcCount, ") files(", fileNpcCount, ") Npc data database loaded:", format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / npcCount), "ms per npc")
    print("    ", format("%.4f", msTime), "ms")
  end
  print("Total time elapsed:", time() - start, "s")
  Database.Initialized = true
end

C_Timer.After(0,function ()
  Database.Init()
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
