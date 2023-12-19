---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class ObjectMeta
local ObjectMeta = {}

-- Add ObjectMeta
---@class Corrections
local Corrections = LibQuestieDB.Corrections
Corrections.ObjectMeta = ObjectMeta


---@class ObjectDBKeys @ Contains name of data as keys and their index as value
ObjectMeta.objectKeys = {
  ['name'] = 1,        -- string
  ['questStarts'] = 2, -- table {questID(int),...}
  ['questEnds'] = 3,   -- table {questID(int),...}
  ['spawns'] = 4,      -- table {[zoneID(int)] = {coordPair(floatVector2D),...},...}
  ['zoneID'] = 5,      -- guess as to where this object is most common
  ['factionID'] = 6,   -- faction restriction mask (same as spawndb factionid)
}
-- Contains the type of data as keys and their index as value
ObjectMeta.objectTypes = {
  ['name'] = "string",
  ['questStarts'] = "table",
  ['questEnds'] = "table",
  ['spawns'] = "table",
  ['zoneID'] = "number",
  ['factionID'] = "number",
}
-- Add the index keys to objectTypes
for key, index in pairs(ObjectMeta.objectKeys) do
  ObjectMeta.objectTypes[index] = ObjectMeta.objectTypes[key]
end

-- Used for dumping the database
ObjectMeta.dumpFuncs = {
  ['name'] = DumpFunctions.dump,
  ['questStarts'] = DumpFunctions.dumpAsArray,
  ['questEnds'] = DumpFunctions.dumpAsArray,
  ['spawns'] = DumpFunctions.dumpCoordiates,
  ['zoneID'] = DumpFunctions.dump,
  ['factionID'] = DumpFunctions.dump,
}

-- Localize these variables to clean up the code
do
  -- This combines the values that are going to be converted into a string
  -- The lowest index is the one that will be replaced with the combined string
  local combineValues = {}

  -- Combine all values into one string 0;0;0;0;;
  -- where numbers become 0 if they are nil and strings become empty such as 0;<string>;0
  ---@param tbl table<number, any> @ Table that will be modified
  ---@return table<number, any> @ Returns the table inputted with the combined value
  ---@return string @ Returns the combined value string that was inserted into the table
  function ObjectMeta.combine(tbl)
    return DumpFunctions.combine(tbl, combineValues, ObjectMeta.objectTypes)
  end
end
