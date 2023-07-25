Object = {}

-- This will be assigned from the initialize function
local glob = {}
local override = {}

function Object.Initialize(dataGlob, dataOverride, overrideKeys)
  glob = dataGlob
  Object.glob = glob
  Object.override = override
  Database.Override(dataOverride, override, overrideKeys)
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
    if override[id] then
      return override[id]["name"]
    end
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
    if override[id] then
      return override[id]["questStarts"]
    end
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
    if override[id] then
      return override[id]["questEnds"]
    end
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
    if override[id] then
      return override[id]["spawns"]
    end
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
    if override[id] then
      return override[id]["zoneID"]
    end
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
    if override[id] then
      return override[id]["factionID"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      return nil
    end
  end
end