-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

local l10n_loader = require(".load_translations_l10n")

require(".dump")

require("cli.Addon_Meta")
require("cli.CLI_Helpers")
local lfs = require("lfs")

local item_loader = require(".data_loaders.item")
local npc_loader = require(".data_loaders.npc")
local object_loader = require(".data_loaders.object")
local quest_loader = require(".data_loaders.quest")
local l10n_data_loader = require(".data_loaders.l10n")

assert(Is_CLI, "This function should only be called from the CLI environment")

local f = string.format
local rep = string.rep

Is_Create_Static = true

-- Color helper function for terminal output formatting
local c = helpers.colorizeText

---Compiles the complete QuestieDB database from raw data files and static corrections.
---This function orchestrates the entire database compilation process: loads raw database files,
---applies static corrections, merges localization data, and outputs the final database in both
---Lua table format (for debugging) and HTML format (for addon consumption).
---@param questiedb_version string The WoW version identifier (e.g., "era", "wrath", "cata"). Case-insensitive.
---@param questie_version string The Questie version identifier (e.g., "Classic", "TBC", "WotLK"). Case-insensitive.
---@param debug boolean? Optional debug flag to enable additional debug output in generated files
function DumpDatabase(questiedb_version, questie_version, debug)
  local lowerQuestieDBVersion = questiedb_version:lower()
  local capitalizedQuestieDBVersion = lowerQuestieDBVersion:gsub("^%l", string.upper)

  local lowerQuestieVersion = questie_version:lower()

  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedQuestieDBVersion))

  --------------------------------------------------------------------
  -- Phase 1: Initialize the addon environment for the specified version
  --------------------------------------------------------------------

  -- Reset data objects, load the core addon files for the specified version, and set WoW version globals.
  ---@type LibQuestieDB
  LibQuestieDBTable = AddonInitializeVersion(capitalizedQuestieDBVersion)

  -- Note: ADDON_LOADED event processing is currently disabled
  -- This would trigger final database initialization in a real addon environment
  print("Executing event: ADDON_LOADED")
  LibQuestieDBTable.RegisteredEvents["ADDON_LOADED"](CLI_addonName or "QuestieDB")

  -- Run until database is initialized or timeout occurs
  C_Timer.WaitForAllTimers(10, function()
    return LibQuestieDBTable.Database.Initialized
  end)

  -- Check if the database was initialized successfully
  if not LibQuestieDBTable.Database.Initialized then
    error("Database not initialized")
  end

  ---@type Meta
  local Meta = LibQuestieDBTable.Meta

  --------------------------------------------------------------------
  -- Phase 2: Validate dump functions before processing
  --------------------------------------------------------------------
  -- Run self-tests on the dump functions to ensure they produce correct output.
  Meta.DumpFunctions.testDumpFunctions()

  --------------------------------------------------------------------
  -- Phase 3: Load and merge data from all entity types
  --------------------------------------------------------------------

  ---@class dbData
  local dbData = {
    -- Define the entity types for which we will generate database files.
    ---@type table<string>
    entityTypes = { "Item", "Npc", "Object", "Quest", },

    --- Check if an ID exists in any of the tables
    ---@param entityType string The entity type to check (Item, Npc, Object, Quest)
    ---@param id ItemId|NpcId|ObjectId|QuestId
    ---@return boolean
    exists = function(self, entityType, id)
      if not entityType or type(entityType) ~= "string" then
        error("entityType must be a non-empty string")
      end
      local overrideTable = self[entityType:lower() .. "Override"]
      if not overrideTable then
        error("Unknown entity type: " .. entityType)
      end
      -- Check if the id exists in any of the override tables
      if overrideTable[id] then
        return true
      end
      return false
    end,

    -- Load item data: raw database + static corrections
    ---@type table<ItemId, table<number, any>>?
    itemOverride = item_loader.LoadItemData(lowerQuestieVersion, LibQuestieDBTable),
    -- Load NPC data: raw database + static corrections
    ---@type table<NpcId, table<number, any>>?
    npcOverride = npc_loader.LoadNpcData(lowerQuestieVersion, LibQuestieDBTable),
    -- Load object data: raw database + static corrections
    ---@type table<ObjectId, table<number, any>>?
    objectOverride = object_loader.LoadObjectData(lowerQuestieVersion, LibQuestieDBTable),
    -- Load quest data: raw database + static corrections
    ---@type table<QuestId, table<number, any>>?
    questOverride = quest_loader.LoadQuestData(lowerQuestieVersion, LibQuestieDBTable),
  }

  print("\n")
  print(c("Startup of database successful!", "green"))
  print("\n")

  --------------------------------------------------------------------
  -- Phase 4: Load localization data
  -- Load translation data for all entity types and merge with Mangos translations
  --------------------------------------------------------------------
  ---@type table<ItemId|NpcId|ObjectId|QuestId, table<L10nDBKeys, table<L10nLocales, any>>>
  local l10nOverride = l10n_data_loader.LoadL10nData(questie_version, lowerQuestieDBVersion, Meta, dbData)

  --------------------------------------------------------------------
  -- Phase 5: File output preparation
  -- Processing of the data is complete, now we need to write it to disk
  --------------------------------------------------------------------

  -- Create the base output directory structure if it doesn't exist
  ---@type string
  local basePath = f("%s/Database", helpers.get_project_dir_path())
  if not lfs.attributes(basePath, "mode") then
    lfs.mkdir(basePath)
    print("Created directory: " .. basePath)
  end

  -- Create entity type directories for each data type
  for _, entityType in ipairs(dbData.entityTypes) do
    local path = f("%s/%s", basePath, entityType)
    if not lfs.attributes(path, "mode") then
      lfs.mkdir(path)
      print("Created directory: " .. path)
    end
    -- Create version-specific subdirectories
    local versionPath = f("%s/%s", path, capitalizedQuestieDBVersion)
    if not lfs.attributes(versionPath, "mode") then
      lfs.mkdir(versionPath)
      print("Created directory: " .. versionPath)
    end
  end

  -- Create the l10n directory structure
  local l10nPath = f("%s/l10n", basePath)
  if not lfs.attributes(l10nPath, "mode") then
    lfs.mkdir(l10nPath)
    print("Created directory: " .. l10nPath)
  end
  local versionPath = f("%s/%s", l10nPath, capitalizedQuestieDBVersion)
  if not lfs.attributes(versionPath, "mode") then
    lfs.mkdir(versionPath)
    print("Created directory: " .. versionPath)
  end

  -- Phase 6: Data output generation
  -- Write all processed data to disk for debugging/comparison and addon consumption

  -- ! Export L10n data in both formats
  print(c("\nDumping L10n overrides", "yellow"))

  -- Dump the full l10n data (Kept for reference, not used currently)
  -- local fullL10nDumpString = l10n_loader.DumpL10nData(Meta.L10nMeta, dbData.entityTypes, l10nOverride)
  -- local fullL10nPath = f("%s/l10n/%s/l10nData.lua-table", basePath, capitalizedQuestieDBVersion)
  -- local fullL10nFile = io.open(fullL10nPath, "w")
  -- if fullL10nFile and fullL10nDumpString then
  --   fullL10nFile:write(fullL10nDumpString)
  --   fullL10nFile:close()
  --   print("Dumped full l10n data to " .. fullL10nPath)
  -- else
  --   print("Failed to open file for writing: " .. fullL10nPath)
  -- end

  local l10nDumpStrings = l10n_loader.DumpL10nDataByType(Meta.L10nMeta, dbData.entityTypes, l10nOverride)
  local l10nPathsByType = {}
  for _, entityType in ipairs(dbData.entityTypes) do
    local dumpString = l10nDumpStrings[entityType]
    local l10nPath = f("%s/l10n/%s/l10n%sData.lua-table", basePath, capitalizedQuestieDBVersion, entityType)
    l10nPathsByType[entityType] = l10nPath

    local l10nDumpFile = io.open(l10nPath, "w")
    if not l10nDumpFile then
      print("Failed to open file for writing: " .. l10nPath)
    elseif not dumpString then
      l10nDumpFile:close()
      print("No dump data for entity type: " .. entityType)
    else
      l10nDumpFile:write(dumpString)
      l10nDumpFile:close()
      print("Dumped l10n data to " .. l10nPath)
    end
  end

  -- Reload L10n data from files to ensure consistency
  print("Reading L10n data from split dumps")
  local l10nData = l10n_loader.LoadL10nByType(l10nPathsByType, Meta.L10nMeta)

  -- Generate HTML format for addon consumption
  GenerateHtmlForEntityType(l10nData, Meta.L10nMeta, "l10n", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(l10nData, Corrections.L10nMeta, "L10n", version, 75, 650, debug)

  -- ! Export Item data in both formats
  print(c("\nDumping item overrides", "yellow"))
  -- Generate the string representation of the merged item data
  ---@type string
  local itemDataString = helpers.dumpData(dbData.itemOverride, Meta.ItemMeta.itemKeys, Meta.ItemMeta.dumpFuncs,
                                          Meta.ItemMeta.combine)
  -- Write item data to ItemData.lua-table for debugging
  local itemFile = io.open(f("%s/Item/%s/ItemData.lua-table", basePath, capitalizedQuestieDBVersion), "w")
  assert(itemFile, "Failed to open file for writing")
  itemFile:write(itemDataString)
  itemFile:close()

  -- Generate HTML format for addon consumption
  GenerateHtmlForEntityType(dbData.itemOverride, Meta.ItemMeta, "Item", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(dbData.itemOverride, Corrections.ItemMeta, "Item", version, 75, 650, debug)

  -- ! Export Quest data in both formats
  print(c("\nDumping quest overrides", "yellow"))
  local questDataString = helpers.dumpData(dbData.questOverride, Meta.QuestMeta.questKeys, Meta.QuestMeta.dumpFuncs)
  -- Write quest data to QuestData.lua-table for debugging
  local questFile = io.open(f("%s/Quest/%s/QuestData.lua-table", basePath, capitalizedQuestieDBVersion), "w")
  assert(questFile, "Failed to open file for writing")
  questFile:write(questDataString)
  questFile:close()

  -- Generate HTML format for addon consumption
  GenerateHtmlForEntityType(dbData.questOverride, Meta.QuestMeta, "Quest", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(dbData.questOverride, Corrections.QuestMeta, "Quest", version, 75, 650, debug)

  -- ! Export NPC data in both formats
  print(c("\nDumping npc overrides", "yellow"))
  local npcDataString = helpers.dumpData(dbData.npcOverride, Meta.NpcMeta.npcKeys, Meta.NpcMeta.dumpFuncs,
                                         Meta.NpcMeta.combine)
  -- Write NPC data to NpcData.lua-table for debugging
  local npcFile = io.open(f("%s/Npc/%s/NpcData.lua-table", basePath, capitalizedQuestieDBVersion), "w")
  assert(npcFile, "Failed to open file for writing")
  npcFile:write(npcDataString)
  npcFile:close()

  -- Generate HTML format for addon consumption
  GenerateHtmlForEntityType(dbData.npcOverride, Meta.NpcMeta, "Npc", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(dbData.npcOverride, Corrections.NpcMeta, "Npc", version, 75, 650, debug)

  -- ! Export Object data in both formats
  print("\n")
  print(c("Dumping object overrides", "yellow"))
  local objectDataString = helpers.dumpData(dbData.objectOverride, Meta.ObjectMeta.objectKeys,
                                            Meta.ObjectMeta.dumpFuncs)
  -- Write object data to ObjectData.lua-table for debugging
  local objectFile = io.open(f("%s/Object/%s/ObjectData.lua-table", basePath, capitalizedQuestieDBVersion), "w")
  assert(objectFile, "Failed to open file for writing")
  objectFile:write(objectDataString)
  objectFile:close()

  -- Generate HTML format for addon consumption
  GenerateHtmlForEntityType(dbData.objectOverride, Meta.ObjectMeta, "Object", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(dbData.objectOverride, Corrections.ObjectMeta, "Object", version, 75, 650, debug)

  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedQuestieDBVersion))
end
