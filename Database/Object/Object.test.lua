---@type LibQuestieDB
local LibQuestieDB = select(2, ...)

---@class (exact) Object
---@field RunGetTest fun(fast: boolean)
---@field package testGetFunctions fun(fast: boolean)
---@field package lastTestedID ObjectId
---@field package lastTestedData string
local Object = LibQuestieDB.Object

Object.RunGetTest = function(fast)
  local success, err = pcall(Object.testGetFunctions, fast)
  if not success then
    print("Object test failed: " .. err)
    print("Last tested ObjectId: " .. tostring(Object.lastTestedID))
    print("Last tested Object function: " .. tostring(Object.lastTestedData))
    error("Object test failed: " .. err)
  end
end

local tInsert = table.insert
Object.testGetFunctions = function(fast)
  debugprofilestart()
  local beginTime = debugprofilestop()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Meta.ObjectMeta.objectKeys) do
    functions = functions + 1
  end

  local perFunctionPerformance = {}

  local count = 0
  for id in pairs(Object.GetAllIds()) do
    Object.lastTestedID = id
    Object.lastTestedData = ""
    count = count + 1
    local data = {}
    local time = 0
    local runTime = 0
    tInsert(data, "Testing Object " .. id)

    -- Test Object.name
    Object.lastTestedData = "name"
    time = debugprofilestop()
    tInsert(data, "Name: " .. (Object.name(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

    -- Test Object.questStarts
    Object.lastTestedData = "questStarts"
    time = debugprofilestop()
    local questStarts = Object.questStarts(id)
    if questStarts then
      runTime = debugprofilestop() - time
      perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

      tInsert(data, "Quest Starts:")
      for _, questID in ipairs(questStarts) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Starts: nil")
    end

    -- Test Object.questEnds
    Object.lastTestedData = "questEnds"
    time = debugprofilestop()
    local questEnds = Object.questEnds(id)
    if questEnds then
      runTime = debugprofilestop() - time
      perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

      tInsert(data, "Quest Ends:")
      for _, questID in ipairs(questEnds) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Ends: nil")
    end

    -- Test Object.spawns
    Object.lastTestedData = "spawns"
    time = debugprofilestop()
    local spawns = Object.spawns(id)
    if spawns then
      runTime = debugprofilestop() - time
      perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

      for zoneID, coords in pairs(spawns) do
        tInsert(data, "Spawns in Zone " .. zoneID .. ":")
        for _, coord in ipairs(coords) do
          tInsert(data, "  X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      tInsert(data, "Spawns: nil")
    end

    -- Test Object.zoneID
    Object.lastTestedData = "zoneID"
    time = debugprofilestop()
    tInsert(data, "Zone ID: " .. (Object.zoneID(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

    -- Test Object.factionID
    Object.lastTestedData = "factionID"
    time = debugprofilestop()
    tInsert(data, "Faction ID: " .. (Object.factionID(id) or "nil"))
    runTime = debugprofilestop() - time
    perFunctionPerformance[Object.lastTestedData] = (perFunctionPerformance[Object.lastTestedData] or 0) + runTime

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop() - beginTime
  LibQuestieDB.ColorizePrint("green", "Object Test Done", time, "ms")
  print("  ", count, "objects tested")
  print("  ", "time per object:", tostring(time / count):sub(1, 6), "ms")
  print("  ", "avg time per function", tostring(time / (count * functions)):sub(1, 6), "ms")
  for i, functionName in ipairs(LibQuestieDB.Meta.ObjectMeta.NameIndexLookupTable) do
    local v = perFunctionPerformance[functionName] or 0
    print("    ", i, functionName, ":", tostring((v / count) * 1000):sub(1, 6), "µs")
  end
end
