---@class LibQuestieDB
---@field l10n l10n
local LibQuestieDB = select(2, ...)

local L10nMeta = LibQuestieDB.Corrections.L10nMeta

local f = string.format

---@class l10n:DatabaseType
local l10n = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.l10n, "l10n", {})
l10n.currentLocale = GetLocale()
-- Set this to nil to use the locale of the ingame client
-- Override locale
-- l10n.currentLocale = "ptBR"
-- If you are in the CLI environment change:
---@see CLI_Locale which exists in cli/Addon_Meta.lua

-- Order Item, Npc, Object, Quest
-- "enUS": "", # English (US) # Yes EN is empty
-- "ptBR": "pt", # Portuguese (Brazil)
-- "ruRU": "ru", # Russian (Russia)
-- "deDE": "de", # German (Germany)
-- "koKR": "ko", # Korean (Korea)
-- "esES": "es", # Spanish (Spain)
-- "frFR": "fr", # French (France)
-- "zhCN": "cn",
-- The very special character https://www.compart.com/en/unicode/U+2016
-- Double Dagger
-- "‡"
-- Example:
-- 'Worn Shortsword‡Espadim Usado‡Иссеченный короткий меч‡Abgenutztes Kurzschwert‡낡은 쇼트소드‡Espada corta desgastada‡Vieille épée courte‡破损的短剑'

local specialChar = "‡"

-- ! The order of these are very important and has to match the order in the
-- ! extracting script in .database_generator/generate_l10n_table.lua
local indexToLocale = L10nMeta.locales

local localeToIndex = {}
local localeToPattern = {}
do
  -- Populate the localeToIndex table with locale as key and its index as value
  -- This helps in quickly finding the index of a given locale
  for k, v in pairs(indexToLocale) do
    localeToIndex[v] = k
  end

  -- Function to create a pattern string for a given locale
  -- This pattern is used to extract the localized string from a concatenated string of all locales
  local function createPatternForLocale(locale)
    local patternString = "^"     -- Start of the string
    local repeatPattern = ".-"    -- Non-greedy match for any character sequence
    local capturePattern = "(.-)" -- Non-greedy match for any character sequence, to be captured
    for i = 1, localeToIndex[locale] do
      -- Append the appropriate pattern based on the current index
      patternString = patternString .. (i == localeToIndex[locale] and capturePattern or repeatPattern)
      patternString = patternString .. (i == #indexToLocale and "$" or specialChar)
    end
    return patternString
  end

  -- Populate the localeToPattern table with locale as key and its pattern as value
  -- This pattern is used to extract the localized string for the given locale
  for i = 1, #indexToLocale do
    localeToPattern[indexToLocale[i]] = createPatternForLocale(indexToLocale[i])
  end
end

local function SetGetters()
  -- ? Item
  do
    l10n.item = l10n.AddPatternGetter(1, "item", localeToPattern[l10n.currentLocale])

    -- Returns item name i.e "Worn Shortsword"
    l10n.itemName = l10n.item
  end

  -- ? Npc
  do
    local npcCache = {}
    -- Gets the raw data for the npc
    local npc = l10n.AddTableGetter(2, "npc")
    l10n.npc = function(id)
      if npcCache[id] then
        return npcCache[id]
      end

      local data = npc(id)
      if data then
        --- This code gets the locale data for a single locale
        --- The data objects contain all the locales in a single strings
        --- Duplicated for performance reasons
        local result = {}
        for i = 1, #data do
          if data[i] then
            local match = data[i]:match(localeToPattern[l10n.currentLocale])
            result[i] = match ~= "" and match or nil
          else
            result[i] = nil
          end
        end
        npcCache[id] = result
        return result
      end
      return nil
    end
    -- Returns npc name i.e "Bran Bronzebeard"
    l10n.npcName = function(id)
      local npcData = npcCache[id] and npcCache[id] or l10n.npc(id)
      return npcData and npcData[1] or nil
    end
    -- Returns npc subname i.e "Weapon Vendor"
    l10n.npcSubName = function(id)
      local npcData = npcCache[id] and npcCache[id] or l10n.npc(id)
      return npcData and npcData[2] or nil
    end
  end

  -- ? Object
  do
    l10n.object = l10n.AddPatternGetter(3, "object", localeToPattern[l10n.currentLocale])
    -- Returns object name i.e "Worn Chest"
    l10n.objectName = l10n.object
  end

  -- ? Quest
  do
    local questCache = {}
    -- Gets the raw data for the quest
    local quest = l10n.AddTableGetter(4, "quest")
    l10n.quest = function(id)
      if questCache[id] then
        return questCache[id]
      end

      local data = quest(id)
      if data then
        --- This code gets the locale data for a single locale
        --- The data objects contain all the locales in a single strings
        --- Duplicated for performance reasons
        local result = {}
        for i = 1, #data do
          if data[i] then
            local match = data[i]:match(localeToPattern[l10n.currentLocale])
            result[i] = match ~= "" and match or nil
          else
            result[i] = nil
          end
        end
        questCache[id] = result
        return result
      end
      return nil
    end

    ---@param id QuestId
    ---@return string?
    l10n.questName = function(id)
      local questData = questCache[id] and questCache[id] or l10n.quest(id)
      return questData and questData[1] or nil
    end

    -- TODO: This data is available but not used
    ---@param id QuestId
    ---@return string[]?
    l10n.questDescription = function(id)
      local questData = questCache[id] and questCache[id] or l10n.quest(id)
      -- ? These return as tables
      return questData and { questData[2], } or nil
    end

    ---@param id QuestId
    ---@return string[]?
    l10n.questObjectivesText = function(id)
      local questData = questCache[id] and questCache[id] or l10n.quest(id)
      -- ? These return as tables
      return questData and { questData[3], } or nil
    end
  end
end

do
  -- ? This function is used to export all the functions to the Public and Private namespaces
  -- ? It gets called at the end of this file
  local function exportFunctions()
    local public = LibQuestieDB.PublicLibQuestieDB

    ---Change the locale of the l10n module.
    ---@param locale localeType Set locale getters to locale
    function l10n.SetLocale(locale)
      if localeToPattern[locale] then
        l10n.currentLocale = locale
        SetGetters()
      else
        -- error(f("Invalid locale: %s", locale))
        print(f("Invalid locale: %s", locale))
      end
    end

    public.SetLocale = l10n.SetLocale

    -- Do not SetGetters if the locale does not exist
    if localeToPattern[l10n.currentLocale] then
      SetGetters()
    end
  end

  exportFunctions()
end
