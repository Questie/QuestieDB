-- Sets up the environment for running tests
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

---@diagnostic disable: need-check-nil
require("cli.dump")
local argparse = require("argparse")

require("cli.Addon_Meta")

local f = string.format

do
  ---@diagnostic disable-next-line: lowercase-global
  function printableTable(table)
    local tablestring = "{ "
    for k, v in pairs(table) do
      if type(v) == "table" then
        tablestring = tablestring .. k .. " = " .. printableTable(v) .. ", "
      else
        tablestring = tablestring .. k .. " = " .. tostring(v) .. ", "
      end
    end
    tablestring = tablestring .. "}"
    return tablestring
  end
end



local function RunTest(version)
  local lowerVersion = version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the files and set wow version
  LibQuestieDBTable = AddonInitializeVersion(capitalizedVersion)

  -- Drain all the timers
  print("Pre-Drain timer list")
  C_Timer.drainTimerList()

  print("Executing event: ADDON_LOADED")
  LibQuestieDBTable.RegisteredEvents["ADDON_LOADED"](CLI_addonName or "QuestieDB")

  -- Drain all the timers
  print("ADDON_LOADED timer list")
  C_Timer.drainTimerList()

  if not LibQuestieDBTable.Database.Initialized then
    error("Database not initialized")
  end

  local Corrections = LibQuestieDBTable.Corrections
  local publicLibQuestieDB = LibQuestieDB()

  local t = LibQuestieDBTable.Translation
  -- print(type(t.GetTranslationFile))
  -- for k, v in pairs(t) do
  --   print(k, v)
  -- end
  -- local returnedFile = t.GetTranslationFile("Use the Apex's Crystal Focus near Archmage Vargoth's Orb")
  -- returnedFile = t.GetTranslationFile(
  --   "\nWhen selected, hides the quest from the map, even if it is active.\n\nHiding a quest is also possible by Shift-clicking it on the map.")
  -- print("Returned file: ", returnedFile)
  -- t.GetTemplateNames()
  -- for k, v in pairs(t.TemplateToPath) do
  --   print(k, v)
  -- end
  -- local foutput = t.LoadTranslationfile(returnedFile)
  -- for k, v in pairs(foutput) do
  --   print(k, v)
  -- end
  print(t.l10n("Use the Apex's Crystal Focus near Archmage Vargoth's Orb"))
  print(t.l10n("Use the Apex's Crystal Focus near Archmage Vargoth's Orb"))
  print(t.l10n("Use the Aspect of Neptulon."))
  print(t.l10n("\nWhen selected, hides the quest from the map, even if it is active.\n\nHiding a quest is also possible by Shift-clicking it on the map."))
  --
  os.exit(0)
  --- Function to print details of the database
  ---@param dataType string
  ---@param dataDB QuestFunctions|ItemFunctions|NpcFunctions|ObjectFunctions
  ---@param dataIds number[]
  ---@param functionOrder function[]
  local function printDetails(dataType, dataDB, dataIds, functionOrder)
    local functions_tested = 0
    local ids_tested = 0
    for _, dataId in pairs(dataIds) do
      local printText = {}
      table.insert(printText, string.format("----------------- %s %s", dataType, dataId))
      for i = 1, #functionOrder do
        local functionName = functionOrder[i]
        if dataDB[functionName] then
          local success, result = pcall(dataDB[functionName], dataId)
          if success then
            if type(result) == "table" then
              table.insert(printText, string.format("  %s: %s", functionName, printableTable(result)))
            else
              table.insert(printText, string.format("  %s: %s", functionName, tostring(result)))
            end
          else
            error(string.format("Function %s failed for id %d: %s", functionName, dataId, result))
          end
        else
          error(string.format("Function %s not found", functionName))
        end
        functions_tested = functions_tested + 1
      end
      ids_tested = ids_tested + 1
      -- print(table.concat(printText, "\n"))
    end
    print(f("  Tested %d functions for %d ids", functions_tested, ids_tested))
  end

  print("------------------ Public Item")
  do
    local AllItemIds = publicLibQuestieDB.Item.GetAllIds()
    table.sort(AllItemIds)

    local functionOrder = {}
    for functionName, index in pairs(Corrections.ItemMeta.itemKeys) do
      functionOrder[index] = functionName
    end

    printDetails("Item", publicLibQuestieDB.Item, AllItemIds, functionOrder)
  end

  print("------------------ Public Npc")
  do
    local AllNpcIds = publicLibQuestieDB.Npc.GetAllIds()
    table.sort(AllNpcIds)

    local functionOrder = {}
    for functionName, index in pairs(Corrections.NpcMeta.npcKeys) do
      functionOrder[index] = functionName
    end

    printDetails("Npc", publicLibQuestieDB.Npc, AllNpcIds, functionOrder)
  end

  print("------------------ Public Object")
  do
    local AllObjectIds = publicLibQuestieDB.Object.GetAllIds()
    table.sort(AllObjectIds)

    local functionOrder = {}
    for functionName, index in pairs(Corrections.ObjectMeta.objectKeys) do
      functionOrder[index] = functionName
    end

    printDetails("Object", publicLibQuestieDB.Object, AllObjectIds, functionOrder)
  end

  print("------------------ Public Quest")
  do
    local AllQuestIds = publicLibQuestieDB.Quest.GetAllIds()
    table.sort(AllQuestIds)

    local functionOrder = {}
    for functionName, index in pairs(Corrections.QuestMeta.questKeys) do
      functionOrder[index] = functionName
    end

    printDetails("Quest", publicLibQuestieDB.Quest, AllQuestIds, functionOrder)
  end

  print("------------------ Running all tests")
  LibQuestieDBTable.Item.RunGetTest(true)
  LibQuestieDBTable.Npc.RunGetTest(true)
  LibQuestieDBTable.Object.RunGetTest(true)
  LibQuestieDBTable.Quest.RunGetTest(true)
  for _, locale in ipairs(LibQuestieDBTable.Corrections.L10nMeta.locales) do
    LibQuestieDBTable.l10n.SetLocale(locale)
    print(f("Running l10n tests", locale))
    print(f(" Locale:  (%s)", locale))
    LibQuestieDBTable.l10n.RunGetTest(true)
  end
end
local validVersions = {
  ["era"] = true,
  ["sod"] = true,
  ["tbc"] = true,
  ["wotlk"] = true,
  ["cata"] = true,
}
local versionString = ""
for version in pairs(validVersions) do
  local v = string.gsub(version, "^%l", string.upper)
  versionString = versionString .. v .. "/"
end
-- Add all
versionString = versionString .. "All"

local parser = argparse("runTests", "runTests.lua Era")
parser:argument("version", f("Game version, %s.", versionString))

local args = parser:parse()

if args.version and validVersions[args.version:lower()] then
  RunTest(args.version)
elseif args.version and args.version:lower() == "all" then
  for version in pairs(validVersions) do
    RunTest(version)
  end
else
  print("No version specified")
end
