-- main.lua
-- Prepend your script's directory to the package.path
do
  local lfs = require("lfs")

  -- Get the path separator
  local sep = package.config:sub(1, 1)

  -- If we are executing from any other location than the script dir
  local relative_script_path = debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]")
  if relative_script_path then
    print("SETUP: Relative script path:", debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]"))

    -- First we change into the script directory
    lfs.chdir(debug.getinfo(1, "S").source:sub(2):match("(.*)[/\\]"))
  end

  -- Then we get the full path to the script directory
  local full_script_dir = lfs.currentdir()
  print("SETUP: Changed directory to absolute script directory : ", full_script_dir)

  -- Then we get the full path to the project directory
  local full_project_dir = full_script_dir:match("(.*)[/\\]") -- Remove last slash

  -- Then we set the package.path to include the script and project directories
  package.path = full_project_dir .. sep .. "?.lua;" .. full_script_dir .. sep .. "?.lua;" .. package.path

  -- Then we change back to the project directory
  lfs.chdir(full_project_dir)
  print("SETUP: Changed directory to absolute project directory: ", lfs.currentdir())
  if lfs.attributes("Library.lua", "mode") == "file" then
    print("SETUP: Library.lua found in project directory.")
  else
    print("SETUP: ERROR - Library.lua not found in project directory.")
    error("SETUP: ERROR - Library.lua not found in project directory.")
    os.exit(1)
  end
end

local helpers = require(".db_helpers")
require("cli.CLI_Helpers")

require(".createStatic")

DB_GEN_DEBUG_MODE = false


-- Main function to demonstrate the usage of helper functions
local function main()
  print("Running database download script...")
  require(".dl_database")
  print("Database download script finished.")


  -- for expansion, local_prefix in pairs(Expansions) do
  for _, exp_data in ipairs(helpers.Expansions) do
    local questie_prefix_expansion, local_prefix_expansion = unpack(exp_data)
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

local profile = require("profile")
-- Find the addon name
local addon_name = helpers.find_addon_name()
print("Addon Name: " .. addon_name)

profile.start()


-- Generate Trie-translations
require("generateTranslations")
Compile_translations_to_html(single_translation, addon_name, getTranslation)

-- Run the main function
main()

profile.stop()
print("Profiler stopped.")
-- Print the profiling results
print(profile.report(100))
