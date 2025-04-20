---@class LibQuestieDB
---@field Database Database
local LibQuestieDB = select(2, ...)

--*---- Create Module --------
---@class Database
local Database = LibQuestieDB.Database
---@type table<string, boolean>
Database.entityTypes = {}

--*---- Import Modules -------
local Quest = LibQuestieDB.Quest
local Object = LibQuestieDB.Object
local Npc = LibQuestieDB.Npc
local Item = LibQuestieDB.Item
local l10n = LibQuestieDB.l10n

------------------------------
--? Debug settings
------------------------------

--? Some prints require both to be true some only debugPrintEnabled
--? debugEnabled: Enable more debug code and the FontString box prints
Database.debugEnabled = true
--? debugPrintEnabled: Enable debug message box prints, if only enabled provides some basic information
Database.debugPrintEnabled = true
--? debugLoadStaticEnabled: Enable loading of the static data into override tables (Useful for correction development)
Database.debugLoadStaticEnabled = true

--* We want these to always be enabled in CLI
Database.debugEnabled = Is_CLI and true or Database.debugEnabled
Database.debugPrintEnabled = Is_CLI and true or Database.debugPrintEnabled
Database.debugLoadStaticEnabled = Is_CLI and true or Database.debugLoadStaticEnabled

------------------------------

--? Is the database initialized
Database.Initialized = false

--- The nil value for the database
Database._nil = "nil"
local _nil = Database._nil


---@alias Id number @Generic id type

---- Local Functions ----
--* For performance reasons we check Is_CLI here, Database.CreateFrame supports both CLI and WOW
local CreateFrame   = Is_CLI and Database.CreateFrame or CreateFrame
local frameType     = "SimpleHTML"
local strsplittable = strsplittable
local tConcat       = table.concat
local wipe          = wipe

local tonumber      = tonumber
local tostring      = tostring
local loadstring    = loadstring
local gMatch        = string.gmatch
local tInsert       = table.insert
local sFind         = string.find
local format        = string.format
local f             = string.format

local type          = type
local pairs         = pairs
local assert        = assert

function Database.Init()
  local startTotal = 0
  print("-- Database Initialization --")
  -- l10n
  debugprofilestart()
  l10n.InitializeDynamic()
  if Database.debugPrintEnabled or Database.debugEnabled then
    local msTime = debugprofilestop()
    LibQuestieDB.ColorizePrint("green", "l10n data database initialized:")
    print("    ", format("%.4f", msTime), "ms")
    startTotal = startTotal + msTime
  end
  -- Quest
  debugprofilestart()
  Quest.InitializeDynamic()
  if Database.debugPrintEnabled or Database.debugEnabled then
    local msTime = debugprofilestop()
    LibQuestieDB.ColorizePrint("green", "Quest data database initialized:")
    print("    ", format("%.4f", msTime), "ms")
    startTotal = startTotal + msTime
  end
  -- Object
  debugprofilestart()
  Object.InitializeDynamic()
  if Database.debugPrintEnabled or Database.debugEnabled then
    local msTime = debugprofilestop()
    LibQuestieDB.ColorizePrint("green", "Object data database initialized:")
    print("    ", format("%.4f", msTime), "ms")
    startTotal = startTotal + msTime
  end
  -- Npc
  debugprofilestart()
  Npc.InitializeDynamic()
  -- Npc.AddOverrideData(QuestieNPCFixes:LoadFactionFixes(), QuestieDB.npcKeys)
  if Database.debugPrintEnabled or Database.debugEnabled then
    local msTime = debugprofilestop()
    LibQuestieDB.ColorizePrint("green", "Npc data database initialized:")
    print("    ", format("%.4f", msTime), "ms")
    startTotal = startTotal + msTime
  end
  -- Item
  debugprofilestart()
  Item.InitializeDynamic()
  -- Item.AddOverrideData(QuestieItemFixes:LoadFactionFixes(), QuestieDB.itemKeys)
  if Database.debugPrintEnabled or Database.debugEnabled then
    local msTime = debugprofilestop()
    LibQuestieDB.ColorizePrint("green", "Item data database initialized:")
    print("    ", format("%.4f", msTime), "ms")
    startTotal = startTotal + msTime

    -- Print total time elapsed
    print("Total time elapsed:", format("%.4f", startTotal), "ms")
  end
  Database.Initialized = true
