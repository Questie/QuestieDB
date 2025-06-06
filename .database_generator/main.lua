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
  package.path = full_project_dir .. sep .. "?.lua;" .. package.path
  package.path = full_script_dir .. sep .. "?.lua;" .. package.path

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
  -- for expansion, local_prefix in pairs(Expansions) do
  for _, exp_data in ipairs(helpers.Expansions) do
    local questie_prefix_expansion, local_prefix_expansion = unpack(exp_data)
    local capitalized_expansion = local_prefix_expansion:sub(1, 1):upper() .. local_prefix_expansion:sub(2)
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
CLI_Helpers.loadXML(helpers.get_project_dir_path() .. "/.database_generator/Questie-data/Localization/Translations/Translations.xml")


local single_translation = {}
for key, value in pairs(translations) do
  table.insert(single_translation, key)
end


---comment
---@param enUStext string
---@return table<string, string|boolean>?
---@return string? Error
local function getTranslation(enUStext)
  if translations[enUStext] then
    return translations[enUStext], nil
  else
    return nil, "Translation not found for: " .. enUStext
  end
end

-- Find the addon name
local addon_name = helpers.find_addon_name()
print("Addon Name: " .. addon_name)

---@type profile
local profile
if DB_GEN_DEBUG_MODE then
  profile = require("libs.profile")
  profile.start()
  print("Profiler started.")
end


-- local tbl = {
--   ASDF = (function()
--     return { ASDF = 1, }
--   end)(),
-- }
-- local testScope = {
--   _G = _G,
--   data = nil,
-- }
-- function test(loadstring)
--   print("Creating scope")
--   -- setfenv(1, testScope)
--   local code_to_run = "data = 1"
--   local chunk = loadstring(code_to_run)
--   if chunk then
--     setfenv(chunk, testScope) -- Set the environment of the CHUNK to testScope
--     print(chunk())            -- Execute the chunk (it will modify testScope.data). This line also prints the chunk's return value (nil for an assignment).
--   else
--     print("Error compiling string: " .. code_to_run)
--   end
--   print("Data:", testScope.data)
--   print("Done")
--   -- for k, v in pairs(tbl) do
--   for k, v in pairs(tbl) do
--     print(k, v)
--   end
-- end

-- test(loadstring)

-- local function profile_direct_loadstring(itt)
--   local start_time = os.clock()
--   for i = 1, itt do
--     -- local data = loadstring("return " ..
--     --   "{[40]={{47.11,67.64},{35.81,45.9},{34.46,46.05},{32.51,36.36},{48.98,33.82},{32.92,37.29},{56.84,35.72},{36.13,46.93},{47.88,33.47},{46.54,69.08},{50.32,33.96},{34.33,47.79},{35.35,47.2},{33.42,36.19},{48.74,32.34},{47.46,66.53},{46.7,65.92},{46.87,67.03},{56.85,34.26},{33.56,46.66},{32.93,35.52},{57.29,35.37},{57.16,33.97},{56.52,35.1},{56.34,35.94},{56.97,36.27},{49.67,32.97},{48.67,32.19}}}")()
--     local data = loadstring("return " .. "hej")()
--     -- To prevent the JIT from optimizing 'data' away, we can do a trivial check
--     if data == 'hello' then
--       print("Error in direct loadstring!") -- Should not happen
--     end
--   end
--   local end_time = os.clock()
--   print("Time for direct loadstring with return (" .. tostring(itt) .. " iterations):", string.format("%.4f", end_time - start_time), "seconds")
-- end

-- local function profile_tbl_loadstring(itt)
--   local start_time = os.clock()
--   local t = {
--     "return ",
--     nil,
--   }
--   for i = 1, itt do
--     -- local data = loadstring("return " ..
--     --   "{[40]={{47.11,67.64},{35.81,45.9},{34.46,46.05},{32.51,36.36},{48.98,33.82},{32.92,37.29},{56.84,35.72},{36.13,46.93},{47.88,33.47},{46.54,69.08},{50.32,33.96},{34.33,47.79},{35.35,47.2},{33.42,36.19},{48.74,32.34},{47.46,66.53},{46.7,65.92},{46.87,67.03},{56.85,34.26},{33.56,46.66},{32.93,35.52},{57.29,35.37},{57.16,33.97},{56.52,35.1},{56.34,35.94},{56.97,36.27},{49.67,32.97},{48.67,32.19}}}")()
--     t[2] = "hej"
--     local data = loadstring(table.concat(t))()
--     -- To prevent the JIT from optimizing 'data' away, we can do a trivial check
--     if data == 'hello' then
--       print("Error in direct loadstring!") -- Should not happen
--     end
--   end
--   local end_time = os.clock()
--   print("Time for direct loadstring with table (" .. tostring(itt) .. " iterations):", string.format("%.4f", end_time - start_time), "seconds")
-- end


