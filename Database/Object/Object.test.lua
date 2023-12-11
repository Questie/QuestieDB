local _,
---@class QuestieSDB
QuestieSDB = ...

local tInsert = table.insert
Object.testGetFunctions = function(fast)
  debugprofilestart()
  local functions = 6
  local count = 0
  for id in pairs(Object.GetAllObjectIds()) do
    Object.lastTestedID = id
    count = count + 1
    local data = {}
    tInsert(data, "Testing Object " .. id)

    -- Test Object.name
    tInsert(data, "Name: " .. (Object.name(id) or "nil"))

    -- Test Object.questStarts
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
    tInsert(data, "Zone ID: " .. (Object.zoneID(id) or "nil"))

    -- Test Object.factionID
    tInsert(data, "Faction ID: " .. (Object.factionID(id) or "nil"))

    tInsert(data, "--------------------------------------------------")
    if not fast then
      print(table.concat(data, "\n"))
    end
  end

  local time = debugprofilestop()
  QuestieSDB.ColorizePrint("green", "Object Test Done", time, "ms")
  print("  ", count, "objects tested")
  print("  ", "time per object:", time / count, "ms")
  print("  ", "avg time per function", time / (count * functions), "ms")
end
