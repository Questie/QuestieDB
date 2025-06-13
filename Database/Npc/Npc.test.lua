---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Npc
---@field RunGetTest fun(fast: boolean)
---@field package testGetFunctions fun(fast: boolean)
---@field package lastTestedID NpcId
---@field package lastTestedData string
local Npc = LibQuestieDB.Npc

Npc.RunGetTest = function(fast)
  local success, err = pcall(Npc.testGetFunctions, fast)
  if not success then
    print("NPC test failed: " .. err)
    print("Last tested NpcId: " .. tostring(Npc.lastTestedID))
    print("Last tested Npc function: " .. tostring(Npc.lastTestedData))
    error("NPC test failed: " .. err)
  end
end

local tInsert = table.insert
Npc.testGetFunctions = function(fast)
  debugprofilestart()
  local beginTime = debugprofilestop()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Meta.NpcMeta.npcKeys) do
    functions = functions + 1
  end

  local perFunctionPerformance = {}

  local count = 0
  for id in pairs(Npc.GetAllIds()) do
    Npc.lastTestedID = id
    Npc.lastTestedData = ""
    count = count + 1
    local data = {}
    local time = 0
    local runTime = 0
    tInsert(data, "Testing Npc " .. id)

    -- Test Npc.name
    Npc.lastTestedData = "name"
    time = debugprofilestop()
    tInsert(data, "Name: " .. (Npc.name(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.minLevelHealth
    Npc.lastTestedData = "minLevelHealth"
    time = debugprofilestop()
    tInsert(data, "Min Level Health: " .. (Npc.minLevelHealth(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.maxLevelHealth
    Npc.lastTestedData = "maxLevelHealth"
    time = debugprofilestop()
    tInsert(data, "Max Level Health: " .. (Npc.maxLevelHealth(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.minLevel
    Npc.lastTestedData = "minLevel"
    time = debugprofilestop()
    tInsert(data, "Min Level: " .. (Npc.minLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.maxLevel
    Npc.lastTestedData = "maxLevel"
    time = debugprofilestop()
    tInsert(data, "Max Level: " .. (Npc.maxLevel(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.rank
    Npc.lastTestedData = "rank"
    time = debugprofilestop()
    tInsert(data, "Rank: " .. (Npc.rank(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.spawns
    Npc.lastTestedData = "spawns"
    time = debugprofilestop()
    local spawns = Npc.spawns(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local waypoints = Npc.waypoints(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Zone ID: " .. (Npc.zoneID(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.questStarts
    Npc.lastTestedData = "questStarts"
    time = debugprofilestop()
    local questStarts = Npc.questStarts(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    local questEnds = Npc.questEnds(id)
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime
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
    time = debugprofilestop()
    tInsert(data, "Faction ID: " .. (Npc.factionID(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.friendlyToFaction
    Npc.lastTestedData = "friendlyToFaction"
    time = debugprofilestop()
    tInsert(data, "Friendly to Faction: " .. (Npc.friendlyToFaction(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.subName
    Npc.lastTestedData = "subName"
    time = debugprofilestop()
    tInsert(data, "Sub Name: " .. (Npc.subName(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    -- Test Npc.npcFlags
    Npc.lastTestedData = "npcFlags"
    time = debugprofilestop()
    tInsert(data, "NPC Flags: " .. (Npc.npcFlags(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Npc.lastTestedData] = (perFunctionPerformance[Npc.lastTestedData] or 0) + runTime

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop() - beginTime
  LibQuestieDB.ColorizePrint("green", "Npc Test Done", time, "ms")
  print("  ", count, "npcs tested")
  print("  ", "time per npc:", tostring(time / count):sub(1, 6), "ms")
  print("  ", "avg time per function", tostring(time / (count * functions)):sub(1, 6), "ms")
  for i, functionName in ipairs(LibQuestieDB.Meta.NpcMeta.NameIndexLookupTable) do
    local v = perFunctionPerformance[functionName] or 0
    print("    ", i, functionName, ":", tostring((v / count) * 1000):sub(1, 6), "µs")
  end
end
