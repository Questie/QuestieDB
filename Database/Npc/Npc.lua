Npc = {}

local tonumber = tonumber

-- This will be assigned from the initialize function
local glob = {}
local override = {}

function Npc.Initialize(dataGlob, dataOverride, overrideKeys)
  glob = dataGlob
  Npc.glob = glob
  Npc.override = override
  Database.Override(dataOverride, override, overrideKeys)
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- npcKeysOriginal = {
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
-- 1. ['name'], -- string
-- 2. ['meta-data'], -- int
-- 	1. ['minLevelHealth'], -- int
-- 	2. ['maxLevelHealth'], -- int
-- 	3. ['minLevel'], -- int
-- 	4. ['maxLevel'], -- int
-- 	5. ['rank'], -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
-- 	6. ['zoneID'], -- guess as to where this NPC is most common
-- 	7. ['factionID'], -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
-- 	8. ['friendlyToFaction'], -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
-- 	9. ['factionID'], -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
-- 	10. ['npcFlags'], -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
-- 3. ['spawns'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 4. ['waypoints'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 5. ['questStarts'], -- table {questID(int), ...}
-- 6. ['questEnds'], -- table {questID(int), ...}
-- 7. ['subName'], -- string, The title or function of the NPC, e.g. "Weapon Vendor"

  ---Returns the npc name.
  ---@param id NpcId
  ---@return Name?
  function Npc.name(id)
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

  ---Returns the minimum level health of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.minLevelHealth(id)
    if override[id] then
      return override[id]["minLevelHealth"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^(%d+);"))
    else
      return 1
    end
  end

  ---Returns the maximum level health of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevelHealth(id)
    if override[id] then
      return override[id]["maxLevelHealth"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;(%d+);"))
    else
      return 1
    end
  end

  ---Returns the minimum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.minLevel(id)
    if override[id] then
      return override[id]["minLevel"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;(%d+);"))
    else
      -- We return 1 rather than nil here
      return 1
    end
  end

  ---Returns the maximum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevel(id)
    if override[id] then
      return override[id]["maxLevel"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;(%d+);"))
    else
      -- We return 1 rather than nil here
      return 1
    end
  end

  ---Returns the rank of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.rank(id)
    if override[id] then
      return override[id]["rank"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;%d+;(%d+)"))
    else
      -- https://github.com/cmangos/issues/wiki/creature_template#rank
      -- We return 0 - Normal rather than nil here
      return 0
    end
  end

  ---Returns the zone ID of the npc.
  ---@param id NpcId
  ---@return AreaId?
  function Npc.zoneID(id)
    if override[id] then
      return override[id]["zoneID"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the faction ID of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.factionID(id)
    if override[id] then
      return override[id]["factionID"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the friendly factions of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.friendlyToFaction(id)
    if override[id] then
      return override[id]["friendlyToFaction"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return data[2]:GetText():match("^%d+;%d+;%d+;%d+;%d+;%d+;%d+;(%w*)")
    else
      return nil
    end
  end

  ---Returns the npc flags of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.npcFlags(id)
    if override[id] then
      return override[id]["npcFlags"]
    end
    local data = glob[id]
    if data[2] then
      --! This is slower than a raw value
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;%d+;%d+;%d+;%d+;%w*;(%d+)"))
    else
      -- We return 0 here as in "no flag"
      return 0
    end
  end

  ---Returns the spawns of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.spawns(id)
    if override[id] then
      return override[id]["spawns"]
    end
    local data = glob[id]
    if data then
      return getTable(data[3])
    else
      return nil
    end
  end

  ---Returns the waypoints of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.waypoints(id)
    if override[id] then
      return override[id]["waypoints"]
    end
    local data = glob[id]
    if data then
      return getTable(data[4])
    else
      return nil
    end
  end

  ---Returns the quests that the npc starts.
  ---@param id NpcId
  ---@return QuestId[]?
  function Npc.questStarts(id)
    if override[id] then
      return override[id]["questStarts"]
    end
    local data = glob[id]
    if data then
      return getTable(data[5])
    else
      return nil
    end
  end

  ---Returns the quests that the npc ends.
  ---@param id NpcId
  ---@return QuestId[]?
  function Npc.questEnds(id)
    if override[id] then
      return override[id]["questEnds"]
    end
    local data = glob[id]
    if data then
      return getTable(data[6])
    else
      return nil
    end
  end

  ---Returns the sub name of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.subName(id)
    if override[id] then
      return override[id]["subName"]
    end
    local data = glob[id]
    if data[7] then
      return data[7]:GetText()
    else
      return nil
    end
  end
end