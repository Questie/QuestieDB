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
  else   -- number
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
  return result .. "}"
end

-- [1950] = {
--     [questKeys.triggerEnd] = {"Secret phrase found", {[zoneIDs.THOUSAND_NEEDLES]={{79.56,75.65}}}},
-- },
function DumpFunctions.dumpTriggerEnd(tbl)
  local result = "{"
  result = result .. DumpFunctions.dump(tbl[1]) .. ","
  result = result .. DumpFunctions.dumpCoordiates(tbl[2])
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
      else   -- number
        result = result .. DumpFunctions.dump(objective)
      end
      if i < #objectiveData then
        result = result .. ","
      end
    end
    result = result .. "},"
  end
  return result .. "}"
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
      "{[1335]={{36.43,55.89},{31.43,57.03}},[1]={{1,2}},}",
    },
    {
      DumpFunctions.dumpTriggerEnd({ "Secret phrase found", { [1336] = { { 79.56, 75.65, }, }, }, }),
      "{'Secret phrase found',{[1336]={{79.56,75.65}},}}",
    },
    {
      DumpFunctions.dumpExtraObjectives({ { { [1337] = { { 35.71, 44.68, }, }, }, "ICON_TYPE_EVENT", "Fish for Darkshore Groupers", }, }),
      "{{{[1337]={{35.71,44.68}},},'ICON_TYPE_EVENT','Fish for Darkshore Groupers'},}",
    },
    {
      DumpFunctions.dumpExtraObjectives({ { nil, "ICON_TYPE_OBJECT", "Use a Fresh Carcass at the Flame of Uzel", 0, { { "object", 1770, }, }, }, }),
      "{{nil,'ICON_TYPE_OBJECT','Use a Fresh Carcass at the Flame of Uzel',0,{{'object',1770}}},}",
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
