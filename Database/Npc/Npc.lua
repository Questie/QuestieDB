Npc = {}
Npc.maxId = -1 -- This is different between expansions

-- This will be assigned from the initialize function
local glob = {}

function Npc.Initialize(dataGlob)
  glob = dataGlob
  print("Loaded Npc Data")
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- npcKeys = {
  --   ['name'] = 1, -- string
  --   ['minLevelHealth'] = 2, -- int
  --   ['maxLevelHealth'] = 3, -- int
  --   ['minLevel'] = 4, -- int
  --   ['maxLevel'] = 5, -- int
  --   ['rank'] = 6, -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
  --   ['spawns'] = 7, -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
  --   ['waypoints'] = 8, -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
  --   ['zoneID'] = 9, -- guess as to where this NPC is most common
  --   ['questStarts'] = 10, -- table {questID(int), ...}
  --   ['questEnds'] = 11, -- table {questID(int), ...}
  --   ['factionID'] = 12, -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
  --   ['friendlyToFaction'] = 13, -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
  --   ['subName'] = 14, -- string, The title or function of the NPC, e.g. "Weapon Vendor"
  --   ['npcFlags'] = 15, -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
  --                      -- For flag values see https://github.com/cmangos/mangos-classic/blob/172c005b0a69e342e908f4589b24a6f18246c95e/src/game/Entities/Unit.h#L536
  -- }

  ---Returns the npc name.
  ---@param id NpcId
  ---@return Name?
  function Npc.name(id)
    local data = glob[id]
    if data then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the minimum level health of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.minLevelHealth(id)
    local data = glob[id]
    if data then
      return getNumber(data[2])
    else
      return nil
    end
  end

  ---Returns the maximum level health of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevelHealth(id)
    local data = glob[id]
    if data then
      return getNumber(data[3])
    else
      return nil
    end
  end

  ---Returns the minimum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.minLevel(id)
    local data = glob[id]
    if data then
      return getNumber(data[4])
    else
      return nil
    end
  end

  ---Returns the maximum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevel(id)
    local data = glob[id]
    if data then
      return getNumber(data[5])
    else
      return nil
    end
  end

  ---Returns the rank of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.rank(id)
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      return nil
    end
  end

  ---Returns the spawns of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.spawns(id)
    local data = glob[id]
    if data then
      return getTable(data[7])
    else
      return nil
    end
  end

  ---Returns the waypoints of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.waypoints(id)
    local data = glob[id]
    if data then
      return getTable(data[8])
    else
      return nil
    end
  end

  ---Returns the zone ID of the npc.
  ---@param id NpcId
  ---@return AreaId?
  function Npc.zoneID(id)
    local data = glob[id]
    if data then
      return getNumber(data[9])
    else
      return nil
    end
  end

  ---Returns the quests that the npc starts.
  ---@param id NpcId
  ---@return QuestId[]?
  function Npc.questStarts(id)
    local data = glob[id]
    if data then
      return getTable(data[10])
    else
      return nil
    end
  end

  ---Returns the quests that the npc ends.
  ---@param id NpcId
  ---@return QuestId[]?
  function Npc.questEnds(id)
    local data = glob[id]
    if data then
      return getTable(data[11])
    else
      return nil
    end
  end

  ---Returns the faction ID of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.factionID(id)
    local data = glob[id]
    if data then
      return getNumber(data[12])
    else
      return nil
    end
  end

  ---Returns the friendly factions of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.friendlyToFaction(id)
    local data = glob[id]
    if data then
      return data[13]:GetText()
    else
      return nil
    end
  end

  ---Returns the sub name of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.subName(id)
    local data = glob[id]
    if data then
      return data[14]:GetText()
    else
      return nil
    end
  end

  ---Returns the npc flags of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.npcFlags(id)
    local data = glob[id]
    if data then
      return getNumber(data[15])
    else
      return nil
    end
  end
end
