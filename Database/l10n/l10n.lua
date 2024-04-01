---@class LibQuestieDB
---@field l10n l10n
local LibQuestieDB = select(2, ...)

local f = string.format

---@class l10n:DatabaseType
local l10n = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.l10n, "l10n", {})
l10n.currentLocale = GetLocale()
-- Set this to nil to use the locale of the client
-- Override locale
l10n.currentLocale = "ptBR"

GLOBl10n = l10n

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

local indexToLocale = {
  [1] = "enUS",
  [2] = "ptBR",
  [3] = "ruRU",
  [4] = "deDE",
  [5] = "koKR",
  [6] = "esES",
  [7] = "frFR",
  [8] = "zhCN",
}
local localeToIndex = {}
local localeToPattern = {}
do
  for k, v in pairs(indexToLocale) do
    localeToIndex[v] = k
  end

  local function createPatternForLocale(locale)
    local patternString = "^"
    local repeatPattern = ".-"
    local capturePattern = "(.-)"
    for i = 1, localeToIndex[locale] do
      patternString = patternString .. (i == localeToIndex[locale] and capturePattern or repeatPattern) .. (i == #indexToLocale and "$" or specialChar)
    end
    return patternString
  end

  for i = 1, #indexToLocale do
    localeToPattern[indexToLocale[i]] = createPatternForLocale(indexToLocale[i])
  end
end

-- /dump GLOBl10n.item(25)
C_Timer.After(5, function()
  DevTools_Dump(localeToPattern)
  for locale in pairs(localeToPattern) do
    print(locale, localeToPattern[locale])
  end
end)



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
    public.ChangeLocale = function(locale)
      if localeToPattern[locale] then
        l10n.currentLocale = locale
        SetGetters()
      else
        error(f("Invalid locale: %s", locale))
      end
    end

    SetGetters()
  end

  exportFunctions()
end
