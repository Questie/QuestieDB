---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

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