end

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
---@param overrideData table<number, any> @ The data to add to the override table i.e { [15882] = {[itemKeys.objectDrops] = { 177844 }}, }
---@param overrideTable table<Id, table<string, any>> @ The table to add the override data to i.e Npc.override
---@param keys table<string, number> @ The keys to use for the override table i.e { ['name'] = 1, }
---@return number @ The number of override data added
function Database.Override(overrideData, overrideTable, keys)
  -- return immediately if any of the parameters is not provided
  if not overrideData or not overrideTable or not keys then
    print("Please provide 3 arguments to the Override function.")
    return 0
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
  local totalCount = 0
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

        --? We don't want to store empty tables in the override table
        if type(value) == "table" then
          -- Is the table empty?
          if #value == 0 then
            -- Make sure the table is empty
            local count = 0
            for _ in pairs(value) do
              count = count + 1
            end
            if count == 0 then
              overrideTable[dataId][keyName] = _nil
            end
          end
        end
      end
      totalCount = totalCount + 1
    end
  end
  return totalCount
end

---Used to add new Ids into the master list of ids for that type
do
  -- Table used to store the ids for the current call
  local allIdsSet = {}
  ---Used to add new Ids into the master list of ids for that type
  ---@param AllIdStrings string @A list of strings containing the ids in the database, will be concatenated into one string
  ---@param dataOverride table<number, any> @The data to check for new ids
  ---@return QuestId[]|NpcId[]|ObjectId[]|ItemId[] @Returns a list of new ids
  function Database.GetNewIds(AllIdStrings, dataOverride)
    -- Split the string into a table of strings
    local allIds = strsplittable(",", AllIdStrings)

    -- Create a hash set for all existing IDs
    for i = 1, #allIds do
      allIdsSet[allIds[i]] = true
    end

    -- Table to store the new ids
    local newIds = {}
    -- Add all the ids to the allIds table
    for id in pairs(dataOverride) do
      if not allIdsSet[tostring(id)] then
        -- Print what we found
        -- if not Database.debugLoadStaticEnabled and Database.debugPrintEnabled and Database.debugEnabled then
        --   LibQuestieDB.ColorizePrint("reputationBlue", "  Adding new ID", id)
        -- end
        tInsert(newIds, id)
      end
    end

    -- Wipe it for the next call
    -- Do it at the end so when it is called the last time it is wiped.
    wipe(allIdsSet)
    return newIds
  end
end

--*-------------------------------------------
--*--- Dynamic Loading of Datafiles
--*-------------------------------------------
do
  -- This function loads the datafile list for the given frame name.
  -- Frames are defined in xml e.g: Database\Quest\Era\QuestDataFiles.xml
  -- Which in turn points to e.g: Database\Quest\Era\QuestDataTemplates.html
  -- This in turn contains a list of framenames corresponding to datafiles available to load
  ---@type table<"QuestData"|"ItemData"|"ObjectData"|"NpcData", string[]> @Contains a lookuplist for loaded files
  local fileCache = {}
  ---@param FrameName "QuestData"|"ItemData"|"ObjectData"|"NpcData"
  ---@return string[] @Contains a list of datafiles
  function Database.LoadDatafileList(FrameName)
    if fileCache[FrameName] then
      return fileCache[FrameName]
    end

    -- Create a new UI Frame to load data from
    local dataFilenameFrame = CreateFrame(frameType, nil, nil, FrameName .. "Files")
    dataFilenameFrame:Hide()

    -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
    ---@type FontString[]
    local dataFilenameRegions = { dataFilenameFrame:GetRegions(), --[[@as FontString]] }
    local combinedString = ""
    for i = 1, #dataFilenameRegions do
      combinedString = combinedString .. dataFilenameRegions[i]:GetText()
    end
    fileCache[FrameName] = strsplittable(",", combinedString)
    return fileCache[FrameName]
  end
end

