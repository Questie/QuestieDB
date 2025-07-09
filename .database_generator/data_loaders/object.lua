local helpers = require(".db_helpers")
local f = string.format

---Loads object data from the database and merges it with static corrections.
---This function reads the raw object database file, applies static corrections
---from the addon environment, and returns a merged override table.
---@param lowerQuestieVersion string The version prefix for the database file (e.g., "Classic", "TBC")
---@param LibQuestieDBTable LibQuestieDB The QuestieDB library table containing correction data
---@return table<ObjectId, table<number, any>>? Returns merged object data table, or nil if database file not found
local function LoadObjectData(lowerQuestieVersion, LibQuestieDBTable)
  ---@type table<ObjectId, table<number, any>> Maps object IDs to arrays of field values indexed by Meta.objectKeys
  local objectOverride = {}
  ---@type Meta
  local Meta = LibQuestieDBTable.Meta

  local file = FindFile(f("%sObjectDB.lua", lowerQuestieVersion), nil, {}, helpers.get_script_dir())
  if not file then
    print(f("Failed to find %sObjectDB.lua", lowerQuestieVersion))
    print("Please run generate_database.sh or manually check out Questie into Questie-data folder")
    return nil
  end

  -- Load the raw ObjectDB.lua file content as a string.
  CLI_Helpers.loadFile(file)

  -- Execute the string to get the raw object data table.
  local err
  objectOverride, err = loadstring(QuestieDB.objectData)() -- QuestieDB.objectData is loaded by loadFile
  if not objectOverride or err then
    print("Error loading object data:", err)
    return nil
  end

  -- Load static corrections registered within the addon environment.
  -- * Do not load dynamic corrections (includeDynamic = false)
  -- * Load static corrections only (includeStatic = true)
  LibQuestieDBTable.Object.LoadOverrideData(false, true)

  ---@type ObjectMeta
  local objectMeta = Meta.ObjectMeta

  -- Iterate through the loaded static corrections.
  ---@param objectId ObjectId
  ---@param corrections table<string, any> @ Map of field name -> corrected value
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for objectId, corrections in pairs(LibQuestieDBTable.Object.override) do
    -- Ensure an entry exists for this ID in the main override table.
    if not objectOverride[objectId] then
      objectOverride[objectId] = {}
    end

    -- Merge each correction, converting field name to numeric index.
    ---@param key string @ Field name (e.g., "name", "spawns", "questStarts")
    ---@param correction any @ The corrected value
    for key, correction in pairs(corrections) do
      ---@type number Index position in the object data array
      local correctionIndex = objectMeta.objectKeys[key]
      objectOverride[objectId][correctionIndex] = correction
    end
  end

  -- Validate that corrections were processed if they exist
  local correctionCount = 0
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for _ in pairs(LibQuestieDBTable.Object.override) do
    correctionCount = correctionCount + 1
  end
  if correctionCount > 0 then
    assert(next(objectOverride), "Object override table is empty despite having corrections to apply")
  end

  return objectOverride
end

return {
  LoadObjectData = LoadObjectData,
}
