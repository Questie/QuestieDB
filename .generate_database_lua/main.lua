-- main.lua
-- Prepend your script's directory to the package.path
local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

local helpers = require("helpers")
require("cli.CLI_Helpers")

-- Main function to demonstrate the usage of helper functions
local function main()
  -- Get the project directory path
  local project_dir = helpers.get_project_dir_path()
  print("Project Directory Path: " .. project_dir)

  -- Get the data directory path for a specific entity type and expansion
  local entity_type = "Quest"
  local expansion = "Wotlk"
  local data_dir = helpers.get_data_dir_path(entity_type, expansion)
  print("Data Directory Path for " .. entity_type .. " in " .. expansion .. ": " .. data_dir)

  -- Find the addon name
  local addon_name = helpers.find_addon_name()
  print("Addon Name: " .. addon_name)

  -- Read expansion data
  local expansion_data = helpers.read_expansion_data(expansion, entity_type)
  if expansion_data then
    local lines = 4
    local count = 0
    for line in expansion_data:gmatch("  [^\n]+") do
      print(line)
      count = count + 1
      if count >= lines then
        break
      end
    end
  else
    print("No data found for " .. entity_type .. " in " .. expansion)
  end

  -- Download a file from a URL
  local url = "https://raw.githubusercontent.com/Questie/Questie/master/Database/Classic/classicItemDB.lua"
  local data = helpers.download_text_file(url)
  if data then
    print("Downloaded data from URL: ")
    local lines = 4
    local count = 0
    for line in data:gmatch("  [^\n]+") do
      print(line)
      count = count + 1
      if count >= lines then
        break
      end
    end
  else
    print("Failed to download data from URL: " .. url)
  end

  -- Write data to a file
  -- Write data to a file
  local output_dir = ".generate_database/_data"
  local output_file = output_dir .. "/eraItemDB.lua"

  -- Write the data to the file
  local file, err = io.open(output_file, "w")
  if not file then
    print("Error opening file for writing: " .. err)
  else
    file:write(data)
    file:close()
    print("Data written to file: " .. output_file)
  end
end


require("cli.Addon_Meta")
local translations = {}
QuestieLoader = {
  ImportModule = function()
    return { translations = translations, }
  end,
}

CLI_Helpers.loadTOC(".generate_database_lua/translations.toc")


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


require("generate_translation_trie_root")
-- Find the addon name
local addon_name = helpers.find_addon_name()
print("Addon Name: " .. addon_name)
Compile_translations_to_html(single_translation, addon_name, getTranslation)

-- Run the main function
-- main()