-- local function profile_pcallwithenv_loadstring(itt)
--   local testScope = {
--     -- _G = _G, -- Provide access to globals if needed by the loaded string
--     data = nil,
--   }

--   local start_time = os.clock()
--   for i = 1, itt do
--     -- local code_to_run =
--     -- "data={[40]={{47.11,67.64},{35.81,45.9},{34.46,46.05},{32.51,36.36},{48.98,33.82},{32.92,37.29},{56.84,35.72},{36.13,46.93},{47.88,33.47},{46.54,69.08},{50.32,33.96},{34.33,47.79},{35.35,47.2},{33.42,36.19},{48.74,32.34},{47.46,66.53},{46.7,65.92},{46.87,67.03},{56.85,34.26},{33.56,46.66},{32.93,35.52},{57.29,35.37},{57.16,33.97},{56.52,35.1},{56.34,35.94},{56.97,36.27},{49.67,32.97},{48.67,32.19}}}"
--     local code_to_run = "data='hej'"
--     local chunk = loadstring(code_to_run)
--     -- if chunk then
--     pcallwithenv(chunk, testScope)
--     -- To prevent the JIT from optimizing 'testScope.data' away
--     if testScope.data == 'hello_pcallwithenv' then
--       print("Error in pcallwithenv loadstring!") -- Should not happen
--     end
--     -- else
--     --   print("Error compiling string: " .. code_to_run)
--     -- end
--   end
--   local end_time = os.clock()
--   print("Time for loadstring with pcallwithenv (" .. tostring(itt) .. " iterations):", string.format("%.4f", end_time - start_time), "seconds")
-- end

-- local function profile_setfenv_loadstring(itt)
--   local testScope = {
--     -- _G = _G, -- Provide access to globals if needed by the loaded string
--     data = nil,
--   }

--   local start_time = os.clock()
--   for i = 1, itt do
--     -- local code_to_run =
--     -- "data={[40]={{47.11,67.64},{35.81,45.9},{34.46,46.05},{32.51,36.36},{48.98,33.82},{32.92,37.29},{56.84,35.72},{36.13,46.93},{47.88,33.47},{46.54,69.08},{50.32,33.96},{34.33,47.79},{35.35,47.2},{33.42,36.19},{48.74,32.34},{47.46,66.53},{46.7,65.92},{46.87,67.03},{56.85,34.26},{33.56,46.66},{32.93,35.52},{57.29,35.37},{57.16,33.97},{56.52,35.1},{56.34,35.94},{56.97,36.27},{49.67,32.97},{48.67,32.19}}}"
--     local code_to_run = "data='hej'"
--     local chunk = loadstring(code_to_run)
--     -- if chunk then
--     setfenv(chunk, testScope)
--     chunk()
--     -- To prevent the JIT from optimizing 'testScope.data' away
--     if testScope.data == 'hello_setfenv' then
--       print("Error in setfenv loadstring!") -- Should not happen
--     end
--     -- else
--     --   print("Error compiling string: " .. code_to_run)
--     -- end
--   end
--   local end_time = os.clock()
--   print("Time for loadstring with setfenv (" .. tostring(itt) .. " iterations):", string.format("%.4f", end_time - start_time), "seconds")
-- end

-- local function profile_newproxy_loadstring(itt)
--   local captured_data_store = {} -- To hold data set via proxy

--   local data_handler_proxy = newproxy(true)
--   local metatable = getmetatable(data_handler_proxy)

--   metatable.__newindex = function(proxy_instance, key, value)
--     captured_data_store[key] = value
--   end

--   -- The environment for the loaded string needs access to the proxy
--   local execution_environment = {
--     proxy_target = data_handler_proxy,
--     -- _G = _G -- Provide access to globals if needed
--   }

