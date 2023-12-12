local _,
---@class QuestieSDB
QuestieSDB = ...

local tInsert = table.insert
Npc.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 15
  local count = 0
  for id in pairs(Npc.GetAllNpcIds()) do
    Npc.lastTestedID = id
    count = count + 1
    local data = {}
    tInsert(data, "Testing Npc " .. id)

    -- Test Npc.name
    tInsert(data, "Name: " .. (Npc.name(id) or "nil"))

    -- Test Npc.minLevelHealth
    tInsert(data, "Min Level Health: " .. (Npc.minLevelHealth(id) or "nil"))

    -- Test Npc.maxLevelHealth
    tInsert(data, "Max Level Health: " .. (Npc.maxLevelHealth(id) or "nil"))

    -- Test Npc.minLevel
    tInsert(data, "Min Level: " .. (Npc.minLevel(id) or "nil"))

    -- Test Npc.maxLevel
    tInsert(data, "Max Level: " .. (Npc.maxLevel(id) or "nil"))

    -- Test Npc.rank
    tInsert(data, "Rank: " .. (Npc.rank(id) or "nil"))

    -- Test Npc.spawns
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
    tInsert(data, "Zone ID: " .. (Npc.zoneID(id) or "nil"))

    -- Test Npc.questStarts
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
    tInsert(data, "Faction ID: " .. (Npc.factionID(id) or "nil"))

    -- Test Npc.friendlyToFaction
    tInsert(data, "Friendly to Faction: " .. (Npc.friendlyToFaction(id) or "nil"))

    -- Test Npc.subName
    tInsert(data, "Sub Name: " .. (Npc.subName(id) or "nil"))

    -- Test Npc.npcFlags
    tInsert(data, "NPC Flags: " .. (Npc.npcFlags(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end
  local time = debugprofilestop()
  QuestieSDB.ColorizePrint("green", "Npc Test Done", time, "ms")
  print("  ", count, "npcs tested")
  print("  ", "time per npc:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
