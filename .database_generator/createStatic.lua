local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local helpers = require(".db_helpers")

local l10n_loader = require("load_translations_l10n")

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
---@param questiedb_version string # The WoW version identifier (e.g., "classic", "wrath", "cata"). Case-insensitive.
---@param questie_version string # The Questie version identifier (e.g., "Classic", "TBC", "Wotlk"). Case-insensitive.
---@param debug boolean? # Optional debug flag
function DumpDatabase(questiedb_version, questie_version, debug)
  local lowerVersion = questiedb_version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the core addon files for the specified version, and set WoW version globals.
  ---@type LibQuestieDB
  LibQuestieDBTable = AddonInitializeVersion(capitalizedVersion)

  -- Drain all the timers
  print("Pre-Drain timer list")
  C_Timer.drainTimerList()

  -- print("Executing event: ADDON_LOADED")
  -- LibQuestieDBTable.RegisteredEvents["ADDON_LOADED"](CLI_addonName or "QuestieDB")

  -- -- Drain all the timers
  -- print("ADDON_LOADED timer list")
  -- C_Timer.drainTimerList()

  -- if not LibQuestieDBTable.Database.Initialized then
  --   error("Database not initialized")
  -- end

  -- Initialize tables to hold the merged data (raw data + static corrections).
  ---@type table<ItemId, table<number, any>>
  local itemOverride = {}
  ---@type table<NpcId, table<number, any>>
  local npcOverride = {}
  ---@type table<ObjectId, table<number, any>>
  local objectOverride = {}
  ---@type table<QuestId, table<number, any>>
  local questOverride = {}
  ---@type table<ItemId|NpcId|ObjectId|QuestId, table<L10nDBKeys, table<L10nLocales, any>>>
  local l10nOverride = {}

  ---@type Corrections
  local Corrections = LibQuestieDBTable.Corrections

  -- Run self-tests on the dump functions to ensure they produce correct output.
  Corrections.DumpFunctions.testDumpFunctions()

  -- Define the entity types for which we will generate HTML files.
  local entityTypes = { "Item", "Npc", "Object", "Quest", }

  -- Process Item Data: Load raw DB, load static corrections, merge corrections into raw data.
  do
    -- Load the raw ItemDB.lua file content as a string.
    CLI_Helpers.loadFile(f("%s/_data/%sItemDB.lua", helpers.get_script_dir(), lowerVersion))
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
    CLI_Helpers.loadFile(f("%s/_data/%sNpcDB.lua", helpers.get_script_dir(), lowerVersion))

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
    CLI_Helpers.loadFile(f("%s/_data/%sObjectDB.lua", helpers.get_script_dir(), lowerVersion))

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
    CLI_Helpers.loadFile(f("%s/_data/%sQuestDB.lua", helpers.get_script_dir(), lowerVersion))

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

  -- Process L10n Data: Load raw DB, load static corrections, merge corrections into raw data.
  local output
  do
    -- ? l10n dump
    print("Loading version: " .. questie_version)
    for datatype in pairs(Corrections.L10nMeta.l10nKeys) do
      l10n_loader.CleanFiles(questie_version, datatype)
    end

    -- Create the lookup tables for the translations (This will import a singular ImportModule table)
    -- The "l10n" is not required here.
    ---@see AddonInitializeVersion
    local l10n = QuestieLoader:ImportModule()
    for _, entityType in ipairs(entityTypes) do
      local newLookup = entityType:lower() .. "Lookup"
      l10n[newLookup] = {}
      CLI_Helpers.loadXML(helpers.get_project_dir_path() ..
        f("/.database_generator/Questie-translations/Localization/lookups/%s/lookup%ss/lookup%ss.clean.xml", questie_version, entityType, entityType))
    end

    -- Validate that all the lookups are loaded
    for _, entityType in ipairs(entityTypes) do
      print("Validating " .. entityType .. " lookup")
      local lookup = l10n[entityType:lower() .. "Lookup"]
      if not lookup then
        print("Failed to load " .. entityType .. " lookup")
        os.exit(0)
        return
      end
      -- Validate that all locales are loaded
      for _, locale in ipairs(Corrections.L10nMeta.locales) do
        -- if locale ~= "enUS" then
        print("    Validating " .. entityType .. " lookup for locale: " .. locale)
        if not lookup[locale] then
          print("Failed to load " .. entityType .. " lookup for locale: " .. locale)
          os.exit(0)
          return
        end
        -- end
      end
    end

    -- Load the mangos translations, it will not replace the existing translations, but will add to them.
    print("Trying to load", helpers.get_project_dir_path() ..
      f("/.database_generator/mangos_translation/translations/%s/locales_%s.xml", lowerVersion, lowerVersion))
    CLI_Helpers.loadXML(
      helpers.get_project_dir_path() ..
      f("/.database_generator/mangos_translation/translations/%s/locales_%s.xml", lowerVersion, lowerVersion),
      true
    )

    --- Defines how to merge Mangos data into existing Questie data for each entity type
    --- if an entry for the same ID and locale already exists.
    ---@type table<"Item"|"Npc"|"Object"|"Quest",  fun(base_data: any, insert_data: any): (any?, boolean)>
    local mergeFunctions = {
      -- For Items, if the base Questie translation is empty, use the Mangos one. Otherwise, keep the Questie one.
      ["Item"] = function(base_data, insert_data)
        ---@cast base_data string
        ---@cast insert_data string
        assert(type(base_data) == "string", "base_data is not a string")
        assert(type(insert_data) == "string", "insert_data is not a string")
        if base_data == "" or base_data == nil then
          return insert_data, true -- Use Mangos data, indicate injection
        end
        return nil, false          -- Keep Questie data, indicate no injection
      end,
      -- For NPCs, merge only if the Mangos data provides fields missing in the Questie data.
      ["Npc"] = function(base_data, insert_data)
        ---@cast base_data table
        ---@cast insert_data table
        assert(type(base_data) == "table", "base_data is not a table")
        assert(type(insert_data) == "table", "insert_data is not a table")
        local dataInjected = false
        for k, v in pairs(insert_data) do
          if not base_data[k] and v then -- If Questie data is missing this key
            base_data[k] = v             -- Add the Mangos data for this key
            dataInjected = true
          end
        end
        -- Note: This function modifies base_data directly. The return value isn't used for replacement, only the boolean.
        return nil, dataInjected
      end,
      -- For Objects, same logic as Items: use Mangos only if Questie data is empty.
      ["Object"] = function(base_data, insert_data)
        ---@cast base_data string
        ---@cast insert_data string
        assert(type(base_data) == "string", "base_data is not a string")
        assert(type(insert_data) == "string", "insert_data is not a string")
        if base_data == "" or base_data == nil then
          return insert_data, true -- Use Mangos data, indicate injection
        end
        return nil, false          -- Keep Questie data, indicate no injection
      end,
      -- For Quests, same logic as NPCs: merge only missing fields from Mangos.
      -- Example Mangos Quest data structure:
      -- [2] = {"Klaue von Scharfkralle", {"Der mächtige Hippogryph Scharfkralle wurde getötet..."}, {"Bringt die Klaue..."}},
      ["Quest"] = function(base_data, insert_data)
        ---@cast base_data table
        ---@cast insert_data table
        assert(type(base_data) == "table", "base_data is not a table")
        assert(type(insert_data) == "table", "insert_data is not a table")
        local dataInjected = false
        for k, v in pairs(insert_data) do
          if not base_data[k] and v then -- If Questie data is missing this key
            base_data[k] = v             -- Add the Mangos data for this key
            dataInjected = true
          end
        end
        -- Note: This function modifies base_data directly. The return value isn't used for replacement, only the boolean.
        return nil, dataInjected
      end,
    }

    -- Iterate through each entity type (Item, Npc, Object, Quest)
    ---@param entityType "Item"|"Npc"|"Object"|"Quest"
    for _, entityType in ipairs(entityTypes) do
      print("Trying to load mangos translations for " .. entityType)
      -- Get the Questie lookup table for this entity type (e.g., l10n.itemLookup)
      local lookup = l10n[entityType:lower() .. "Lookup"]
      -- Get the Mangos data loaded from the XML file (e.g., locales_item)
      ---@type table<L10nLocales, table<number, any>>?
      local mangos_data = _G[f("locales_%s", entityType:lower())]
      assert(mangos_data, "Failed to load mangos data, run the script in mangos_translation")

      -- Iterate through each locale provided by the Mangos data (e.g., "deDE", "frFR")
      ---@param locale L10nLocales
      ---@param mangos_item table<number, any> @ Mangos translations for this locale and entity type
      for locale, mangos_item in pairs(mangos_data) do
        local added_data = 0  -- Count of entirely new entries added from Mangos
        local merged_data = 0 -- Count of existing Questie entries modified by Mangos data

        -- Check if Questie has a lookup table for this locale
        if lookup[locale] then
          -- Load the actual Questie translation data for this locale and entity type
          ---@type table<number, any>
          local lookup_data = lookup[locale]()                       -- Execute the function to get the table
          l10n[entityType:lower() .. "Lookup"][locale] = lookup_data -- Store the loaded table back

          -- Sort Mangos IDs for deterministic processing
          ---@type number[]
          local sorted_ids = {}
          ---@param entityId number
          for entityId in pairs(mangos_item) do
            table.insert(sorted_ids, entityId)
          end
          table.sort(sorted_ids) -- Simple numeric sort

          -- Iterate through the sorted Mangos entity IDs for this locale
          ---@param entityId number
          for _, entityId in ipairs(sorted_ids) do
            ---@type any
            local v = mangos_item[entityId] -- The Mangos translation data for this ID

            -- Check if Questie already has a translation for this ID and locale
            if lookup_data[entityId] then
              -- Questie has data, attempt to merge using the type-specific function
              if mergeFunctions[entityType] then
                local mergeResult, dataInjected = mergeFunctions[entityType](lookup_data[entityId], v)
                if dataInjected then
                  merged_data = merged_data + 1
                  -- If merge function returned a new value (Item/Object), replace the Questie data
                  if mergeResult then
                    lookup_data[entityId] = mergeResult
                  end
                  -- For Npc/Quest, the merge function modifies lookup_data[entityId] directly.
                end
              end
            else
              -- Questie does not have data for this ID, add the Mangos data directly
              added_data = added_data + 1
              lookup_data[entityId] = v
            end
          end
        end
        print(f("  Locale [%s]: Added %d new entries, Merged data into %d existing entries.", locale, added_data, merged_data))
      end
    end


    print("All lookups and locales loaded successfully")

    -- Create the l10n data table
    l10nOverride = l10n_loader.GenerateL10nTranslation(Corrections.L10nMeta.locales, entityTypes, l10n)

    output = l10n_loader.DumpL10nData(Corrections.L10nMeta, entityTypes, l10nOverride)
  end

  --------------------------------------------------------------------
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- ? Processing of the data is done, now we need to write it to disk
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  --------------------------------------------------------------------

  -- Create output directories if they don't exist.
  -- ---@type string
  -- local basePath = f("%s/_data/output", helpers.get_script_dir())
  ---@type string
  local basePath = f("%s../Database", helpers.get_script_dir())
  if not lfs.attributes(basePath, "mode") then
    lfs.mkdir(basePath)
    print("Created directory: " .. basePath)
  end
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

  local l10nDumpFile = io.open(f("%s/l10n/%s/l10nData.lua-table", basePath, capitalizedVersion), "w")
  if l10nDumpFile and output then
    l10nDumpFile:write(output)
    l10nDumpFile:close()
    print("Dumped l10n data to " .. f("%s/l10n/%s/l10nData.lua-table", basePath, capitalizedVersion))
  else
    print("Failed to open file for writing: " .. f("%s/l10n/%s/l10nData.lua-table", basePath, capitalizedVersion))
  end

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
  GenerateHtmlForEntityType(l10nData, Corrections.L10nMeta, "L10n", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(l10nData, Corrections.L10nMeta, "L10n", version, 75, 650, debug)

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
  GenerateHtmlForEntityType(itemOverride, Corrections.ItemMeta, "Item", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(itemOverride, Corrections.ItemMeta, "Item", version, 75, 650, debug)

  -- ? Dump Quest Data
  print("Dumping quest overrides")
  local questDataString = helpers.dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  local questFile = io.open(f("%s/Quest/%s/QuestData.lua-table", basePath, capitalizedVersion), "w")
  assert(questFile, "Failed to open file for writing")
  questFile:write(questDataString)
  questFile:close()
  print("Dumping quest overrides to HTML")
  GenerateHtmlForEntityType(questOverride, Corrections.QuestMeta, "Quest", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(questOverride, Corrections.QuestMeta, "Quest", version, 75, 650, debug)

  -- ? Dump Npc Data
  print("Dumping npc overrides")
  local npcDataString = helpers.dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs,
                                         Corrections.NpcMeta.combine)
  local npcFile = io.open(f("%s/Npc/%s/NpcData.lua-table", basePath, capitalizedVersion), "w")
  assert(npcFile, "Failed to open file for writing")
  npcFile:write(npcDataString)
  npcFile:close()
  print("Dumping npc overrides to HTML")
  GenerateHtmlForEntityType(npcOverride, Corrections.NpcMeta, "Npc", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(npcOverride, Corrections.NpcMeta, "Npc", version, 75, 650, debug)

  -- ? Dump Object Data
  print("Dumping object overrides")
  local objectDataString = helpers.dumpData(objectOverride, Corrections.ObjectMeta.objectKeys,
                                            Corrections.ObjectMeta.dumpFuncs)
  local objectFile = io.open(f("%s/Object/%s/ObjectData.lua-table", basePath, capitalizedVersion), "w")
  assert(objectFile, "Failed to open file for writing")
  objectFile:write(objectDataString)
  objectFile:close()
  print("Dumping object overrides to HTML")
  GenerateHtmlForEntityType(objectOverride, Corrections.ObjectMeta, "Object", questiedb_version, nil, nil, debug)
  -- GenerateHtmlForEntityType(objectOverride, Corrections.ObjectMeta, "Object", version, 75, 650, debug)


  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedVersion))
end
