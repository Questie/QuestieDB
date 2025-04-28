-- main.lua
-- Prepend your script's directory to the package.path
local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

local helpers = require(".db_helpers")
require("cli.CLI_Helpers")

require(".createStatic")

DB_GEN_DEBUG_MODE = false


-- Main function to demonstrate the usage of helper functions
local function main()
  print("Running database download script...")
  require("dl_database")
  print("Database download script finished.")


  -- for expansion, local_prefix in pairs(Expansions) do
  for questie_prefix_expansion, local_prefix_expansion in pairs(helpers.Expansions) do
    local capitalized_expansion = local_prefix_expansion:sub(1, 1):upper() .. local_prefix_expansion:sub(2)
    print("Downloading " .. capitalized_expansion .. " databases...")
    DumpDatabase(capitalized_expansion, questie_prefix_expansion, DB_GEN_DEBUG_MODE)
  end
end


require("cli.Addon_Meta")

-- ? This code makes it so that all ImportModule("l10n") gets redirected to the same table.
local translations = {}
QuestieLoader = {
  ImportModule = function()
    return { translations = translations, }
  end,
}

-- ? Load all the tables.
CLI_Helpers.loadXML(helpers.get_project_dir_path() .. "/.database_generator/Questie-translations/Localization/Translations/Translations.xml")


local single_translation = {}
for key, value in pairs(translations) do
  -- local translation = string.gsub(key, "\n", "<br>")
  -- translation = string.gsub(translation, '"', '\\"')
  table.insert(single_translation, key)
end


---comment
---@param enUStext string
---@return table<string, string|boolean>?
---@return error?
local function getTranslation(enUStext)
  if translations[enUStext] then
    return translations[enUStext], nil
  else
    return nil, "Translation not found for: " .. enUStext
  end
end


require("generateTranslations")
-- Find the addon name
local addon_name = helpers.find_addon_name()
print("Addon Name: " .. addon_name)

-- Generate Trie-translations
Compile_translations_to_html(single_translation, addon_name, getTranslation)

-- Run the main function
main()