do
  ---@type table<"QuestData"|"ItemData"|"ObjectData"|"NpcData"|"L10nData", fun():QuestId[]|fun():NpcId[]|fun():ObjectId[]|fun():ItemId[]>
  local entityFunctions = {}
  local rawEntiryIdString = {}
  --- This function returns a function that returns a list of ids for the given entity type
  ---@param entityType "Quest"|"Item"|"Object"|"Npc"|"l10n"
  ---@return fun():QuestId[]|fun():NpcId[]|fun():ObjectId[]|fun():ItemId[]
  ---@return string @The raw string of ids
  function Database.GetAllEntityIdsFunction(entityType)
    if not entityFunctions[entityType] then
      if not Database.entityTypes[entityType] then
        error("Invalid entityType: " .. entityType)
      end
      -- Create a new UI Frame to load data from
      local idDataFilenameFrame = CreateFrame(frameType, nil, nil, entityType .. "DataIds")
      idDataFilenameFrame:Hide()

      -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
      ---@type FontString[]
      local idDataRegions = { idDataFilenameFrame:GetRegions(), --[[@as FontString]] }
      local combinedString = ""
      for i = 1, #idDataRegions do
        combinedString = combinedString .. idDataRegions[i]:GetText()
      end
      entityFunctions[entityType] = "return {" .. combinedString .. "}"
      rawEntiryIdString[entityType] = combinedString
    end
    -- Doing loadstring here should be faster than strsplittable due to us wanting the ids as numbers
    -- strsplittable just returns a table of strings
    return loadstring(entityFunctions[entityType]) --[=[@as fun():QuestId[]|fun():NpcId[]|fun():ObjectId[]|fun():ItemId[]=], rawEntiryIdString[entityType]
  end
end
do
  ---Contains a lookuplist for loaded files
  ---@type table<number, boolean>
  local loadedFiles = {}
  -- Used to return an empty table instead of nil
  ---@type table<number, table<number, FontString>>
  local emptyTable = LibQuestieDB.CreateReadOnlyEmptyTable()

  local rawset = rawset
  ---comment
  ---@param fileTemplateName string? @The name of the file to load
  ---@param out_globToWrite table<QuestId|NpcId|ObjectId|ItemId|number, table<number, FontString>> @The table to write the data to
  ---@param idToGet number @The id to get from the file
  ---@return table<QuestId|NpcId|ObjectId|ItemId|number, table<number, FontString>> @returns loaded data quest/npc/object/item
  function Database.LoadFile(fileTemplateName, out_globToWrite, idToGet)
    -- File does not exist or is already loaded
    if not fileTemplateName or loadedFiles[fileTemplateName] then
      return emptyTable
    end
    ---@type table<QuestId|NpcId|ObjectId|ItemId|number, table<number, FontString>>
    local retEntryData = out_globToWrite or {}
    -- Creating a frame for each file and reading data
    local dataFrame = CreateFrame(frameType, nil, nil, fileTemplateName)
    ---@type FontString[]
    local dataRegions = { dataFrame:GetRegions(), --[[@as FontString]] }

    -- This is very important to prevent the frame from updating and causing lag
    -- dataFrame:SetScript("OnUpdate", nil)
    dataFrame:Hide()
    -- dataFrame:UnregisterAllEvents()

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
        ---@type table<number, table<number, FontString>|FontString>
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
          ---@type FontString
          local data = dataRegions[dataRegionsIndex + count]
          if data and dataIndexNumber then
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
                -- Replace the table with a function that returns the concatenated string
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
                    -- local concatenatedString = tConcat(ret)
                    -- entryData[dataIndexNumber].GetText = function()
                    --   return concatenatedString
                    -- end
                    return tConcat(ret)
                  end,
                }
              end
            else
              entryData[dataIndexNumber] = data
            end
          end
          count = count + 1
        end
        -- retEntryData[dataId] = entryData
        retEntryData = rawset(retEntryData, dataId, entryData)
        -- Jump to the next entry (The + 1 jumps from the last datapoint onto the next entry)
        dataRegionsIndex = dataRegionsIndex + count
      else
        error("Invalid id: " .. id)
      end
    end
    loadedFiles[fileTemplateName] = true
    return retEntryData[idToGet] or emptyTable
  end
end

--- Function to create a binary search function for finding data in ranges
--- Takes the input from a file like Database\Quest\Era\QuestDataTemplates.html
--- The file contains a list of ranges like "QuestData1-100,QuestData101-200,QuestData201-300"
---
--- @param rawDataRanges string[] @The raw data ranges to parse
--- @return fun(number):string @The binary search function for finding data in ranges
function Database.CreateFindDataBinarySearchFunction(rawDataRanges)
  -- Table to store the parsed data ranges
  local dataRanges = {}

  -- Parse the raw data ranges and store them in the dataRanges table
  for i = 1, #rawDataRanges do
    local str = rawDataRanges[i]
    local startRange, endRange = str:match("(%d+)%-(%d+)$")
    if startRange and endRange then
      startRange = tonumber(startRange)
      endRange = tonumber(endRange)
      if startRange and endRange then
        dataRanges[startRange] = str
      else
        error("Invalid range: " .. str)
      end
    end
  end

  -- Table to store the sorted keys
  local sortedKeys = {}
  -- Length of the sortedKeys table
  local sortedKeyLength = 0
  -- Populate the sortedKeys table with the keys from the dataRanges table
  for k in pairs(dataRanges) do
    table.insert(sortedKeys, k)
  end
  -- Sort the keys in ascending order
  table.sort(sortedKeys)
  -- Update the sortedKeyLength
  sortedKeyLength = #sortedKeys

  -- Function to perform binary search on a sorted array
  local function findDataBinarySearch(number)
    local low, high = 1, sortedKeyLength

    while low <= high do
      -- local mid = math.floor((low + high) / 2) -- Calculate the middle index
      --* Floor function
      -- Using mod instead of floor is about 300% faster
      local mid = (low + high) / 2
      mid = mid - mid % 1         -- Quicker: Round down to nearest integer

      local key = sortedKeys[mid] -- Get the key at the middle index

      -- Check if the number is within the range of the current key
      if number >= key and (mid == sortedKeyLength or number < sortedKeys[mid + 1]) then
        return dataRanges[key] -- Return the data range associated with the key
      elseif number < key then
        high = mid - 1         -- Adjust the high index to search the lower half
      else
        low = mid + 1          -- Adjust the low index to search the upper half
      end
    end

    return nil -- Return nil if the number is not found
  end

  -- Return the findDataBinarySearch function
  return findDataBinarySearch
