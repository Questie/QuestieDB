---@class LibQuestieDB
---@field Object Object
local LibQuestieDB = select(2, ...)

---@class Object:ObjectFunctions
local Object = LibQuestieDB.Object

--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText

local debug = DebugText:Get("Object")

--*---------------------------
--- The nil value for the database
local _nil = Database._nil

---- Contains the data ----
local glob = {}
local override = {}

---- Contains the id strings ----
local AllIdStrings = {}

---- Local Functions ----
local tonumber = tonumber
local tConcat = table.concat
local tInsert = table.insert
local wipe = wipe
local loadstring = loadstring

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
  Object.LoadOverrideData()
end

---@param includeDynamic boolean? @If true, include dynamic data Default true
---@param includeStatic boolean? @If true, include dynamic data Default false
function Object.LoadOverrideData(includeDynamic, includeStatic)
  if includeDynamic == nil then
    includeDynamic = true
  end
  if includeStatic == nil then
    includeStatic = Database.debugEnabled or false
  end
  -- Clear the override data
  Object.ClearOverrideData()

  print("Loading Object Corrections")
  local loadOrder = 0
  local totalLoaded = 0
  -- Load all Object Corrections
  for _, list in pairs(Corrections.GetCorrections("object", includeStatic, includeDynamic)) do
    for id, func in pairs(list) do
      local correctionData = func()
      totalLoaded = totalLoaded + Object.AddOverrideData(correctionData, Corrections.ObjectMeta.objectKeys)
      if Database.debugEnabled then
        debug:Print("  " .. tostring(loadOrder) .. "  Loaded", id)
      end
      loadOrder = loadOrder + 1
    end
  end
  if Database.debugEnabled then
    debug:Print("  # Object Corrections", totalLoaded)
  end
  Object.override = override
end

function Object.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Object database before adding override data")
  end
  local newIds = Database.GetNewIds(AllIdStrings, dataOverride)
  if #newIds ~= 0 then
    tInsert(AllIdStrings, tConcat(newIds, ","))
    if Database.debugEnabled then
      print("  # New Object IDs", #newIds)
    end
  end
  return Database.Override(dataOverride, override, overrideKeys)
end

local function InitializeIdString()
  wipe(AllIdStrings)
  local _, idString = Database.GetAllEntityIdsFunction("Object")
  tInsert(AllIdStrings, idString)
end

function Object.ClearOverrideData()
  if override then
    override = wipe(override)
  end
  InitializeIdString()
end

---Get all object ids.
---@return ObjectId[]
function Object.GetAllObjectIds()
  return loadstring(string.format("return {%s}", tConcat(AllIdStrings, ",")))()
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
    publicObject.GetAllObjectIds = Object.GetAllObjectIds
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

  ---Returns the IDs of NPCs that drop this object.
  ---@param id ObjectId
  ---@return QuestId[]?
  function ObjectFunctions.questStarts(id)
    if override[id] and override[id]["questStarts"] then
      local questStarts = override[id]["questStarts"]
      return questStarts ~= _nil and questStarts or nil
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
      local questEnds = override[id]["questEnds"]
      return questEnds ~= _nil and questEnds or nil
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
      local spawns = override[id]["spawns"]
      return spawns ~= _nil and spawns or nil
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
      local zoneID = override[id]["zoneID"]
      return zoneID ~= _nil and zoneID or nil
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
      local factionID = override[id]["factionID"]
      return factionID ~= _nil and factionID or nil
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
