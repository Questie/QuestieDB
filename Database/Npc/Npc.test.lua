Npc.testGetFunctions = function()
  local glob = Npc.glob
  for id in pairs(glob) do
    print("Testing Npc " .. id)
    local data = {}

    -- Test Npc.name
    table.insert(data, "Name: " .. (Npc.name(id) or "nil"))

    -- Test Npc.minLevelHealth
    table.insert(data, "Min Level Health: " .. (Npc.minLevelHealth(id) or "nil"))

    -- Test Npc.maxLevelHealth
    table.insert(data, "Max Level Health: " .. (Npc.maxLevelHealth(id) or "nil"))

    -- Test Npc.minLevel
    table.insert(data, "Min Level: " .. (Npc.minLevel(id) or "nil"))

    -- Test Npc.maxLevel
    table.insert(data, "Max Level: " .. (Npc.maxLevel(id) or "nil"))

    -- Test Npc.rank
    table.insert(data, "Rank: " .. (Npc.rank(id) or "nil"))

    -- Test Npc.spawns
    local spawns = Npc.spawns(id)
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

    -- Test Npc.waypoints
    local waypoints = Npc.waypoints(id)
    if waypoints then
      for zoneID, coords in pairs(waypoints) do
        table.insert(data, "Waypoints in Zone " .. zoneID .. ":")
        for _, coord in ipairs(coords) do
          table.insert(data, "  X: " .. coord[1] .. ", Y: " .. coord[2])
        end
      end
    else
      table.insert(data, "Waypoints: nil")
    end

    -- Test Npc.zoneID
    table.insert(data, "Zone ID: " .. (Npc.zoneID(id) or "nil"))

    -- Test Npc.questStarts
    local questStarts = Npc.questStarts(id)
    if questStarts then
      table.insert(data, "Quest Starts:")
      for _, questID in ipairs(questStarts) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Starts: nil")
    end

    -- Test Npc.questEnds
    local questEnds = Npc.questEnds(id)
    if questEnds then
      table.insert(data, "Quest Ends:")
      for _, questID in ipairs(questEnds) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Ends: nil")
    end

    -- Test Npc.factionID
    table.insert(data, "Faction ID: " .. (Npc.factionID(id) or "nil"))

    -- Test Npc.friendlyToFaction
    table.insert(data, "Friendly to Faction: " .. (Npc.friendlyToFaction(id) or "nil"))

    -- Test Npc.subName
    table.insert(data, "Sub Name: " .. (Npc.subName(id) or "nil"))

    -- Test Npc.npcFlags
    table.insert(data, "NPC Flags: " .. (Npc.npcFlags(id) or "nil"))

    table.insert(data, "--------------------------------------------------")
    print(table.concat(data, "\n"))
  end
  print("Npc Test Done")
end
