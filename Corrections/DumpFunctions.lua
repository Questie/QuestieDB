---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class DumpFunctions
local DumpFunctions = {}

-- Add DumpFunctions
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.DumpFunctions = DumpFunctions

local type, pairs = type, pairs
local gsub = string.gsub
local tInsert = table.insert
local tRemove = table.remove
local tSort = table.sort

function DumpFunctions.tblMaxIndex(tbl)
  local maxPairsIndex = 0
  for key in pairs(tbl) do
    if type(key) == "number" then
      if key > maxPairsIndex then
        maxPairsIndex = key
      end
    end
  end
  return math.max(maxPairsIndex, #tbl)
end

local tblMaxIndex = DumpFunctions.tblMaxIndex

function DumpFunctions.tblCount(tbl)
  local count = 0
  for _ in pairs(tbl) do
    count = count + 1
  end
  return count
end

local tblCount = DumpFunctions.tblCount

---comment
---@param val any
---@return string
function DumpFunctions.dump(val)
  if type(val) == "table" then
    return DumpFunctions.dumpAsArray(val)
  elseif type(val) == "nil" or val == nil then
    return "nil"
  elseif type(val) == "string" then
    -- escape single quotes
    val = gsub(val, "'", "\\'")
    return "'" .. tostring(val) .. "'"
  elseif type(val) == "boolean" then
    return tostring(val)
  else -- number
    return val
  end
end

-- Can take values such as {nil,nil,{16305}} and return with infill nils
function DumpFunctions.dumpAsArray(tbl)
  local result = "{"

  -- Sometimes the table is nil, so we need to check for that
  -- This is because we convert {} to "nil" in the database
  if tbl == "nil" or tbl == nil then
    return "nil"
  end

  -- This is a safeguard against tables that are not arrays
  local maxPairsIndex = tblMaxIndex(tbl)

  for i = 1, maxPairsIndex do
    local val = tbl[i]
    result = result .. DumpFunctions.dump(val)
    if i < maxPairsIndex then
      result = result .. ","
    end
  end
  return result .. "}"
end

-- Dumps coordinates in the format of { [zoneID] = { {x,y}, {x,y}, }, [zoneID] = { {x,y}, {x,y}, }, }
function DumpFunctions.dumpCoordiates(tbl)
  local result = "{"
  for zoneID, coords in pairs(tbl) do
    result = result .. "[" .. tostring(zoneID) .. "]={"
    for i, coord in ipairs(coords) do
      result = result .. DumpFunctions.dumpAsArray(coord)
      if i < #coords then
        result = result .. ","
      end
    end
    result = result .. "},"
  end
  result = result .. "}"
  -- Remove all instances of },} with }}
  result = gsub(result, "},}", "}}")
  return result
end

-- [1950] = {
--     [questKeys.triggerEnd] = {"Secret phrase found", {[zoneIDs.THOUSAND_NEEDLES]={{79.56,75.65}}}},
-- },
function DumpFunctions.dumpTriggerEnd(tbl)
  local result = "{"
  result = result .. DumpFunctions.dump(tbl[1]) .. ","
  if tbl[2] ~= nil and tbl[2] ~= "nil" then
    result = result .. DumpFunctions.dumpCoordiates(tbl[2])
  end
  return result .. "}"
end

-- [1136] = {
--     [questKeys.extraObjectives] = {{nil, ICON_TYPE_OBJECT, l10n("Use a Fresh Carcass at the Flame of Uzel"), 0, {{"object", 1770}}}},
-- },
-- [1141] = {
--     [questKeys.extraObjectives] = {
--       {
--         {[zoneIDs.DARKSHORE]={{35.71,44.68}
--       }
--     },
--     ICON_TYPE_EVENT,
--     l10n("Fish for Darkshore Groupers"),}},
-- },

-- Dumps quest extra objectives in the format of { { { [zoneID] = { {x,y}, }, }, iconType, text, objectiveIndex, { {dbReferenceType, id}, }, }, }
function DumpFunctions.dumpExtraObjectives(tbl)
  -- If the first value is a table, assume it is a zoneID table
  local result = "{"
  for _, objectiveData in ipairs(tbl) do
    result = result .. "{"
    local maxIndex = tblMaxIndex(objectiveData)
    for i = 1, maxIndex do
      local objective = objectiveData[i]
      if type(objective) == "table" then
        if i == 1 then
          result = result .. DumpFunctions.dumpCoordiates(objective)
        else
          result = result .. DumpFunctions.dumpAsArray(objective)
        end
      else -- number
        result = result .. DumpFunctions.dump(objective)
      end
      if i < #objectiveData then
        result = result .. ","
      end
    end
    result = result .. "},"
  end
  result = result .. "}"
  -- Remove all instances of },} with }}
  result = gsub(result, "},}", "}}")
  return result
