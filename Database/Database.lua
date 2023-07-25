---@diagnostic disable: need-check-nil

local _,
---@class QuestieSDB
QuestieSDB = ...

Database = {}
Database.debugEnabled = true
Database.Initialized = false


---@alias Id number @Generic id type

--- Does not actually contain id but the data associated with it.
--- 1 Quest, 2 Npc, 3 Object, 4 Item
---@type table<Id, { [1]: table, [2]: table, [3]: table, [4]: table }>
Database.glob = {}


local CreateFrame = CreateFrame
local frameType = "SimpleHTML"
local pcall = pcall
local strsplittable = strsplittable
local tConcat = table.concat

local coYield = coroutine.yield

local tonumber = tonumber
local loadstring = loadstring
local gMatch = string.gmatch

local type = type

--? Fetch functions for the database
Database.getNumber = function(pObject)
  if pObject == nil then
    return nil
  end
  local text = pObject:GetText()
  --TODO: Check what happens if the text is nil or something
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
  --TODO: Check what happens if the text is nil or something
  if text == nil or text == "" or text == "nil" then
    return nil
  end
  return loadstring("return " .. text)()
end

--- This function adds override data by function name to the override table.
---
--- e.g [ID] = { ["functionName"] = value }
---
--- local itemFixesAlliance = {
---    [15882] = {
---      [itemKeys.objectDrops] = { 177844 },
---    },
--- }
---@param overrideData table @ The data to add to the override table i.e { [15882] = {[itemKeys.objectDrops] = { 177844 }}, }
---@param overrideTable table @ The table to add the override data to i.e Npc.override
---@param keys table<string, number> @ The keys to use for the override table i.e { ['name'] = 1, }
function Database.Override(overrideData, overrideTable, keys)
  -- return immediately if any of the parameters is not provided
  if not overrideData or not overrideTable or not keys then
    return
  end

  -- Validate the type of the arguments and return error messages if the types are not correct
  assert(type(overrideData) == "table", "Error: 'overrideData' should be a table.")
  assert(type(overrideTable) == "table", "Error: 'overrideTable' should be a table.")
  assert(type(keys) == "table", "Error: 'keys' should be a table.")

  -- Create a reversed table of keys for efficient lookup
  local keysReversed = {}
  for key, id in pairs(keys) do
    keysReversed[id] = key
  end

  -- Traverse the overrideData
  for dataId, data in pairs(overrideData) do
    -- Validate the 'data' type
    assert(type(data) == "table", "Error: 'data' within 'overrideData' should be a table.")

    -- Traverse the inner 'data' table
    for key, value in pairs(data) do
      -- Get the key name from the reversed keys
      local keyName = keysReversed[key]

      -- If the keyName exists
      if keyName then
        -- If the dataId does not exist in the overrideTable, create a new table
        if not overrideTable[dataId] then
          overrideTable[dataId] = {}
        end
        -- Add the keyName and its corresponding value to the overrideTable
        overrideTable[dataId][keyName] = value
      end
    end
  end
end

--- Initialize a database frame and load the data into a table
---@param FrameName "QuestData"|"ItemData"|"ObjectData"|"NpcData"
---@return table, number, number
function Database.InitializeDB(FrameName, yield)
  local retEntryData = {}
  local totalCount = 0
  local totalFiles = 0

  -- Create a new UI Frame to load data from
  local dataFilenameFrame = CreateFrame(frameType, nil, nil, FrameName .. "Files")

  -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
  local dataFilenameRegions = { dataFilenameFrame:GetRegions() }
  local combinedString = ""
  for i = 1, #dataFilenameRegions do
    combinedString = combinedString .. dataFilenameRegions[i]:GetText()
  end
  local files = strsplittable(",", combinedString)

  -- Iterating over all files
  for fileIndex = 1, #files do
    totalFiles = totalFiles + 1

    -- Creating a frame for each file and reading data
    local dataFrame = CreateFrame(frameType, nil, nil, files[fileIndex])
    local dataRegions = { dataFrame:GetRegions() }

    -- This is very important to prevent the frame from updating and causing lag
    -- dataFrame:SetScript("OnUpdate", nil)
    dataFrame:Hide()
    -- dataFrame:UnregisterAllEvents()

    -- The first element contains a list of ids by index for the data
    -- local idLookupData = dataRegions[1]:GetText()
    -- This means we start at index 2 for the data
    local dataRegionsIndex = 2
    local idLookupData = strsplittable(",", dataRegions[1]:GetText())

    -- Iterating over all ids in idLookupData
    for idIndex = 1, #idLookupData do
      -- Data id string is the id of the data, such as questId, npcId, etc.
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
        local count = 1

        ---@param partIndex string @The index of the segmented data or "e" for end
        for dataIndex, partIndex in gMatch(dataIndexString, "(%d+)-*(%w*)") do
          local dataIndexNumber = tonumber(dataIndex)

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
        dataRegionsIndex = dataRegionsIndex + count

        totalCount = totalCount + 1
        if yield then
          if totalCount % yield == 0 then
            coYield()
          end
        end
      else
        error("Invalid " .. FrameName .. " id: " .. id)
      end
    end
  end
  C_Timer.After(0.5, function()
    -- This is very important to prevent the frame from updating and causing lag
    -- dataFilenameFrame:SetScript("OnUpdate", nil)
    dataFilenameFrame:Hide()
    -- dataFilenameFrame:UnregisterAllEvents()
    dataFilenameFrame = nil
  end)

  return retEntryData, totalCount, totalFiles
end





function Database.Init(yield)
  local start = time()
  print("-- Database Initialization --")
  -- Quest
  debugprofilestart()
  local questData, questCount, fileQuestCount = Database.InitializeDB("QuestData")
  Quest.Initialize(questData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    QuestieSDB.ColorizePrint("green", "Quest data database loaded:  #(", questCount, ") files(", fileQuestCount, ") ",
      format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / questCount), "ms per quest")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Object
  debugprofilestart()
  local objectData, objectCount, fileObjectCount = Database.InitializeDB("ObjectData")
  Object.Initialize(objectData)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    QuestieSDB.ColorizePrint("green", "Object data database loaded:  #(", objectCount, ") files(", fileObjectCount, ") ",
      format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / objectCount), "ms per object")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Npc
  debugprofilestart()
  local npcData, npcCount, fileNpcCount = Database.InitializeDB("NpcData", yield)
  Npc.Initialize(npcData, QuestieNPCFixes:LoadFactionFixes(), QuestieDB.npcKeys)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    QuestieSDB.ColorizePrint("green", "Npc data database loaded:  #(", npcCount, ") files(", fileNpcCount, ") ",
      format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / npcCount), "ms per npc")
    print("    ", format("%.4f", msTime), "ms")
  end
  -- Item
  debugprofilestart()
  local itemData, itemCount, fileItemCount = Database.InitializeDB("ItemData", yield)
  Item.Initialize(itemData, QuestieItemFixes:LoadFactionFixes(), QuestieDB.itemKeys)
  if Database.debugEnabled then
    local msTime = debugprofilestop()
    QuestieSDB.ColorizePrint("green", "Item data database loaded:  #(", itemCount, ") files(", fileItemCount, ") ",
      format("%.2f", msTime / 1000), "s")
    print("    ", format("%.6f", (msTime) / itemCount), "ms per item")
    print("    ", format("%.4f", msTime), "ms")
  end
  print("Total time elapsed:", time() - start, "s")
  Database.Initialized = true
end

C_Timer.After(0,function ()
  -- ThreadLib.ThreadSimple(function()
  --   Database.Init(80)
  -- end, 0)
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
