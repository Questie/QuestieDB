---@class LibQuestieDB
---@field Object Object
local LibQuestieDB = select(2, ...)

local l10n = LibQuestieDB.l10n

---@class (exact) Object:DatabaseType
---@class (exact) Object:ObjectFunctions
local Object = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.Object, "Object", LibQuestieDB.Meta.ObjectMeta.objectKeys)


do
  -- Class for all the GET functions for the Object namespace
  ---@class ObjectFunctions
  local ObjectFunctions = {}

  -- ? Questie Data structure for Objects
  -- ['name'] = 1, -- string
  -- ['questStarts'] = 2, -- table {questID(int),...}
  -- ['questEnds'] = 3, -- table {questID(int),...}
  -- ['spawns'] = 4, -- table {[zoneID(int)] = {{X(float), Y(float)}, ...}, ...}
  -- ['zoneID'] = 5, -- guess as to where this object is most common
  -- ['factionID'] = 6, -- faction restriction mask (same as spawndb factionid)

  -- ? QuestieDB Data structure for Quests

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" and not LibQuestieDB.Database.debugEnabled then
    ---Returns the object name.
    ---@type fun(id: ObjectId):Name?
    ObjectFunctions.name = Object.AddStringGetter(1, "name")
  else
    local objectName_enUS = Object.AddStringGetter(1, "name")
    ObjectFunctions.name = function(id)
      return l10n.objectName(id) or objectName_enUS(id)
    end
  end

  ---Returns the IDs of NPCs that drop this object.
  ---@type fun(id :ObjectId):QuestId[]?
  ObjectFunctions.questStarts = Object.AddTableGetter(2, "questStarts")

  ---Returns the IDs of quests that end at this object.
  ---@type fun(id: ObjectId):QuestId[]?
  ObjectFunctions.questEnds = Object.AddTableGetter(3, "questEnds")

  ---Returns the spawn locations of the object.
  ---@type fun(id: ObjectId):table<AreaId, table<CoordPair>>?
  ObjectFunctions.spawns = Object.AddTableGetter(4, "spawns")

  ---Returns the most common zone ID where the object is found.
  ---@type fun(id: ObjectId):AreaId?
  ObjectFunctions.zoneID = Object.AddNumberGetter(5, "zoneID")

  ---Returns the faction ID of the object.
  ---@type fun(id: ObjectId):number?
  ObjectFunctions.factionID = Object.AddNumberGetter(6, "factionID")

  ---Returns the waypoints of the object. (e.g. for ships and zeppelins)
  ---@type fun(id: ObjectId):table<AreaId, CoordPair[]>?
  ObjectFunctions.waypoints = Object.AddTableGetter(7, "waypoints")

  --? This function is used to export all the functions to the Public and Private namespaces
  --? It gets called at the end of this file
  local function exportFunctions()
    ---@class ObjectFunctions
    local publicObject = LibQuestieDB.PublicLibQuestieDB.Object
    for k, v in pairs(ObjectFunctions) do
      Object[k] = v
      publicObject[k] = v
    end
    publicObject.AddOverrideData = Object.AddOverrideData
    publicObject.ClearOverrideData = Object.ClearOverrideData
    publicObject.GetAllIds = Object.GetAllIds
  end

  exportFunctions()
end
