---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Npc
---@field FastTest fun()
local Npc = LibQuestieDB.Npc

local Database = LibQuestieDB.Database

-- Test data for NPC ID 3 (Flesh Eater)
-- <!-- 3 -->
-- <p>1,2,3</p>
-- <p>Flesh Eater</p>
-- <p>664;713;24;25;0;10;21;;0</p>
-- <p>{[10]={{25.06,38.2},{25.37,36.04},{25.69,34.45},{23.81,39.21},{22.81,39.09},{22.04,32.62},{21.7,38.3},{22.2,36.96},{25.37,39.03}}}</p>

-- This function is a quick sanity check to run on startup.
-- It verifies that the database is returning reasonable values for a known NPC (ID 3).
function Npc.FastTest()
  local id = 3

  local name = Npc.name(id)
  assert(type(name) == "string" and name == "Flesh Eater", "[Npc.test.simple] Name should be 'Flesh Eater'")

  local minLevelHealth = Npc.minLevelHealth(id)
  assert(type(minLevelHealth) == "number" and minLevelHealth > 400, "[Npc.test.simple] minLevelHealth should be larger than 400")

  local maxLevelHealth = Npc.maxLevelHealth(id)
  assert(type(maxLevelHealth) == "number" and maxLevelHealth > 400, "[Npc.test.simple] maxLevelHealth should be larger than 400")

  local minLevel = Npc.minLevel(id)
  assert(type(minLevel) == "number" and minLevel > 18, "[Npc.test.simple] minLevel should be larger than 18")

  local maxLevel = Npc.maxLevel(id)
  assert(type(maxLevel) == "number" and maxLevel > 20, "[Npc.test.simple] maxLevel should be larger than 20")

  local rank = Npc.rank(id)
  assert(type(rank) == "number" and rank == 0, "[Npc.test.simple] rank should be 0")

  local zoneID = Npc.zoneID(id)
  assert(type(zoneID) == "number" and zoneID == 10, "[Npc.test.simple] zoneID should be 10")

  local factionID = Npc.factionID(id)
  assert(type(factionID) == "number" and factionID == 21, "[Npc.test.simple] factionID should be 21")

  local friendlyToFaction = Npc.friendlyToFaction(id)
  assert(friendlyToFaction == nil, "[Npc.test.simple] friendlyToFaction should be nil")

  local npcFlags = Npc.npcFlags(id)
  assert(type(npcFlags) == "number" and npcFlags == 0, "[Npc.test.simple] npcFlags should be 0")

  local spawns = Npc.spawns(id)
  assert(type(spawns) == "table", "[Npc.test.simple] spawns should be a table")
  assert(spawns[10], "[Npc.test.simple] spawns should have entry for zone 10")
  assert(#spawns[10] > 0, "[Npc.test.simple] spawns[10] should have coordinates")
  assert(type(spawns[10][1]) == "table" and #spawns[10][1] == 2, "[Npc.test.simple] spawns[10][1] should be a CoordPair")

  local waypoints = Npc.waypoints(id)
  assert(waypoints == nil, "[Npc.test.simple] waypoints should be nil")

  local questStarts = Npc.questStarts(id)
  assert(questStarts == nil, "[Npc.test.simple] questStarts should be nil")

  local questEnds = Npc.questEnds(id)
  assert(questEnds == nil, "[Npc.test.simple] questEnds should be nil")

  local subName = Npc.subName(id)
  assert(subName == nil, "[Npc.test.simple] subName should be nil")

  if Database.debugPrintEnabled or Database.debugEnabled then
    LibQuestieDB.ColorizePrint("green", "  [Npc.test.simple] TestNpc passed for ID " .. id)
  end
end