--   local start_time = os.clock()
--   for i = 1, itt do
--     -- The code assigns to a field of 'proxy_target'
--     -- local code_to_run =
--     -- "proxy_target.data_field={[40]={{47.11,67.64},{35.81,45.9},{34.46,46.05},{32.51,36.36},{48.98,33.82},{32.92,37.29},{56.84,35.72},{36.13,46.93},{47.88,33.47},{46.54,69.08},{50.32,33.96},{34.33,47.79},{35.35,47.2},{33.42,36.19},{48.74,32.34},{47.46,66.53},{46.7,65.92},{46.87,67.03},{56.85,34.26},{33.56,46.66},{32.93,35.52},{57.29,35.37},{57.16,33.97},{56.52,35.1},{56.34,35.94},{56.97,36.27},{49.67,32.97},{48.67,32.19}}}"
--     local code_to_run = "proxy_target.data_field='hej'"
--     local chunk = loadstring(code_to_run)
--     -- if chunk then
--     setfenv(chunk, execution_environment)
--     chunk()
--     -- To prevent the JIT from optimizing 'captured_data_store.data_field' away
--     if captured_data_store.data_field == 'hello_newproxy' then
--       print("Error in newproxy loadstring!") -- Should not happen
--     end
--     -- Reset for next iteration if necessary, or ensure keys are unique if accumulating
--     captured_data_store.data_field = nil
--     -- else
--     --   print("Error compiling string for newproxy: " .. code_to_run)
--     -- end
--   end
--   local end_time = os.clock()
--   print("Time for loadstring with newproxy (" .. tostring(itt) .. " iterations):", string.format("%.4f", end_time - start_time), "seconds")
-- end


-- print("Starting profiling...")
-- local tries = 100000
-- profile_direct_loadstring(tries)
-- profile_tbl_loadstring(tries)
-- profile_setfenv_loadstring(tries)
-- profile_pcallwithenv_loadstring(tries)
-- profile_newproxy_loadstring(tries)
-- print("Profiling finished.")

-- ---@class AllianceRaceKeys
-- local allianceRaceKeys = {
--   HUMAN = 1,
--   DWARF = 4,
--   NIGHT_ELF = 8,
--   GNOME = 64,
--   DRAENEI = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 1024 or nil,
--   WORGEN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 2097152 or nil,
-- }

-- ---@class HordeRaceKeys
-- local hordeRaceKeys = {
--   ORC = 2,
--   UNDEAD = 16,
--   TAUREN = 32,
--   TROLL = 128,
--   GOBLIN = WOW_PROJECT_ID >= WOW_PROJECT_CATACLYSM_CLASSIC and 256 or nil,
--   BLOOD_ELF = WOW_PROJECT_ID >= WOW_PROJECT_BURNING_CRUSADE_CLASSIC and 512 or nil,
-- }

-- ---@class RaceKeys:AllianceRaceKeys,HordeRaceKeys
-- ---@field ALL_ALLIANCE number A combination of all alliance raceKeys
-- ---@field ALL_HORDE number A combination of all horde raceKeys
-- local raceKeys = {
--   NONE = 0,

--   -- HUMAN = 1,
--   -- ORC = 2,
--   -- DWARF = 4,
--   -- NIGHT_ELF = 8,
--   -- UNDEAD = 16,
--   -- TAUREN = 32,
--   -- GNOME = 64,
--   -- TROLL = 128,
--   -- GOBLIN = 256,
--   -- BLOOD_ELF = 512,
--   -- DRAENEI = 1024,
--   -- WORGEN = 2097152, -- lol
-- }
-- raceKeys.ALL_ALLIANCE = (function()
--   local alliance = 0
--   for race, v in pairs(allianceRaceKeys) do
--     alliance = alliance + v
--     raceKeys[race] = v
--   end
--   return alliance
-- end)()
-- raceKeys.ALL_HORDE = (function()
--   local horde = 0
--   for race, v in pairs(hordeRaceKeys) do
--     horde = horde + v
--     raceKeys[race] = v
--   end
--   return horde
-- end)()

-- for key, value in pairs(raceKeys) do
--   if type(value) == "number" then
--     print(key, ":", value)
--   else
--     print("Error: " .. key .. " is not a number.")
--   end
-- end
-- os.exit(0)

-- Generate Trie-translations
require("generateTranslations")
Compile_translations_to_html(single_translation, addon_name, getTranslation)

-- Run the main function
main()

if profile then
  profile.stop()
  print("Profiler stopped.")
  -- Print the profiling results
  print(profile.report(100))
end
