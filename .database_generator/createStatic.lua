local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

require(".dump")

require("cli.Addon_Meta")
require("cli.CLI_Helpers")
local lfs = require("lfs")

assert(Is_CLI, "This function should only be called from the CLI environment")

local f = string.format

Is_Create_Static = true

--- Takes the raw database files (_data/*DB.lua) and the static corrections,
--- merges them, and outputs the final combined data into both .lua-table format
--- (for potential debugging/diffing) and the SimpleHTML format used by the addon.
---@param version string # The WoW version identifier (e.g., "classic", "wrath", "cata"). Case-insensitive.
---@param debug boolean? # Optional debug flag
function DumpDatabase(version, debug)
  local lowerVersion = version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the core addon files for the specified version, and set WoW version globals.
  ---@type LibQuestieDB
  LibQuestieDBTable = AddonInitializeVersion(capitalizedVersion)

  -- Drain all the timers
  C_Timer.drainTimerList()

  -- Initialize tables to hold the merged data (raw data + static corrections).
  ---@type table<ItemId, table<number, any>>
  local itemOverride = {}
  ---@type table<NpcId, table<number, any>>
  local npcOverride = {}
  ---@type table<ObjectId, table<number, any>>
  local objectOverride = {}
  ---@type table<QuestId, table<number, any>>
  local questOverride = {}

  ---@type Corrections
  local Corrections = LibQuestieDBTable.Corrections

  -- Run self-tests on the dump functions to ensure they produce correct output.
  Corrections.DumpFunctions.testDumpFunctions()

  -- Process Item Data: Load raw DB, load static corrections, merge corrections into raw data.
  do
    -- Load the raw ItemDB.lua file content as a string.
    CLI_Helpers.loadFile(f("%s/_data/%sItemDB.lua", script_dir, lowerVersion))
    -- Execute the string to get the raw item data table.
    ---@type table<ItemId, table<number, any>>
    itemOverride = loadstring(QuestieDB.itemData)()      -- QuestieDB.itemData is loaded by loadFile
    -- Load static corrections registered within the addon environment.
    LibQuestieDBTable.Item.LoadOverrideData(false, true) -- includeStatic = true
    ---@type ItemMeta
    local itemMeta = Corrections.ItemMeta
    -- Iterate through the loaded static corrections.
    ---@param itemId ItemId
    ---@param corrections table<string, any> @ Map of field name -> corrected value
    for itemId, corrections in pairs(LibQuestieDBTable.Item.override) do
      -- Ensure an entry exists for this ID in the main override table.
      if not itemOverride[itemId] then
        itemOverride[itemId] = {}
      end
      -- Merge each correction, converting field name to numeric index.
      ---@param key string @ Field name (e.g., "name", "requiredLevel")
      ---@param correction any @ The corrected value
      for key, correction in pairs(corrections) do
        ---@type number
        local correctionIndex = itemMeta.itemKeys[key]
        itemOverride[itemId][correctionIndex] = correction
      end
    end
  end

  -- Process NPC Data: Load raw DB, load static corrections, merge corrections into raw data.
  do
    CLI_Helpers.loadFile(f("%s/_data/%sNpcDB.lua", script_dir, lowerVersion))

    ---@type table<NpcId, table<number, any>>
    npcOverride = loadstring(QuestieDB.npcData)()
    LibQuestieDBTable.Npc.LoadOverrideData(false, true)

    ---@type NpcMeta
    local npcMeta = Corrections.NpcMeta

    ---@param npcId NpcId
    ---@param corrections table<string, any>
    for npcId, corrections in pairs(LibQuestieDBTable.Npc.override) do
      if not npcOverride[npcId] then
        npcOverride[npcId] = {}
      end

      ---@param key string
      ---@param correction any
      for key, correction in pairs(corrections) do
        ---@type number
        local correctionIndex = npcMeta.npcKeys[key]
        npcOverride[npcId][correctionIndex] = correction
      end
    end
  end

  -- Process Object Data: Load raw DB, load static corrections, merge corrections into raw data.
  do
    CLI_Helpers.loadFile(f("%s/_data/%sObjectDB.lua", script_dir, lowerVersion))

    ---@type table<ObjectId, table<number, any>>
    objectOverride = loadstring(QuestieDB.objectData)()
    LibQuestieDBTable.Object.LoadOverrideData(false, true)

    ---@type ObjectMeta
    local objectMeta = Corrections.ObjectMeta

    ---@param objectId ObjectId
    ---@param corrections table<string, any>
    for objectId, corrections in pairs(LibQuestieDBTable.Object.override) do
      if not objectOverride[objectId] then
        objectOverride[objectId] = {}
      end

      ---@param key string
      ---@param correction any
      for key, correction in pairs(corrections) do
        ---@type number
        local correctionIndex = objectMeta.objectKeys[key]
        objectOverride[objectId][correctionIndex] = correction
      end
    end
  end

  -- Process Quest Data: Load raw DB, load static corrections, merge corrections into raw data.
  do
    CLI_Helpers.loadFile(f("%s/_data/%sQuestDB.lua", script_dir, lowerVersion))

    ---@type table<QuestId, table<number, any>>
    questOverride = loadstring(QuestieDB.questData)()
    LibQuestieDBTable.Quest.LoadOverrideData(false, true)

    ---@type QuestMeta
    local questMeta = Corrections.QuestMeta

    ---@param questId QuestId
    ---@param corrections table<string, any>
    for questId, corrections in pairs(LibQuestieDBTable.Quest.override) do
      if not questOverride[questId] then
        questOverride[questId] = {}
      end

      ---@param key string
      ---@param correction any
      for key, correction in pairs(corrections) do
        ---@type number
        local correctionIndex = questMeta.questKeys[key]
        questOverride[questId][correctionIndex] = correction
      end
    end
  end
  -- Create output directories if they don't exist.
  -- ---@type string
  -- local basePath = f("%s/_data/output", script_dir)
  ---@type string
  local basePath = f("%s/../Database", script_dir)
  if not lfs.attributes(basePath, "mode") then
    lfs.mkdir(basePath)
    print("Created directory: " .. basePath)
  end
  local entityTypes = { "Item", "Npc", "Object", "Quest", }
  for _, entityType in ipairs(entityTypes) do
    local path = f("%s/%s", basePath, entityType)
    if not lfs.attributes(path, "mode") then
      lfs.mkdir(path)
      print("Created directory: " .. path)
    end
    local versionPath = f("%s/%s", path, capitalizedVersion)
    if not lfs.attributes(versionPath, "mode") then
      lfs.mkdir(versionPath)
      print("Created directory: " .. versionPath)
    end
  end

  -- ! We write all these files to disk for the sake of comparing changes between versions
  -- Write all the overrides to disk

  -- ? Dump L10n Data
  print("Dumping L10n overrides")
  -- Read the L10n data from the addon.
  -- example path: Database\l10n\Wotlk\l10nData.lua-table
  local path = f("%s/l10n/%s/l10nData.lua-table", basePath, capitalizedVersion)
  print("Reading L10n data from " .. path)
  local l10nFile = io.open(path, "r")
  assert(l10nFile, "Failed to open file for reading " .. path)
  local l10nDataString = l10nFile:read("*a")
  l10nFile:close()
  local l10nData, errormsg = loadstring("return " .. l10nDataString)
  if not l10nData then
    print("Error loading L10n data: " .. errormsg)
    return
  end
  l10nData = l10nData()
  GenerateHtmlForEntityType(l10nData, nil, "L10n", version, debug)

  -- ? Dump Item Data
  print("Dumping item overrides")
  -- Generate the string representation of the merged item data.
  ---@type string
  local itemDataString = helpers.dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs,
                                          Corrections.ItemMeta.combine)
  -- Write the string to ItemData.lua-table.
  local itemFile = io.open(f("%s/Item/%s/ItemData.lua-table", basePath, capitalizedVersion), "w")
  assert(itemFile, "Failed to open file for writing")
  itemFile:write(itemDataString)
  itemFile:close()
  -- Generate the SimpleHTML files used by the addon.
  print("Dumping item overrides to HTML")
  GenerateHtmlForEntityType(itemOverride, Corrections.ItemMeta, "Item", version, debug)

  -- ? Dump Quest Data
  print("Dumping quest overrides")
  local questDataString = helpers.dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  local questFile = io.open(f("%s/Quest/%s/QuestData.lua-table", basePath, capitalizedVersion), "w")
  assert(questFile, "Failed to open file for writing")
  questFile:write(questDataString)
  questFile:close()
  print("Dumping quest overrides to HTML")
  GenerateHtmlForEntityType(questOverride, Corrections.QuestMeta, "Quest", version, debug)

  -- ? Dump Npc Data
  print("Dumping npc overrides")
  local npcDataString = helpers.dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs,
                                         Corrections.NpcMeta.combine)
  local npcFile = io.open(f("%s/Npc/%s/NpcData.lua-table", basePath, capitalizedVersion), "w")
  assert(npcFile, "Failed to open file for writing")
  npcFile:write(npcDataString)
  npcFile:close()
  print("Dumping npc overrides to HTML")
  GenerateHtmlForEntityType(npcOverride, Corrections.NpcMeta, "Npc", version, debug)

  -- ? Dump Object Data
  print("Dumping object overrides")
  local objectDataString = helpers.dumpData(objectOverride, Corrections.ObjectMeta.objectKeys,
                                            Corrections.ObjectMeta.dumpFuncs)
  local objectFile = io.open(f("%s/Object/%s/ObjectData.lua-table", basePath, capitalizedVersion), "w")
  assert(objectFile, "Failed to open file for writing")
  objectFile:write(objectDataString)
  objectFile:close()
  print("Dumping object overrides to HTML")
  GenerateHtmlForEntityType(objectOverride, Corrections.ObjectMeta, "Object", version, debug)


  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedVersion))
end