end

-- Combine all values into one string 0;0;0;0;;
-- where numbers become 0 if they are nil and strings become empty such as 0;<string>;0
---@param tbl table<number, any> @ Table that will be modified
---@param combineValues table<number, string> @ Indexes of the values that will be combined and the name of the value
---@param tblTypes table<number|string, type> @ Get the type of the value from the table from the index
---@return table<number, any> @ Returns the table inputted with the combined value
---@return string @ Returns the combined value string that was inserted into the table
function DumpFunctions.combine(tbl, combineValues, tblTypes)
  -- Contains the length of the combineValues table
  local combineLength = tblCount(combineValues)
  -- Index of the value that will be replaced with the combined string
  local combineIndex = 999999

  local startTblLength = #tbl

  -- Calculate the lowest index
  for index in pairs(combineValues) do
    if index < combineIndex then
      combineIndex = index
    end
  end
  -- Sort the indexes
  local sortedKeys = {}
  for key in pairs(combineValues) do
    tInsert(sortedKeys, key)
  end
  tSort(sortedKeys)

  local result = ""
  for _, index in pairs(sortedKeys) do
    local val = tbl[index]
    if type(val) == "string" and tblTypes[index] == "string" then
      -- If the value is a string and is nil, replace it with an empty string
      if val == "nil" then
        val = ""
      end
      result = result .. val .. ";"
    elseif val == nil or val == "nil" then
      result = result .. "0;"
    else
      result = result .. val .. ";"
    end
  end
  -- Remove trailing semicolon
  result = string.sub(result, 1, -2)

  -- Remove all " or ' from the string
  result = gsub(result, '"', "")
  result = gsub(result, "'", "")

  -- Replace with the combined value
  tbl[combineIndex] = "'" .. result .. "'"

  -- Remove the indexes that were combined, they are not in order so we need to remove the highest index first
  tSort(sortedKeys, function(a, b) return a > b end)
  local removedIndexes = 0
  for _, index in pairs(sortedKeys) do
    if index ~= combineIndex then
      tRemove(tbl, index)
      removedIndexes = removedIndexes + 1
    end
  end
  local endTblLength = #tbl
  assert(startTblLength - endTblLength == combineLength - 1,
         "DumpFunctions.combine failed, incorrect length " .. startTblLength .. " " .. endTblLength .. " " .. combineLength)

  return tbl, result
end

function DumpFunctions.testDumpFunctions()
  local testTable = {
    {
      DumpFunctions.dumpAsArray({ nil, nil, { 16305, }, nil, { { { 7572, }, 7572, "The Tale of Sorrow", }, }, }),
      "{nil,nil,{16305},nil,{{{7572},7572,'The Tale of Sorrow'}}}",
    },
    {
      DumpFunctions.dump(1),
      -- "1",
      1,
    },
    {
      DumpFunctions.dump("string"),
      "'string'",
    },
    {
      DumpFunctions.dump(true),
      "true",
    },
    {
      DumpFunctions.dumpCoordiates({ [1335] = { { 36.43, 55.89, }, { 31.43, 57.03, }, }, [1] = { { 1, 2, }, }, }),
      "{[1335]={{36.43,55.89},{31.43,57.03}},[1]={{1,2}}}",
    },
    {
      DumpFunctions.dumpTriggerEnd({ "Secret phrase found", { [1336] = { { 79.56, 75.65, }, }, }, }),
      "{'Secret phrase found',{[1336]={{79.56,75.65}}}}",
    },
    {
      DumpFunctions.dumpExtraObjectives({ { { [1337] = { { 35.71, 44.68, }, }, }, "ICON_TYPE_EVENT", "Fish for Darkshore Groupers", }, }),
      "{{{[1337]={{35.71,44.68}}},'ICON_TYPE_EVENT','Fish for Darkshore Groupers'}}",
    },
    {
      DumpFunctions.dumpExtraObjectives({ { nil, "ICON_TYPE_OBJECT", "Use a Fresh Carcass at the Flame of Uzel", 0, { { "object", 1770, }, }, }, }),
      "{{nil,'ICON_TYPE_OBJECT','Use a Fresh Carcass at the Flame of Uzel',0,{{'object',1770}}}}",
    },
  }
  local allTestsPassed = true
  for _, test in ipairs(testTable) do
    if test[1] ~= test[2] then
      print("DumpFunctions.testDumpfunctions failed: \n" .. test[1] .. "\n~=\n" .. test[2])
      allTestsPassed = false
    end
  end
  assert(allTestsPassed, "DumpFunctions.testDumpFunctions failed")
end
