---@class LibQuestieDB
---@field Npc Npc
local LibQuestieDB = select(2, ...)

local Corrections = LibQuestieDB.Corrections
local l10n = LibQuestieDB.l10n

---@class (exact) Npc:DatabaseType
---@class (exact) Npc:NpcFunctions
local Npc = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.Npc, "Npc", Corrections.NpcMeta.npcKeys)

do
  -- Class for all the GET functions for the Npc namespace
  ---@class NpcFunctions
  local NpcFunctions = {}

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

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" then
    ---Returns the name of the npc.
    ---@type fun(id: NpcId):string?
    NpcFunctions.name = Npc.AddStringGetter(1, "name")
  else
    local npcName_enUS = Npc.AddStringGetter(1, "name")
    NpcFunctions.name = function(id)
      return l10n.npcName(id) or npcName_enUS(id)
    end
  end
  ---Returns the minimum level health of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.minLevelHealth = Npc.AddPatternGetter(2, "minLevelHealth", "^(%d+);", 1, tonumber)

  ---Returns the maximum level health of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.maxLevelHealth = Npc.AddPatternGetter(2, "maxLevelHealth", "^%d+;(%d+);", 1, tonumber)

  ---Returns the minimum level of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.minLevel = Npc.AddPatternGetter(2, "minLevel", "^%d+;%d+;(%d+);", 1, tonumber)

  ---Returns the maximum level of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.maxLevel = Npc.AddPatternGetter(2, "maxLevel", "^%d+;%d+;%d+;(%d+);", 1, tonumber)

  ---Returns the rank of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.rank = Npc.AddPatternGetter(2, "rank", "^%d+;%d+;%d+;%d+;(%d+)", 0, tonumber)

  ---Returns the zone ID of the npc.
  ---@type fun(id: NpcId):AreaId?
  NpcFunctions.zoneID = Npc.AddPatternGetter(2, "zoneID", "^%d+;%d+;%d+;%d+;%d+;(%d+)", nil, tonumber)

  ---Returns the faction ID of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.factionID = Npc.AddPatternGetter(2, "factionID", "^%d+;%d+;%d+;%d+;%d+;%d+;(%d+)", nil, tonumber)

  -- TODO: This has special handling for empty strings, need to make sure it's correct
  ---Returns the friendly factions of the npc.
  ---@type fun(id: NpcId):string?
  NpcFunctions.friendlyToFaction = Npc.AddPatternGetter(2, "friendlyToFaction", "^%d+;%d+;%d+;%d+;%d+;%d+;%d+;(%w*)", nil,
                                                        function(value)
                                                          return value ~= "" and value or nil
                                                        end)

  ---Returns the npc flags of the npc.
  ---@type fun(id: NpcId):number?
  NpcFunctions.npcFlags = Npc.AddPatternGetter(2, "npcFlags", "^%d+;%d+;%d+;%d+;%d+;%d+;%d+;%w*;(%d+)", 0, tonumber)

  ---Returns the spawns of the npc.
  ---@type fun(id: NpcId):table<AreaId, CoordPair[]>?
  NpcFunctions.spawns = Npc.AddTableGetter(3, "spawns")

  ---Returns the waypoints of the npc.
  ---@type fun(id: NpcId):table<AreaId, CoordPair[]>?
  NpcFunctions.waypoints = Npc.AddTableGetter(4, "waypoints")

  ---Returns the quests that the npc starts.
  ---@type fun(id: NpcId):QuestId[]?
  NpcFunctions.questStarts = Npc.AddTableGetter(5, "questStarts")

  ---Returns the quests that the npc ends.
  ---@type fun(id: NpcId):QuestId[]?
  NpcFunctions.questEnds = Npc.AddTableGetter(6, "questEnds")

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" then
    ---Returns the sub name of the npc.
    ---@type fun(id: NpcId):string?
    NpcFunctions.subName = Npc.AddStringGetter(7, "subName")
  else
    local fallbackSubName = Npc.AddStringGetter(7, "subName")
    NpcFunctions.subName = function(id)
      return l10n.npcSubName(id) or fallbackSubName(id)
    end
  end

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
    publicNpc.GetAllIds = Npc.GetAllIds
  end

  exportFunctions()
end
