-- dl_database.lua
-- This script downloads the database files from the Questie GitHub repository.

-- Prepend your script's directory to the package.path
---@type string
local script_path = debug.getinfo(1, "S").source:sub(2)
---@type string
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

---@type helpers
local helpers = require(".db_helpers")

---@type string
local base_url = "https://raw.githubusercontent.com/Questie/Questie/master/Database/"
-- Use helper to get project path and define output relative to it
---@type string
local output_base_dir = helpers.get_project_dir_path() .. "/.database_generator/_data"

-- Ensure the output directory exists using the helper function
helpers.ensureDirExists(output_base_dir)
print("Ensured directory exists: " .. output_base_dir)

---@type string[]
local entity_types = { "Item", "Npc", "Object", "Quest", }

--- Downloads a database file from GitHub and saves it locally.
---@param github_expansion string @ The expansion name used in the GitHub URL path (e.g., "Classic", "TBC").
---@param local_prefix string @ The prefix used for the local filename (e.g., "era", "tbc").
---@param entity_type string @ The type of entity (e.g., "Item", "Npc").
local function download_and_save(github_expansion, local_prefix, entity_type)
  -- Determine the correct filename prefix for the GitHub URL by lowercasing the expansion name.
  ---@type string
  local github_filename_prefix = github_expansion:lower()

  ---@type string
  local github_filename = github_filename_prefix .. entity_type .. "DB.lua"
  ---@type string
  local url = base_url .. github_expansion .. "/" .. github_filename
  ---@type string
  local output_file = output_base_dir .. "/" .. local_prefix .. entity_type .. "DB.lua" -- Local filename uses the local_prefix

  print("Downloading " .. url .. " to " .. output_file)
  ---@type string?
  local data = helpers.download_text_file(url)

  if data then
    local file, err = io.open(output_file, "w")
    if not file then
      print("Error opening file for writing: " .. output_file .. " - " .. err)
    else
      file:write(data)
      file:close()
      print("Successfully saved: " .. output_file)
    end
  else
    print("Failed to download: " .. url)
  end
end

print("Starting database file downloads...")

for _, exp_data in ipairs(helpers.Expansions) do
  local github_expansion, local_prefix = unpack(exp_data)
  print("\nProcessing expansion: " .. github_expansion)
  for _, entity_type in ipairs(entity_types) do
    download_and_save(github_expansion, local_prefix, entity_type)
  end
end

print("\nDatabase file downloads finished.")
