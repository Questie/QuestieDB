local helpers = require(".db_helpers")
local f = string.format

---Loads NPC data from the database and merges it with static corrections.
---This function reads the raw NPC database file, applies static corrections
---from the addon environment, and returns a merged override table.
---@param lowerQuestieVersion string The version prefix for the database file (e.g., "Classic", "TBC")
---@param LibQuestieDBTable LibQuestieDB The QuestieDB library table containing correction data
---@return table<NpcId, table<number, any>>? Returns merged NPC data table, or nil if database file not found
local function LoadNpcData(lowerQuestieVersion, LibQuestieDBTable)
  ---@type table<NpcId, table<number, any>> Maps NPC IDs to arrays of field values indexed by Meta.npcKeys
  local npcOverride = {}
  ---@type Meta
  local Meta = LibQuestieDBTable.Meta

  local file = FindFile(f("%sNpcDB.lua", lowerQuestieVersion), nil, {}, helpers.get_script_dir())
  if not file then
    print(f("Failed to find %sNpcDB.lua", lowerQuestieVersion))
    print("Please run generate_database.sh or manually check out Questie into Questie-data folder")
    return nil
  end

  -- Load the raw NpcDB.lua file content as a string.
  CLI_Helpers.loadFile(file)

  -- Execute the string to get the raw NPC data table.
  local err
  npcOverride, err = loadstring(QuestieDB.npcData)() -- QuestieDB.npcData is loaded by loadFile
  if not npcOverride or err then
    print("Error loading NPC data:", err)
    return nil
  end

  -- Load static corrections registered within the addon environment.
  -- * Do not load dynamic corrections (includeDynamic = false)
  -- * Load static corrections only (includeStatic = true)
  LibQuestieDBTable.Npc.LoadOverrideData(false, true)

  ---@type NpcMeta
  local npcMeta = Meta.NpcMeta

  -- Iterate through the loaded static corrections.
  ---@param npcId NpcId
  ---@param corrections table<string, any> @ Map of field name -> corrected value
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for npcId, corrections in pairs(LibQuestieDBTable.Npc.override) do
    -- Ensure an entry exists for this ID in the main override table.
    if not npcOverride[npcId] then
      npcOverride[npcId] = {}
    end

    -- Merge each correction, converting field name to numeric index.
    ---@param key string @ Field name (e.g., "name", "spawns", "questStarts")
    ---@param correction any @ The corrected value
    for key, correction in pairs(corrections) do
      ---@type number Index position in the NPC data array
      local correctionIndex = npcMeta.npcKeys[key]
      npcOverride[npcId][correctionIndex] = correction
    end
  end

  -- Validate that corrections were processed if they exist
  local correctionCount = 0
  ---@diagnostic disable-next-line: invisible -- Allow accessing private fields
  for _ in pairs(LibQuestieDBTable.Npc.override) do
    correctionCount = correctionCount + 1
  end
  if correctionCount > 0 then
    assert(next(npcOverride), "NPC override table is empty despite having corrections to apply")
  end

  return npcOverride
end

return {
  LoadNpcData = LoadNpcData,
}
