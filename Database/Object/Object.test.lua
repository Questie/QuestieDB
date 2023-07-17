Object.testGetFunctions = function()
  local glob = Object.glob
  for id in pairs(glob) do
    print("Testing Object " .. id)
    local data = {}

    -- Test Object.name
    table.insert(data, "Name: " .. (Object.name(id) or "nil"))

    -- Test Object.questStarts
    local questStarts = Object.questStarts(id)
    if questStarts then
      table.insert(data, "Quest Starts:")
      for _, questID in ipairs(questStarts) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Starts: nil")
    end

    -- Test Object.questEnds
    local questEnds = Object.questEnds(id)
    if questEnds then
      table.insert(data, "Quest Ends:")
      for _, questID in ipairs(questEnds) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Ends: nil")
    end

    -- Test Object.spawns
    local spawns = Object.spawns(id)
    if spawns then
      for zoneID, coords in pairs(spawns) do
        table.insert(data, "Spawns in Zone " .. zoneID .. ":")
        for _, coord in ipairs(coords) do
          table.insert(data, "  X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      table.insert(data, "Spawns: nil")
    end

    -- Test Object.zoneID
    table.insert(data, "Zone ID: " .. (Object.zoneID(id) or "nil"))

    -- Test Object.factionID
    table.insert(data, "Faction ID: " .. (Object.factionID(id) or "nil"))

    table.insert(data, "--------------------------------------------------")
    print(table.concat(data, "\n"))
  end

  print("Object Test Done")
end
