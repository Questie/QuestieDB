local helpers = require(".db_helpers")
local f = string.format

---Loads item data from the database and merges it with static corrections.
---This function reads the raw item database file, applies static corrections
---from the addon environment, and returns a merged override table.
---@param lowerQuestieVersion string The version prefix for the database file (e.g., "Classic", "TBC")
---@param LibQuestieDBTable LibQuestieDB The QuestieDB library table containing correction data
---@return table<ItemId, table<number, any>>? Returns merged item data table, or nil if database file not found
local function LoadItemData(lowerQuestieVersion, LibQuestieDBTable)
  ---@type table<ItemId, table<number, any>> Maps item IDs to arrays of field values indexed by Meta.itemKeys
  local itemOverride = {}
  ---@type Meta
  local Meta = LibQuestieDBTable.Meta

  local file = FindFile(f("%sItemDB.lua", lowerQuestieVersion), nil, {}, helpers.get_script_dir())
  if not file then
    print(f("Failed to find %sItemDB.lua", lowerQuestieVersion))
    print("Please run generate_database.sh or manually check out Questie into Questie-data folder")
    return nil
  end

  -- Load the raw ItemDB.lua file content as a string.
  CLI_Helpers.loadFile(file)

  -- Execute the string to get the raw item data table.
  local err
  itemOverride, err = loadstring(QuestieDB.itemData)() -- QuestieDB.itemData is loaded by loadFile
  if not itemOverride or err then
    print("Error loading item data:", err)
    return nil
  end

  -- Load static corrections registered within the addon environment.
  -- * Do not load dynamic corrections (includeDynamic = false)
  -- * Load static corrections only (includeStatic = true)
  LibQuestieDBTable.Item.LoadOverrideData(false, true)

  ---@type ItemMeta
  local itemMeta = Meta.ItemMeta

  -- Iterate through the loaded static corrections.
  ---@param itemId ItemId
  ---@param corrections table<string, any> @ Map of field name -> corrected value
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for itemId, corrections in pairs(LibQuestieDBTable.Item.override) do
    -- Ensure an entry exists for this ID in the main override table.
    if not itemOverride[itemId] then
      itemOverride[itemId] = {}
    end

    -- Merge each correction, converting field name to numeric index.
    ---@param key string @ Field name (e.g., "name", "requiredLevel", "itemLevel")
    ---@param correction any @ The corrected value
    for key, correction in pairs(corrections) do
      ---@type number Index position in the item data array
      local correctionIndex = itemMeta.itemKeys[key]
      itemOverride[itemId][correctionIndex] = correction
    end
  end

  -- Validate that corrections were processed if they exist
  local correctionCount = 0
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for _ in pairs(LibQuestieDBTable.Item.override) do
    correctionCount = correctionCount + 1
  end
  if correctionCount > 0 then
    assert(next(itemOverride), "Item override table is empty despite having corrections to apply")
  end

  return itemOverride
end

return {
  LoadItemData = LoadItemData,
}
