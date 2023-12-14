---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class Npc
local Npc = LibQuestieDB.Npc

local tInsert = table.insert
Npc.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 15
  local count = 0
  for id in pairs(Npc.GetAllNpcIds()) do
    Npc.lastTestedID = id
    Npc.lastTestedtData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing Npc " .. id)

    -- Test Npc.name
    Npc.lastTestedtData = "name"
    tInsert(data, "Name: " .. (Npc.name(id) or "nil"))

    -- Test Npc.minLevelHealth
    Npc.lastTestedtData = "minLevelHealth"
    tInsert(data, "Min Level Health: " .. (Npc.minLevelHealth(id) or "nil"))

    -- Test Npc.maxLevelHealth
    Npc.lastTestedtData = "maxLevelHealth"
    tInsert(data, "Max Level Health: " .. (Npc.maxLevelHealth(id) or "nil"))

    -- Test Npc.minLevel
    Npc.lastTestedtData = "minLevel"
    tInsert(data, "Min Level: " .. (Npc.minLevel(id) or "nil"))

    -- Test Npc.maxLevel
    Npc.lastTestedtData = "maxLevel"
    tInsert(data, "Max Level: " .. (Npc.maxLevel(id) or "nil"))

    -- Test Npc.rank
    Npc.lastTestedtData = "rank"
    tInsert(data, "Rank: " .. (Npc.rank(id) or "nil"))

    -- Test Npc.spawns
    Npc.lastTestedtData = "spawns"
    local spawns = Npc.spawns(id)
    if spawns then
      for zoneID, coords in pairs(spawns) do
        tInsert(data, "Spawns in Zone " .. zoneID .. ":")
        for _, coord in ipairs(coords) do
          tInsert(data, "  X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      tInsert(data, "Spawns: nil")
    end

    -- Test Npc.waypoints
    Npc.lastTestedtData = "waypoints"
    local waypoints = Npc.waypoints(id)
    if waypoints then
      for zoneID, waypointSegments in pairs(waypoints) do
        tInsert(data, "Waypoints in Zone " .. zoneID .. ":")
        for _, coords in ipairs(waypointSegments) do
          for _, coord in ipairs(coords) do
            tInsert(data, "  X: " .. coord[1] .. ", Y: " .. coord[2])
          end
        end
      end
    else
      tInsert(data, "Waypoints: nil")
    end

    -- Test Npc.zoneID
    Npc.lastTestedtData = "zoneID"
    tInsert(data, "Zone ID: " .. (Npc.zoneID(id) or "nil"))

    -- Test Npc.questStarts
    Npc.lastTestedtData = "questStarts"
    local questStarts = Npc.questStarts(id)
    if questStarts then
      tInsert(data, "Quest Starts:")
      for _, questID in ipairs(questStarts) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Starts: nil")
    end

    -- Test Npc.questEnds
    Npc.lastTestedtData = "questEnds"
    local questEnds = Npc.questEnds(id)
    if questEnds then
      tInsert(data, "Quest Ends:")
      for _, questID in ipairs(questEnds) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Ends: nil")
    end

    -- Test Npc.factionID
    Npc.lastTestedtData = "factionID"
    tInsert(data, "Faction ID: " .. (Npc.factionID(id) or "nil"))

    -- Test Npc.friendlyToFaction
    Npc.lastTestedtData = "friendlyToFaction"
    tInsert(data, "Friendly to Faction: " .. (Npc.friendlyToFaction(id) or "nil"))

    -- Test Npc.subName
    Npc.lastTestedtData = "subName"
    tInsert(data, "Sub Name: " .. (Npc.subName(id) or "nil"))

    -- Test Npc.npcFlags
    Npc.lastTestedtData = "npcFlags"
    tInsert(data, "NPC Flags: " .. (Npc.npcFlags(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end
  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "Npc Test Done", time, "ms")
  print("  ", count, "npcs tested")
  print("  ", "time per npc:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
