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
    print("Last tested Object: " .. tostring(Object.lastTestedID))
    print("Last tested Object function: " .. tostring(Object.lastTestedData))
    error("Object test failed: " .. err)
  end
end

local tInsert = table.insert
Object.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 0
  for _, _ in pairs(LibQuestieDB.Corrections.ObjectMeta.objectKeys) do
    functions = functions + 1
  end

  local count = 0
  for id in pairs(Object.GetAllIds()) do
    Object.lastTestedID = id
    Object.lastTestedData = ""
    count = count + 1
    local data = {}
    tInsert(data, "Testing Object " .. id)

    -- Test Object.name
    Object.lastTestedData = "name"
    tInsert(data, "Name: " .. (Object.name(id) or "nil"))

    -- Test Object.questStarts
    Object.lastTestedData = "questStarts"
    local questStarts = Object.questStarts(id)
    if questStarts then
      tInsert(data, "Quest Starts:")
      for _, questID in ipairs(questStarts) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Starts: nil")
    end

    -- Test Object.questEnds
    Object.lastTestedData = "questEnds"
    local questEnds = Object.questEnds(id)
    if questEnds then
      tInsert(data, "Quest Ends:")
      for _, questID in ipairs(questEnds) do
        tInsert(data, "  Quest ID: " .. questID)
      end
    else
      tInsert(data, "Quest Ends: nil")
    end

    -- Test Object.spawns
    Object.lastTestedData = "spawns"
    local spawns = Object.spawns(id)
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

    -- Test Object.zoneID
    Object.lastTestedData = "zoneID"
    tInsert(data, "Zone ID: " .. (Object.zoneID(id) or "nil"))

    -- Test Object.factionID
    Object.lastTestedData = "factionID"
    tInsert(data, "Faction ID: " .. (Object.factionID(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  LibQuestieDB.ColorizePrint("green", "Object Test Done", time, "ms")
  print("  ", count, "objects tested")
  print("  ", "time per object:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
