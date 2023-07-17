Npc = {}

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
-- 	 1. ['minLevelHealth'], -- int
-- 	 2. ['maxLevelHealth'], -- int
-- 	 3. ['minLevel'], -- int
-- 	 4. ['maxLevel'], -- int
-- 	 5. ['rank'], -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
-- 4. ['spawns'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 5. ['waypoints'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 6. ['zoneID'], -- guess as to where this NPC is most common
-- 7. ['questStarts'], -- table {questID(int), ...}
-- 8. ['questEnds'], -- table {questID(int), ...}
-- 9. ['factionID'], -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
-- 10. ['friendlyToFaction'], -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
-- 11. ['subName'], -- string, The title or function of the NPC, e.g. "Weapon Vendor"
-- 12. ['npcFlags'], -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).

  ---Returns the npc name.
  ---@param id NpcId
  ---@return Name?
  function Npc.name(id)
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
    local data = glob[id]
    if data[2] then
      return tonumber(data[2]:GetText():match("^(%d+);"))
      -- return tonumber(getDatastringSplit(data[2])[1])
    else
      return 1
    end
  end

  ---Returns the maximum level health of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevelHealth(id)
    local data = glob[id]
    if data[2] then
      return tonumber(data[2]:GetText():match("^%d+;(%d+);"))
      -- return tonumber(getDatastringSplit(data[2])[2])
    else
      return 1
    end
  end

  ---Returns the minimum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.minLevel(id)
    local data = glob[id]
    if data[2] then
      return tonumber(data[2]:GetText():match("^%d+;%d+;(%d+);"))
      -- return tonumber(getDatastringSplit(data[2])[3])
    else
      -- We return 1 rather than nil here
      return 1
    end
  end

  ---Returns the maximum level of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.maxLevel(id)
    local data = glob[id]
    if data[2] then
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;(%d+);"))
      -- return tonumber(getDatastringSplit(data[2])[4])
    else
      -- We return 1 rather than nil here
      return 1
    end
  end

  ---Returns the rank of the npc.
  ---@param id NpcId
  ---@return number?
  function Npc.rank(id)
    local data = glob[id]
    if data[2] then
      return tonumber(data[2]:GetText():match("^%d+;%d+;%d+;%d+;(%d+)"))
      -- return tonumber(getDatastringSplit(data[2])[5])
    else
      -- https://github.com/cmangos/issues/wiki/creature_template#rank
      -- We return 0 - Normal rather than nil here
      return 0
    end
  end

  ---Returns the spawns of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.spawns(id)
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
    local data = glob[id]
    if data then
      return getTable(data[4])
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
      return getNumber(data[5])
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
      return getTable(data[6])
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
      return getTable(data[7])
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
      return getNumber(data[8])
    else
      return nil
    end
  end

  ---Returns the friendly factions of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.friendlyToFaction(id)
    local data = glob[id]
    if data[9] then
      return data[9]:GetText()
    else
      return nil
    end
  end

  ---Returns the sub name of the npc.
  ---@param id NpcId
  ---@return string?
  function Npc.subName(id)
    local data = glob[id]
    if data[10] then
      return data[10]:GetText()
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
      return getNumber(data[11])
    else
      -- We return 0 here as in "no flag"
      return 0
    end
  end
end


Npc.testNpcGetFunctions = function()
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


-- ---Returns the minimum level health of the npc.
-- ---@param id NpcId
-- ---@return number?
-- function Npc.minLevelHealth(id)
--   return 1
--   -- local data = glob[id]
--   -- if data then
--   --   return getNumber(data[2])
--   -- else
--   --   return nil
--   -- end
-- end

-- ---Returns the maximum level health of the npc.
-- ---@param id NpcId
-- ---@return number?
-- function Npc.maxLevelHealth(id)
--   return 2
--   -- local data = glob[id]
--   -- if data then
--   --   return getNumber(data[3])
--   -- else
--   --   return nil
--   -- end
-- end

-- ---Returns the minimum level of the npc.
-- ---@param id NpcId
-- ---@return number?
-- function Npc.minLevel(id)
--   local data = glob[id]
--   if data then
--     return getNumber(data[4])
--   else
--     -- We return 1 rather than nil here
--     return 1
--   end
-- end

-- ---Returns the maximum level of the npc.
-- ---@param id NpcId
-- ---@return number?
-- function Npc.maxLevel(id)
--   local data = glob[id]
--   if data then
--     return getNumber(data[5])
--   else
--     -- We return 1 rather than nil here
--     return 1
--   end
-- end

-- ---Returns the rank of the npc.
-- ---@param id NpcId
-- ---@return number?
-- function Npc.rank(id)
--   local data = glob[id]
--   if data then
--     return getNumber(data[6])
--   else
--     -- https://github.com/cmangos/issues/wiki/creature_template#rank
--     -- We return 0 - Normal rather than nil here
--     return 0
--   end
-- end