end

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


--*-------------------------------------------
--*--- Full Database Initialization
--*-------------------------------------------

-- --- Initialize a database frame and load the data into a table
-- ---@param FrameName "QuestData"|"ItemData"|"ObjectData"|"NpcData"
-- ---@return table<QuestId|NpcId|ObjectId|ItemId|number, table<number, FontString>> @Data
-- ---@return number @Total count of entries
-- ---@return number @Total count of files
-- function Database.InitializeDB(FrameName, yield)
--   ---@type table<QuestId|NpcId|ObjectId|ItemId|number, table<number, FontString>>
--   local retEntryData = {}
--   local totalCount = 0
--   local totalFiles = 0

--   -- Create a new UI Frame to load data from
--   local dataFilenameFrame = CreateFrame(frameType, nil, nil, FrameName .. "Files")
--   dataFilenameFrame:Hide()

--   -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
--   ---@type FontString[]
--   local dataFilenameRegions = { dataFilenameFrame:GetRegions() --[[@as FontString]] }
--   local combinedString = ""
--   for i = 1, #dataFilenameRegions do
--     combinedString = combinedString .. dataFilenameRegions[i]:GetText()
--   end
--   local files = strsplittable(",", combinedString)

--   -- Iterating over all files
--   for fileIndex = 1, #files do
--     totalFiles = totalFiles + 1

--     -- Creating a frame for each file and reading data
--     local dataFrame = CreateFrame(frameType, nil, nil, files[fileIndex])
--     ---@type FontString[]
--     local dataRegions = { dataFrame:GetRegions() --[[@as FontString]] }

--     -- This is very important to prevent the frame from updating and causing lag
--     -- dataFrame:SetScript("OnUpdate", nil)
--     dataFrame:Hide()
--     -- dataFrame:UnregisterAllEvents()

--     -- The first element contains a list of ids by index for the data
--     -- local idLookupData = dataRegions[1]:GetText()
--     -- This means we start at index 2 for the data
--     local dataRegionsIndex = 2
--     local idLookupData = strsplittable(",", dataRegions[1]:GetText())

--     -- Iterating over all ids in idLookupData
--     for idIndex = 1, #idLookupData do
--       -- Data id string is the id of the data, such as questId, npcId, etc.
--       local id = idLookupData[idIndex]

--       -- Such as questId, npcId, etc.
--       local dataId = tonumber(id)
--       if dataId then
--         -- Contains the frame-handles for the data (The GetText functions)
--         ---@type table<number, table<number, FontString>|FontString>
--         local entryData = {}

--         --? The first element contains a list of indexes for the data
--         --? e.g Name is index 1, Level is index 2, etc.
--         -- Loop the indexdata and add the data at the correct index to the entryData table
--         local dataIndexString = dataRegions[dataRegionsIndex]:GetText()
--         local count = 1

--         ---@param partIndex string @The index of the segmented data or "e" for end
--         for dataIndex, partIndex in gMatch(dataIndexString, "(%d+)-*(%w*)") do
--           local dataIndexNumber = tonumber(dataIndex)

