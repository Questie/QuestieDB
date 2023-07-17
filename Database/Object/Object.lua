Object = {}

-- This will be assigned from the initialize function
local glob = {}

function Object.Initialize(dataGlob)
  glob = dataGlob
  print("Loaded Object Data")
end

do
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- objectKeys = {
  --   ['name'] = 1, -- string
  --   ['questStarts'] = 2, -- table {questID(int),...}
  --   ['questEnds'] = 3, -- table {questID(int),...}
  --   ['spawns'] = 4, -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
  --   ['zoneID'] = 5, -- guess as to where this object is most common
  --   ['factionID'] = 6, -- faction restriction mask (same as spawndb factionid)
  -- }

  ---Returns the object name.
  ---@param id ObjectId
  ---@return Name?
  function Object.name(id)
    local data = glob[id]
    if data[1] then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the IDs of NPCs that drop this object.
  ---@param id ObjectId
  ---@return QuestId[]?
  function Object.questStarts(id)
    local data = glob[id]
    if data then
      return getTable(data[2])
    else
      return nil
    end
  end

  ---Returns the IDs of quests that end at this object.
  ---@param id ObjectId
  ---@return QuestId[]?
  function Object.questEnds(id)
    local data = glob[id]
    if data then
      return getTable(data[3])
    else
      return nil
    end
  end

  ---Returns the spawn locations of the object.
  ---@param id ObjectId
  ---@return table<AreaId, table<CoordPair>>?
  function Object.spawns(id)
    local data = glob[id]
    if data then
      return getTable(data[4])
    else
      return nil
    end
  end

  ---Returns the most common zone ID where the object is found.
  ---@param id ObjectId
  ---@return AreaId?
  function Object.zoneID(id)
    local data = glob[id]
    if data then
      return getNumber(data[5])
    else
      return nil
    end
  end

  ---Returns the faction ID of the object.
  ---@param id ObjectId
  ---@return number?
  function Object.factionID(id)
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      return nil
    end
  end
end


Object.testObjectGetFunctions = function()
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
