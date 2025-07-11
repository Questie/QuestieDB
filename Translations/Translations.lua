---@class LibQuestieDB
---@field ExtraTranslation ExtraTranslation
local LibQuestieDB     = select(2, ...)

--*---- Create Module --------

---@class ExtraTranslation
local ExtraTranslation = LibQuestieDB.ExtraTranslation

local pTranslation     = {}

---- Local Functions ----
--* For performance reasons we check Is_CLI here, Translation.CreateFrame supports both CLI and WOW
local CreateFrame      = Is_CLI and ExtraTranslation.CreateFrame or CreateFrame
local gsub             = string.gsub
local sub              = string.sub
local type             = type
local f                = string.format

local allLowerCase     = true

local function extractLocaleText(text, locale)
  -- Pattern to select everything between [] prefixed with the locale
  -- E.g. deDE[Benutze den Aspekt von Neptulon.]
  -- deDE%[([^‡]*)%]
  local pattern = locale .. "%[([^‡]*)%]"
  local result = text:match(pattern)
  if result then
    return result
  else
    -- If the locale is not found, nil
    return nil
  end
end

local translationsData = {}

---Get translation for a given string if it exists, otherwise return the string itself.
---@param text string -- The text to be translated, will return the current locale.
---@param locale localeType? -- Mostly a helper for testing
---@return nil
function ExtraTranslation.GetTranslation(text, locale)
  -- If the text is nil or empty, return nil
  if not text then
    return nil
  end
  -- If the locale is enUS, return text
  if LibQuestieDB.l10n.currentLocale == "enUS" and not locale then
    return text
  end
  -- If the locale is not set, use the current locale
  if not locale then
    locale = LibQuestieDB.l10n.currentLocale
  end

  -- Do we have the translation already?
  local translations = translationsData[text]
  if not translations then
    -- If not, load the translation file
    local returnedFile = pTranslation.GetTranslationFile(text)
    pTranslation.LoadTranslationfile(returnedFile)

    -- Get the translation again
    translations = translationsData[text]
  end

  -- If we have the translation, extract the locale text,
  return translations and (extractLocaleText(translations, locale) or text) or text
end

do
  ---@type table<string, boolean>
  local translationFileCache = {}
  function pTranslation.LoadTranslationfile(FrameName)
    if translationFileCache[FrameName] then
      return
    end

    -- Create a new UI Frame to load data from
    local translationsFrame = CreateFrame("SimpleHTML", nil, nil, FrameName)
    translationsFrame:Hide()

    -- Get all the filenames from the frame, they are split into different <p> tags that we have to combine
    ---@type FontString[]
    local translationRegions = { translationsFrame:GetRegions() --[[@as FontString]], }
    for i = 1, #translationRegions, 2 do
      -- Data comes in pairs of 2, first is enUS text
      -- Second is translations-string
      local englishString = translationRegions[i]:GetText()
      local combinedString = translationRegions[i + 1]:GetText()
      -- print(f("English: %s", englishString))
      -- print(f("Combined: %s", combinedString))
      -- rawset(translationLookups, englishString, combinedString)
      translationsData[englishString] = combinedString
    end
    -- fileCache[FrameName] = strsplittable(",", combinedString)
    -- return fileCache[FrameName]
    -- return strsplittable(",", "combinedString")
    translationFileCache[FrameName] = true
  end
end

--- Returns the HTML file name for a given translation key.
--- It converts the key to lowercase and walks the LibQuestieDB.translationsLookup table
--- character by character. The function returns the string value as soon as it's encountered.
---@param key string The key to look up (e.g., "the", "THEA").
---@return string? The HTML file name (e.g., "the.html", "thea.html") or nil if not found,
---               or if the key leads to a deeper structure instead of a string at that point.
function pTranslation.GetTranslationFile(key)
  if not key or key == "" then
    return nil
  end

  -- You can find LibQuestieDB.translationsLookup in the Translations\TranslationsLookup.lua - file
  -- If you don't have it you have to run the database generator script.
  local current = LibQuestieDB.translationsLookup
  -- Remove all whitespaces from the string
  local cleanedKey = gsub(allLowerCase and key:lower() or key, "%s", "")
  -- Remove all numbers from the string (Not in use as some strings are very short and contains numbers)
  -- cleanedKey = gsub(cleanedKey, "%d+", "")
  -- Remove all punctuation from the string
  cleanedKey = gsub(cleanedKey, "%p", "")
  -- Remove all control characters from the string
  cleanedKey = gsub(cleanedKey, "%c", "")

  for i = 1, #cleanedKey do
    local char = sub(cleanedKey, i, i)

    if type(current) == "table" then
      if current[char] then
        ---@diagnostic disable-next-line: cast-local-type
        current = current[char] -- Advance to the next part of the lookup or the final value

        -- If the new 'current' value is a string, we've found our target
        if type(current) == "string" then
          return current
        end
        -- If 'current' is now a table, the loop continues with the next character.
        -- If 'current' became something else (e.g. nil, number - not expected for this structure),
        -- the next iteration's `type(current) == "table"` check will handle it.
      else
        -- The current character does not exist as a key in the current table level
        return nil
      end
    else
      -- `current` is not a table (e.g., it's a string, number, boolean, nil),
      -- but we still have characters left in `lowerKey` (since we are in the loop).
      -- This implies the path ended prematurely with a non-table value before all
      -- characters of the key were processed. If it was a string, it should have been
      -- returned in the previous step.
      return nil
    end
  end

  -- If the loop completes, it means all characters in `lowerKey` were processed.
  -- A string value should have been returned from *within* the loop if one was encountered.
  -- If we reach here, it means the full key led to a `current` that is still a table
  -- (e.g., key "th" where `LibQuestieDB.translationsLookup.t.h` is a table).
  if type(current) == "table" then
    return nil -- The key maps to a deeper structure, not a string itself.
  end

  -- If current is a string here, it should have been returned by the last iteration of the loop.
  -- This is a fallback.
  return nil
end

--? This function is used to export all the functions to the Public and Private namespaces
--? It gets called at the end of this file
local function exportFunctions()
  -- local publicL10n = {}

  -- publicL10n.l10n = translationLookups

  assert(not LibQuestieDB.PublicLibQuestieDB.l10n, "LibQuestieDB.PublicLibQuestieDB.l10n is not nil")
  LibQuestieDB.PublicLibQuestieDB.l10n = ExtraTranslation.GetTranslation
end

exportFunctions()
