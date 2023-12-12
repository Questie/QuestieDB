Npc = {}

local tonumber = tonumber

-- This will be assigned from the initialize function
local glob = {}
local override = {}

function Npc.InitializeDynamic()
  -- This will be assigned from the initialize function
  local npcData = Database.LoadDatafileList("NpcData")
  -- localized for faster access
  local loadFile = Database.LoadFile
  -- Get the binary search function
  local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(npcData)

  ---@type table<NpcId, table<number, FontString>>
  glob = setmetatable({},
    {
      __index = function(t, k)
        return loadFile(binarySearch(k), t, k)
      end,
      __newindex = function()
        error("Attempt to modify read-only table")
      end
    }
  )
  Npc.glob = glob
  Npc.override = override
end

function Npc.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Npc database before adding override data")
  end
  Database.Override(dataOverride, override, overrideKeys)
end

function Npc.ClearOverrideData()
  if override then
    override = wipe(override)
  end
end

---Get all npc ids.
---@return NpcId[]
function Npc.GetAllNpcIds()
  local loadstringFunction = Database.GetAllEntityIdsFunction("Npc")
  -- Replace the function with the loadstringFunction
  ---@cast loadstringFunction fun():NpcId[]
  Npc.GetAllNpcIds = loadstringFunction
  return loadstringFunction()
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

-- 1. ['name'], -- string
-- 2. ['meta-data'], -- int
-- 	 1. ['minLevelHealth'], -- int
-- 	 2. ['maxLevelHealth'], -- int
-- 	 3. ['minLevel'], -- int
-- 	 4. ['maxLevel'], -- int
-- 	 5. ['rank'], -- int, see https://github.com/cmangos/issues/wiki/creature_template#rank
-- 	 6. ['zoneID'], -- guess as to where this NPC is most common
-- 	 7. ['factionID'], -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
-- 	 8. ['friendlyToFaction'], -- string, Contains "A" and/or "H" depending on NPC being friendly towards those factions. nil if hostile to both.
-- 	 9. ['factionID'], -- int, see https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
-- 	 10. ['npcFlags'], -- int, Bitmask containing various flags about the NPCs function (Vendor, Trainer, Flight Master, etc.).
-- 3. ['spawns'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 4. ['waypoints'], -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
-- 5. ['questStarts'], -- table {questID(int), ...}
-- 6. ['questEnds'], -- table {questID(int), ...}
-- 7. ['subName'], -- string, The title or function of the NPC, e.g. "Weapon Vendor"

  ---Returns the npc name.
  ---@param id NpcId
  ---@return Name?
  function Npc.name(id)
    if override[id] and override[id]["name"] then
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
    if override[id] and override[id]["minLevelHealth"] then
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
    if override[id] and override[id]["maxLevelHealth"] then
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
    if override[id] and override[id]["minLevel"] then
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
    if override[id] and override[id]["maxLevel"] then
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
    if override[id] and override[id]["rank"] then
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
    if override[id] and override[id]["zoneID"] then
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
    if override[id] and override[id]["factionID"] then
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
    if override[id] and override[id]["friendlyToFaction"] then
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
    if override[id] and override[id]["npcFlags"] then
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
    if override[id] and override[id]["spawns"] then
      return override[id]["spawns"]
    end
    local data = glob[id]
    if data then
      return getTable(data[3]) or emptyTable
    else
      return nil
    end
  end

  ---Returns the waypoints of the npc.
  ---@param id NpcId
  ---@return table<AreaId, CoordPair[]>?
  function Npc.waypoints(id)
    if override[id] and override[id]["waypoints"] then
      return override[id]["waypoints"]
    end
    local data = glob[id]
    if data then
      return getTable(data[4]) or emptyTable
    else
      return nil
    end
  end

  ---Returns the quests that the npc starts.
  ---@param id NpcId
  ---@return QuestId[]?
  function Npc.questStarts(id)
    if override[id] and override[id]["questStarts"] then
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
    if override[id] and override[id]["questEnds"] then
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
    if override[id] and override[id]["subName"] then
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