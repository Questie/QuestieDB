---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Object
---@field FastTest fun()
local Object = LibQuestieDB.Object

local Database = LibQuestieDB.Database

-- Test data for Object ID 76 (An Empty Jar)
-- <!-- 76 -->
-- <p>1,3,4,5</p>
-- <p>An Empty Jar</p>
-- <p>{248}</p>
-- <p>{[44]={{57.02,45.67}}}</p>
-- <p>44</p>

-- This function is a quick sanity check to run on startup.
-- It verifies that the database is returning reasonable values for a known Object (ID 76).
function Object.FastTest()
  local id = 76

  local name = Object.name(id)
  assert(type(name) == "string" and name == "An Empty Jar", "[Object.test.simple] Name should be 'An Empty Jar'")

  local questStarts = Object.questStarts(id)
  assert(questStarts == nil, "[Object.test.simple] questStarts should be nil")

  local questEnds = Object.questEnds(id)
  assert(type(questEnds) == "table", "[Object.test.simple] questEnds should be a table")
  assert(#questEnds == 1, "[Object.test.simple] questEnds should have 1 entry")
  assert(questEnds[1] == 248, "[Object.test.simple] questEnds[1] should be 248")

  local spawns = Object.spawns(id)
  assert(type(spawns) == "table", "[Object.test.simple] spawns should be a table")
  assert(spawns[44], "[Object.test.simple] spawns should have entry for zone 44")
  assert(#spawns[44] > 0, "[Object.test.simple] spawns[44] should have coordinates")

  local zoneID = Object.zoneID(id)
  assert(type(zoneID) == "number" and zoneID == 44, "[Object.test.simple] zoneID should be 44")

  local factionID = Object.factionID(id)
  assert(factionID == nil, "[Object.test.simple] factionID should be nil")

  local waypoints = Object.waypoints(id)
  assert(waypoints == nil, "[Object.test.simple] waypoints should be nil")

  if Database.debugPrintEnabled or Database.debugEnabled then
    LibQuestieDB.ColorizePrint("green", "  [Object.test.simple] TestObject passed for ID " .. id)
  end
end
