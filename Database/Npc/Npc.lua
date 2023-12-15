---@class LibQuestieDB
---@field Npc Npc
local LibQuestieDB = select(2, ...)

---@class Npc:NpcFunctions
local Npc = LibQuestieDB.Npc

--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText

local debug = DebugText:Get("Npc")

--*---------------------------
--- The nil value for the database
local _nil = Database._nil
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

  local loadOrder = 0
  local totalLoaded = 0
  -- Load all Npc Corrections
  for _, list in pairs(Corrections.GetCorrections("npc", Database.debugEnabled)) do
    for id, func in pairs(list) do
      local correctionData = func()
      totalLoaded = totalLoaded + Npc.AddOverrideData(correctionData, Corrections.NpcMeta.npcKeys)
      if Database.debugEnabled then
        debug:Print("  " .. tostring(loadOrder) .. "  Loaded", id)
      end
      loadOrder = loadOrder + 1
    end
  end
  if Database.debugEnabled then
    debug:Print("  # Npc Corrections", totalLoaded)
  end
end

function Npc.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Npc database before adding override data")
  end
  return Database.Override(dataOverride, override, overrideKeys)
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
  -- Used to return an empty table instead of nil
  ---@type table<number, table<number, FontString>>
  local emptyTable = setmetatable({}, {
    __newindex = function()
      error("Attempt to modify read-only table")
    end
  })

  -- Class for all the GET functions for the Npc namespace
  ---@class NpcFunctions
  local NpcFunctions = {}

  --? This function is used to export all the functions to the Public and Private namespaces
  --? It gets called at the end of this file
  local function exportFunctions()
    ---@class NpcFunctions
    local publicNpc = LibQuestieDB.PublicLibQuestieDB.Npc
    for k, v in pairs(NpcFunctions) do
      Npc[k] = v
      publicNpc[k] = v
    end
    publicNpc.AddOverrideData = Npc.AddOverrideData
    publicNpc.ClearOverrideData = Npc.ClearOverrideData
  end

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
  function NpcFunctions.name(id)
    if override[id] and override[id]["name"] then
      local name = override[id]["name"]
      return name ~= _nil and name or nil
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
  function NpcFunctions.minLevelHealth(id)
    if override[id] and override[id]["minLevelHealth"] then
      local minLevelHealth = override[id]["minLevelHealth"]
      return minLevelHealth ~= _nil and minLevelHealth or nil
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
  function NpcFunctions.maxLevelHealth(id)
    if override[id] and override[id]["maxLevelHealth"] then
      local maxLevelHealth = override[id]["maxLevelHealth"]
      return maxLevelHealth ~= _nil and maxLevelHealth or nil
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
  function NpcFunctions.minLevel(id)
    if override[id] and override[id]["minLevel"] then
      local minLevel = override[id]["minLevel"]
      return minLevel ~= _nil and minLevel or nil
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
  function NpcFunctions.maxLevel(id)
    if override[id] and override[id]["maxLevel"] then
      local maxLevel = override[id]["maxLevel"]
      return maxLevel ~= _nil and maxLevel or nil
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
  function NpcFunctions.rank(id)
    if override[id] and override[id]["rank"] then
      local rank = override[id]["rank"]
      return rank ~= _nil and rank or nil
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
  function NpcFunctions.zoneID(id)
    if override[id] and override[id]["zoneID"] then
      local zoneID = override[id]["zoneID"]
      return zoneID ~= _nil and zoneID or nil
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
  function NpcFunctions.factionID(id)
    if override[id] and override[id]["factionID"] then
      local factionID = override[id]["factionID"]
      return factionID ~= _nil and factionID or nil
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
  function NpcFunctions.friendlyToFaction(id)
    if override[id] and override[id]["friendlyToFaction"] then
      local friendlyToFaction = override[id]["friendlyToFaction"]
      return friendlyToFaction ~= _nil and friendlyToFaction or nil
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
  function NpcFunctions.npcFlags(id)
    if override[id] and override[id]["npcFlags"] then
      local npcFlags = override[id]["npcFlags"]
      return npcFlags ~= _nil and npcFlags or nil
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
  function NpcFunctions.spawns(id)
    if override[id] and override[id]["spawns"] then
      local spawns = override[id]["spawns"]
      return spawns ~= _nil and spawns or nil
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
  function NpcFunctions.waypoints(id)
    if override[id] and override[id]["waypoints"] then
      local waypoints = override[id]["waypoints"]
      return waypoints ~= _nil and waypoints or nil
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
  function NpcFunctions.questStarts(id)
    if override[id] and override[id]["questStarts"] then
      local questStarts = override[id]["questStarts"]
      return questStarts ~= _nil and questStarts or nil
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
  function NpcFunctions.questEnds(id)
    if override[id] and override[id]["questEnds"] then
      local questEnds = override[id]["questEnds"]
      return questEnds ~= _nil and questEnds or nil
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
  function NpcFunctions.subName(id)
    if override[id] and override[id]["subName"] then
      local subName = override[id]["subName"]
      return subName ~= _nil and subName or nil
    end
    local data = glob[id]
    if data[7] then
      return data[7]:GetText()
    else
      return nil
    end
  end
  exportFunctions()
end
