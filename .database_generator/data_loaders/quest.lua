local helpers = require(".db_helpers")
local f = string.format

---Loads quest data from the database and merges it with static corrections.
---This function reads the raw quest database file, applies static corrections
---from the addon environment, and returns a merged override table.
---@param lowerQuestieVersion string The version prefix for the database file (e.g., "Classic", "TBC")
---@param LibQuestieDBTable LibQuestieDB The QuestieDB library table containing correction data
---@return table<QuestId, table<number, any>>? Returns merged quest data table, or nil if database file not found
local function LoadQuestData(lowerQuestieVersion, LibQuestieDBTable)
  ---@type table<QuestId, table<number, any>> Maps quest IDs to arrays of field values indexed by Meta.questKeys
  local questOverride = {}
  ---@type Meta
  local Meta = LibQuestieDBTable.Meta

  local file = FindFile(f("%sQuestDB.lua", lowerQuestieVersion), nil, {}, helpers.get_script_dir())
  if not file then
    print(f("Failed to find %sQuestDB.lua", lowerQuestieVersion))
    print("Please run generate_database.sh or manually check out Questie into Questie-data folder")
    return nil
  end

  -- Load the raw QuestDB.lua file content as a string.
  CLI_Helpers.loadFile(file)

  -- Execute the string to get the raw quest data table.
  local err
  questOverride, err = loadstring(QuestieDB.questData)() -- QuestieDB.questData is loaded by loadFile
  if not questOverride or err then
    print("Error loading quest data:", err)
    return nil
  end

  -- Load static corrections registered within the addon environment.
  -- * Do not load dynamic corrections (includeDynamic = false)
  -- * Load static corrections only (includeStatic = true)
  LibQuestieDBTable.Quest.LoadOverrideData(false, true)

  ---@type QuestMeta
  local questMeta = Meta.QuestMeta

  -- Iterate through the loaded static corrections.
  ---@param questId QuestId
  ---@param corrections table<string, any> @ Map of field name -> corrected value
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for questId, corrections in pairs(LibQuestieDBTable.Quest.override) do
    -- Ensure an entry exists for this ID in the main override table.
    if not questOverride[questId] then
      questOverride[questId] = {}
    end

    -- Merge each correction, converting field name to numeric index.
    ---@param key string @ Field name (e.g., "name", "requiredLevel", "objectives")
    ---@param correction any @ The corrected value
    for key, correction in pairs(corrections) do
      ---@type number Index position in the quest data array
      local correctionIndex = questMeta.questKeys[key]
      questOverride[questId][correctionIndex] = correction
    end
  end

  -- Validate that corrections were processed if they exist
  local correctionCount = 0
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for _ in pairs(LibQuestieDBTable.Quest.override) do
    correctionCount = correctionCount + 1
  end
  if correctionCount > 0 then
    assert(next(questOverride), "Quest override table is empty despite having corrections to apply")
  end

  return questOverride
end

return {
  LoadQuestData = LoadQuestData,
}
