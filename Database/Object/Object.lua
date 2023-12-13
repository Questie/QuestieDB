---@class LibQuestieDB
---@field Object Object
local LibQuestieDB = select(2, ...)

---@class Object:ObjectFunctions
local Object = LibQuestieDB.Object

--*---- Import Modules -------
local Database = LibQuestieDB.Database

-- This will be assigned from the initialize function
local glob = {}
local override = {}
function Object.InitializeDynamic()
  -- This will be assigned from the initialize function
  local objectData = Database.LoadDatafileList("ObjectData")
  -- localized for faster access
  local loadFile = Database.LoadFile
  -- Get the binary search function
  local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(objectData)

  ---@type table<ObjectId, table<number, FontString>>
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
  Object.glob = glob
  Object.override = override
end

function Object.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Object database before adding override data")
  end
  return Database.Override(dataOverride, override, overrideKeys)
end

function Object.ClearOverrideData()
  if override then
    override = wipe(override)
  end
end

---Get all object ids.
---@return ObjectId[]
function Object.GetAllObjectIds()
  local loadstringFunction = Database.GetAllEntityIdsFunction("Object")
  -- Replace the function with the loadstringFunction
  ---@cast loadstringFunction fun():ObjectId[]
  Object.GetAllObjectIds = loadstringFunction
  return loadstringFunction()
end

do
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- Class for all the GET functions for the Object namespace
  ---@class ObjectFunctions
  local ObjectFunctions = {}

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
  end

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
  function ObjectFunctions.name(id)
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

  ---Returns the IDs of NPCs that drop this object.
  ---@param id ObjectId
  ---@return QuestId[]?
  function ObjectFunctions.questStarts(id)
    if override[id] and override[id]["questStarts"] then
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
  function ObjectFunctions.questEnds(id)
    if override[id] and override[id]["questEnds"] then
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
  function ObjectFunctions.spawns(id)
    if override[id] and override[id]["spawns"] then
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
  function ObjectFunctions.zoneID(id)
    if override[id] and override[id]["zoneID"] then
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
  function ObjectFunctions.factionID(id)
    if override[id] and override[id]["factionID"] then
      return override[id]["factionID"]
    end
    local data = glob[id]
    if data then
      return getNumber(data[6])
    else
      return nil
    end
  end
  exportFunctions()
end