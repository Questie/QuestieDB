---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Npc
---@field RunGetTest fun(fast: boolean)
---@field package testGetFunctions fun(fast: boolean)
---@field package lastTestedID NpcId
---@field package lastTestedData string
local Npc = LibQuestieDB.Npc

Npc.RunGetTest = function(fast)
  local success, error = pcall(Npc.testGetFunctions, fast)
  if not success then
    print("NPC test failed: " .. error)
    print("Last tested NPC: " .. tostring(Npc.lastTestedID))
    print("Last tested NPC function: " .. tostring(Npc.lastTestedData))
  end
end

local tInsert = table.insert
Npc.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 15
  local count = 0
  for id in pairs(Npc.GetAllIds()) do
    Npc.lastTestedID = id
    Npc.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing Npc " .. id)

    -- Test Npc.name
    Npc.lastTestedData = "name"
    tInsert(data, "Name: " .. (Npc.name(id) or "nil"))

    -- Test Npc.minLevelHealth
    Npc.lastTestedData = "minLevelHealth"
    tInsert(data, "Min Level Health: " .. (Npc.minLevelHealth(id) or "nil"))

    -- Test Npc.maxLevelHealth
    Npc.lastTestedData = "maxLevelHealth"
    tInsert(data, "Max Level Health: " .. (Npc.maxLevelHealth(id) or "nil"))

    -- Test Npc.minLevel
    Npc.lastTestedData = "minLevel"
    tInsert(data, "Min Level: " .. (Npc.minLevel(id) or "nil"))

    -- Test Npc.maxLevel
    Npc.lastTestedData = "maxLevel"
    tInsert(data, "Max Level: " .. (Npc.maxLevel(id) or "nil"))

    -- Test Npc.rank
    Npc.lastTestedData = "rank"
    tInsert(data, "Rank: " .. (Npc.rank(id) or "nil"))

    -- Test Npc.spawns
    Npc.lastTestedData = "spawns"
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
    Npc.lastTestedData = "waypoints"
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
    Npc.lastTestedData = "zoneID"
    tInsert(data, "Zone ID: " .. (Npc.zoneID(id) or "nil"))

    -- Test Npc.questStarts
    Npc.lastTestedData = "questStarts"
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
    Npc.lastTestedData = "questEnds"
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
    Npc.lastTestedData = "factionID"
    tInsert(data, "Faction ID: " .. (Npc.factionID(id) or "nil"))

    -- Test Npc.friendlyToFaction
    Npc.lastTestedData = "friendlyToFaction"
    tInsert(data, "Friendly to Faction: " .. (Npc.friendlyToFaction(id) or "nil"))

    -- Test Npc.subName
    Npc.lastTestedData = "subName"
    tInsert(data, "Sub Name: " .. (Npc.subName(id) or "nil"))

    -- Test Npc.npcFlags
    Npc.lastTestedData = "npcFlags"
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
