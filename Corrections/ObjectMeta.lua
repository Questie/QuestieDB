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
