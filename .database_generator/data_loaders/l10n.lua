local helpers = require(".db_helpers")
local l10n_loader = require(".load_translations_l10n")

local f = string.format
local rep = string.rep

-- Color helper function for terminal output formatting
local c = helpers.colorizeText

---Injects Mangos translations into existing Questie translation data.
---This function loads Mangos translation XML files and merges them with Questie translations,
---using entity-specific merge strategies to avoid overwriting existing good data.
---@param lowerQuestieDBVersion string The version prefix for the database file (e.g., "era", "tbc")
---@param dbData dbData The database data structure containing data and helper functions
---@param l10n table The loaded Questie localization data structure containing lookup tables
---@return boolean success Returns true if all Mangos translations were successfully injected
local function InjectMangosTranslations(lowerQuestieDBVersion, dbData, l10n)
  -- Load the mangos translations, it will not replace the existing translations, but will add to them.
  print("\n")
  print(c(" Loading all mangos_translation files!", "yellow"))
  print("  Trying to load", helpers.get_script_dir() ..
    f("/mangos_translation/translations/%s/locales_%s.xml", lowerQuestieDBVersion, lowerQuestieDBVersion))
  CLI_Helpers.loadXML(
    helpers.get_script_dir() ..
    f("/mangos_translation/translations/%s/locales_%s.xml", lowerQuestieDBVersion, lowerQuestieDBVersion),
    true,
    3
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

  print("\n")

  -- Iterate through each entity type (Item, Npc, Object, Quest)
  ---@param entityType "Item"|"Npc"|"Object"|"Quest"
  for _, entityType in ipairs(dbData.entityTypes) do
    print(c(" Trying to load mangos translations for " .. entityType, "yellow"))
    -- Get the Questie lookup table for this entity type (e.g., l10n.itemLookup)
    local lookup = l10n[entityType:lower() .. "Lookup"]
    -- Get the Mangos data loaded from the XML file (e.g., locales_item)
    ---@type table<L10nLocales, table<number, any>>?
    local mangos_data = _G[f("locales_%s", entityType:lower())]
    assert(mangos_data, c("  Failed to load mangos data, run the script in mangos_translation", "red"))

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
        local lookup_data = type(lookup[locale]) == "function" and lookup[locale]() or
            lookup[locale]                                         -- Execute the function to get the table
        l10n[entityType:lower() .. "Lookup"][locale] = lookup_data -- Store the loaded table back

        -- print(rep(" ", 2) .. "Filtering " .. entityType .. " lookup for locale: " .. locale .. " to only include ids that we have data for")

        -- Sort Mangos IDs for deterministic processing and filter to valid IDs only
        local skippedIds = 0
        ---@type number[]
        local sorted_ids = {}
        ---@param entityId number
        for entityId in pairs(mangos_item) do
          if dbData:exists(entityType, entityId) then
            table.insert(sorted_ids, entityId)
          else
            skippedIds = skippedIds + 1
          end
        end
        -- print(rep(" ", 6) .. "Skipped " .. skippedIds .. " ids from " .. entityType .. " lookup for locale: " .. locale)
        table.sort(sorted_ids) -- Simple numeric sort for consistent processing order

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
        if merged_data > 0 then
          print(f("%sLocale [%s]: Added %d missing entries, Merged data into %d existing entries.", rep(" ", 4), locale, added_data, merged_data))
        else
          print(f("%sLocale [%s]: Added %d missing entries.", rep(" ", 4), locale, added_data))
        end
      end
    end
  end

  return true
end

---Loads localization data from Questie database files and merges with Mangos translations.
---This function orchestrates the complete l10n loading process: cleans files, loads lookup tables,
---injects Mangos translations, and generates the final translation data structure.
---@param questie_version string The Questie version directory name (e.g., "Classic", "TBC", "Wotlk")
---@param lowerQuestieDBVersion string The lowercase version prefix for database files
---@param Meta Meta The metadata structure containing l10n configuration
---@param dbData dbData The database data structure containing data and helper functions
---@return table<ItemId|NpcId|ObjectId|QuestId, table<L10nDBKeys, table<L10nLocales, any>>> l10nOverride Returns structured translation data indexed by entity ID
local function LoadL10nData(questie_version, lowerQuestieDBVersion, Meta, dbData)
  print(c("Loading L10n Data", "yellow"))
  -- Process L10n Data: Load raw DB, load static corrections, merge corrections into raw data.

  -- Clean and prepare localization files for each entity type
  print(" Loading version: " .. questie_version)
  for datatype in pairs(Meta.L10nMeta.l10nKeys) do
    local start = os.clock()
    local found_files = l10n_loader.CleanFiles(questie_version, datatype)

    if not found_files then
      print("  No files found for " .. datatype .. " in " .. questie_version)
      os.exit(0)
    end

    print(c(f(" Cleaned %d files in %.3fs seconds for %s\n", #found_files, os.clock() - start, datatype), "green"))
  end

  -- Load all lookup tables from the cleaned XML files
  print(c(" Loading all lookup files!", "yellow"))
  -- Create the lookup tables for the translations (This will import a singular ImportModule table)
  -- The "l10n" is not required here.
  ---@see AddonInitializeVersion
  local l10n = QuestieLoader:ImportModule()
  for _, entityType in ipairs(dbData.entityTypes) do
    local newLookup = entityType:lower() .. "Lookup"
    l10n[newLookup] = {}
    -- Load the XML file containing lookup functions for this entity type
    CLI_Helpers.loadXML(helpers.get_script_dir() ..
      f("/Questie-data/Localization/lookups/%s/lookup%ss/lookup%ss.clean.xml", questie_version, entityType, entityType))
  end

  -- Validate that all the lookups are loaded correctly
  for _, entityType in ipairs(dbData.entityTypes) do
    print(c(" Validating " .. entityType .. " lookup", "yellow"))
    local lookup = l10n[entityType:lower() .. "Lookup"]
    if not lookup then
      print(c("Failed to load " .. entityType .. " lookup", "red"))
      os.exit(0)
    end
    -- Validate that all required locales are loaded for this entity type
    for _, locale in ipairs(Meta.L10nMeta.locales) do
      -- if locale ~= "enUS" then
      print("    Validating " .. entityType .. " lookup for locale: " .. locale)
      if not lookup[locale] then
        print(c("  Failed to load " .. entityType .. " lookup for locale: " .. locale, "red"))
        os.exit(0)
      end

      -- Load the lookup data for this locale
      local lookup_data = lookup[locale]()                       -- Execute the function to get the table
      l10n[entityType:lower() .. "Lookup"][locale] = lookup_data -- Store the loaded table back
    end
  end

  -- Inject Mangos translations to fill gaps in Questie translation data
  local success = InjectMangosTranslations(lowerQuestieDBVersion, dbData, l10n)
  if not success then
    print(c("Failed to inject mangos translations", "red"))
    os.exit(0)
  end

  print(c("All lookups and locales loaded successfully\n", "green"))

  -- Generate the final l10n data structure from all loaded translation sources
  print(c("Creating l10n object data[id][entityType][locale]", "green"))
  return l10n_loader.GenerateL10nTranslation(Meta.L10nMeta.locales, dbData.entityTypes, l10n)
end

return {
  LoadL10nData = LoadL10nData,
}