--           -- Frame Data object (The one with GetText)
--           local data = dataRegions[dataRegionsIndex + count]
--           if data then
--             if partIndex ~= "" then
--               -- We create a list of functions to call when we want to get the data
--               -- Load all the segmented data into a table ending with the e partIndex
--               if partIndex ~= "e" then
--                 --? Numbered Segmented data
--                 if not entryData[dataIndexNumber] then
--                   entryData[dataIndexNumber] = {}
--                 end
--                 entryData[dataIndexNumber][tonumber(partIndex)] = data
--               else
--                 --? End of Segmented data (The last element)
--                 -- Add the last element to the list
--                 entryData[dataIndexNumber][#entryData[dataIndexNumber] + 1] = data
--                 -- Create the function that will be called when we want to get the data
--                 local segments = entryData[dataIndexNumber]
--                 -- Replace the table with a function that returns the concatenated string
--                 entryData[dataIndexNumber] = {
--                   -- This emulates the frame function name so we can use the same code for both
--                   GetText = function()
--                     -- TO DO: Is tConcat faster than ..?
--                     local ret = {}
--                     for i = 1, #segments do
--                       ret[i] = segments[i]:GetText()
--                     end
--                     --? Can this become polymorphic and cache the result?
--                     --? This could be unnecessary due to most data that is big is just fetched once and used.
--                     -- local concatenatedString = tConcat(ret)
--                     -- entryData[dataIndexNumber].GetText = function()
--                     --   return concatenatedString
--                     -- end
--                     return tConcat(ret)
--                   end
--                 }
--               end
--             else
--               entryData[dataIndexNumber] = data
--             end
--           end
--           count = count + 1
--         end
--         retEntryData[dataId] = entryData
--         -- Jump to the next entry (The + 1 jumps from the last datapoint onto the next entry)
--         dataRegionsIndex = dataRegionsIndex + count

--         totalCount = totalCount + 1
--         if yield then
--           if totalCount % yield == 0 then
--             coYield()
--           end
--         end
--       else
--         error("Invalid " .. FrameName .. " id: " .. id)
--       end
--     end
--   end
--   C_Timer.After(0.5, function()
--     -- This is very important to prevent the frame from updating and causing lag
--     -- dataFilenameFrame:SetScript("OnUpdate", nil)
--     dataFilenameFrame:Hide()
--     -- dataFilenameFrame:UnregisterAllEvents()
--     dataFilenameFrame = nil
--   end)

--   return retEntryData, totalCount, totalFiles
-- end
-- function Database.Init(yield)
--   local start = time()
--   print("-- Database Initialization --")
--   -- Quest
--   debugprofilestart()
--   local questData, questCount, fileQuestCount = Database.InitializeDB("QuestData")
--   Quest.Initialize(questData)
--   if Database.debugEnabled then
--     local msTime = debugprofilestop()
--     LibQuestieDB.ColorizePrint("green", "Quest data database loaded:  #(", questCount, ") files(", fileQuestCount, ") ",
--       format("%.2f", msTime / 1000), "s")
--     print("    ", format("%.6f", (msTime) / questCount), "ms per quest")
--     print("    ", format("%.4f", msTime), "ms")
--   end
--   -- Object
--   debugprofilestart()
--   local objectData, objectCount, fileObjectCount = Database.InitializeDB("ObjectData")
--   Object.Initialize(objectData)
--   if Database.debugEnabled then
--     local msTime = debugprofilestop()
--     LibQuestieDB.ColorizePrint("green", "Object data database loaded:  #(", objectCount, ") files(", fileObjectCount, ") ",
--       format("%.2f", msTime / 1000), "s")
--     print("    ", format("%.6f", (msTime) / objectCount), "ms per object")
--     print("    ", format("%.4f", msTime), "ms")
--   end
--   -- Npc
--   debugprofilestart()
--   local npcData, npcCount, fileNpcCount = Database.InitializeDB("NpcData", yield)
--   Npc.Initialize(npcData, QuestieNPCFixes:LoadFactionFixes(), QuestieDB.npcKeys)
--   if Database.debugEnabled then
--     local msTime = debugprofilestop()
--     LibQuestieDB.ColorizePrint("green", "Npc data database loaded:  #(", npcCount, ") files(", fileNpcCount, ") ",
--       format("%.2f", msTime / 1000), "s")
--     print("    ", format("%.6f", (msTime) / npcCount), "ms per npc")
--     print("    ", format("%.4f", msTime), "ms")
--   end
--   -- Item
--   debugprofilestart()
--   local itemData, itemCount, fileItemCount = Database.InitializeDB("ItemData", yield)
--   Item.Initialize(itemData, QuestieItemFixes:LoadFactionFixes(), QuestieDB.itemKeys)
--   if Database.debugEnabled then
--     local msTime = debugprofilestop()
--     LibQuestieDB.ColorizePrint("green", "Item data database loaded:  #(", itemCount, ") files(", fileItemCount, ") ",
--       format("%.2f", msTime / 1000), "s")
--     print("    ", format("%.6f", (msTime) / itemCount), "ms per item")
--     print("    ", format("%.4f", msTime), "ms")
--   end
--   print("Total time elapsed:", time() - start, "s")
--   Database.Initialized = true
-- end
