---@diagnostic disable: need-check-nil
require("cli.dump")
local argparse = require("argparse")
local lfs = require('lfs')

Is_CLI = true
-- Blizzard functions
do
  local startTime = os.clock()
  function debugprofilestart()
    startTime = os.clock()
  end

  function debugprofilestop()
    return (os.clock() - startTime) * 1000
  end

  ---@param delimiter string
  ---@param str string
  ---@param pieces? number
  ---@return string[] chunks
  function strsplittable(delimiter, str, pieces)
    local t = {}
    local i = 1
    for s in string.gmatch(str, "([^" .. delimiter .. "]+)") do
      t[i] = s
      i = i + 1
      if pieces and i > pieces then
        break
      end
    end
    return t
  end

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

local excludedDirectories = {
  [".git"] = true,
  [".translator"] = true,
  [".wowhead"] = true,
  [".generate_database"] = true,
}
function FindFile(searchName)
  local function search(path)
    for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
        local f = path .. '/' .. file
        local attr = lfs.attributes(f)
        if attr.mode == 'directory' then
          if excludedDirectories[file] then
            -- print("Skipping directory: " .. f)
          else
            -- print("Searching directory: " .. f)
            local result = search(f)
            if result then return result end
          end
        else
          if file == searchName then
            print("FindFile: Found file: " .. f)
            return f
          end
        end
      end
    end
  end
  return search(lfs.currentdir())
end

-- Used to print extra information and the like when generating the database
local cli_debug = false

---@type LibQuestieDB
LibQuestieDBTable = {}

local QuestieDB = {}
QuestieLoader = {
  ImportModule = function()
    return QuestieDB
  end,
}

WOW_PROJECT_ID = 2
WOW_PROJECT_CLASSIC = 2
WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
WOW_PROJECT_WRATH_CLASSIC = 11
WOW_PROJECT_MAINLINE = 1

QUEST_MONSTERS_KILLED = "QUEST_MONSTERS_KILLED"
QUEST_ITEMS_NEEDED = "QUEST_ITEMS_NEEDED"
QUEST_OBJECTS_FOUND = "QUEST_OBJECTS_FOUND"
ERR_QUEST_ACCEPTED_S = "ERR_QUEST_ACCEPTED_S"
ERR_QUEST_COMPLETE_S = "ERR_QUEST_COMPLETE_S"

local assert = assert
local type = type
local f = string.format

local _EmptyDummyFunction = function() end
local _TableDummyFunction = function() return {} end

SlashCmdList = {}

coroutine.yield = _EmptyDummyFunction -- no need to yield in the cli (TODO: maybe find a less hacky fix)
mod = function(a, b)
  return a % b
end
bit = require("bit32")
hooksecurefunc = _EmptyDummyFunction
GetAddOnInfo = function()
  return "QuestieDB", "QuestieDB", "desc", true, "INSECURE", false
end
GetAddOnMetadata = function()
  return "1"
end
GetTime = function()
  return os.time(os.date("!*t")) - 1616930000 -- convert unix time to wow time (actually accurate)
end
IsAddOnLoaded = function() return false, true end
UnitFactionGroup = function()
  return arg[1] or "Horde"
end
UnitClass = function()
  return "Druid", "DRUID", 11
end
UnitLevel = function()
  return 60
end
GetLocale = function()
  return "enUS"
end
GetQuestGreenRange = function()
  return 10
end
UnitName = function()
  return "QuestieNPC"
end

---@diagnostic disable-next-line: lowercase-global
wipe = function(t)
  for k in pairs(t) do
    t[k] = nil
  end
  return t
end

LibStub = {
  NewLibrary = _EmptyDummyFunction,
  GetLibrary = _TableDummyFunction,
}
setmetatable(LibStub, {
  __call = function(_, ...)
    return { NewAddon = _TableDummyFunction, New = _TableDummyFunction, }
  end,
})
StaticPopupDialogs = {}

CreateFrame = function()
  return {
    Show = _EmptyDummyFunction,
    SetScript = _EmptyDummyFunction,
    RegisterEvent = _EmptyDummyFunction,
  }
end
C_QuestLog = {}

--* C_Timer
local timerList = {}
local function drainTimerList()
  for _, f in ipairs(timerList) do
    f()
  end
  timerList = {}
end
C_Timer = {
  After = function(_, f)
    -- f()
    timerList[#timerList + 1] = f
  end,
  NewTicker = function(_, f, times)
    if times then
      for _ = 1, times do
        timerList[#timerList + 1] = f
      end
      -- else
      --   -- hack
      --   local finished = false
      --   QuestieLoader:ImportModule("DBCompiler").ticker = {
      --     Cancel = function()
      --       finished = true
      --     end,
      --   }
      --   while not finished do
      --     f()
      --   end
    end
  end,
  ---@return cbObject
  NewTimer = function(_, f)
    timerList[#timerList + 1] = f
    ---@diagnostic disable-next-line: return-type-mismatch
    return nil
  end,
}

C_Seasons = {
  HasActiveSeason = function() return false end,
}
-- replace the C functions with local lua versions
function getglobal(varr)
  return _G[varr];
end

function Round(value)
  if value < 0.0 then
    return math.ceil(value - .5);
  end
  return math.floor(value + .5);
end

ItemRefTooltip = {
  SetHyperlink = _EmptyDummyFunction,
  IsShown = _EmptyDummyFunction,
  SetOwner = _EmptyDummyFunction,
  Show = _EmptyDummyFunction,
  Hide = _EmptyDummyFunction,
  AddLine = _EmptyDummyFunction,
  HookScript = _EmptyDummyFunction,
}

C_Map = {}

-- WoW addon namespace
local addonName = "QuestieDB"
local addonTable = {}

local function print(...)
  local printstring = ""
  for i = 1, select("#", ...) do
    local arg = select(i, ...)
    if arg == nil then
      printstring = printstring .. "  " .. "nil"
    else
      printstring = printstring .. "  " .. tostring(arg)
    end
  end
  io.stdout:write(printstring .. "\n")
  io.stdout:flush()
end

local function loadFile(filepath)
  -- Read file
  local filedata = io.open(filepath, "r")
  if not filedata then
    print("Error loading " .. filepath .. " - File not found")
    return
  end
  local filetext = filedata:read("*all")
  filetext = filetext:gsub("select%(2, %.%.%.%)", "LibQuestieDBTable")
  local pcallResult, errorMessage
  -- local chunck = loadfile(filepath)
  -- print(filetext)
  local chunck = loadstring(filetext)
  if chunck then
    pcallResult, errorMessage = pcall(chunck, addonName, addonTable)
  end
  if pcallResult then
    --print("Loaded " .. filepath)
  else
    if errorMessage then
      print("Error loading " .. filepath .. ": " .. errorMessage)
    else
      print("Error loading " .. filepath .. " - No errorMessage")
    end
  end
end

local function loadTOC(file)
  local rfile = io.open(file, "r")
  for line in rfile:lines() do
    -- If line is longer than 1 character and the first character is not a comment
    if string.len(line) > 1 and string.byte(line, 1) ~= 35 then
      -- If line is not a xml file
      if (not string.find(line, ".xml")) then
        line = line:gsub("\\", "/")
        line = line:gsub("%s+", "")
        print("Loading file: ", line)
        loadFile(line)
      elseif string.find(line, ".xml") then
        line = line:gsub("\\", "/")
        line = line:gsub("%s+", "")
        print("Loading XML:  ", line)
        local filedata = io.open(line, "r")
        local filetext = filedata:read("*all")
        local xmlFilePath = line:match("^(.*)/.-%.xml$") .. "/"
        -- print(xmlFilePath)
        for xmlFile in string.gmatch(filetext, "<Script.-file%=\"(.-)\"") do
          print("  Loading file: ", xmlFilePath .. xmlFile)
          loadFile(xmlFilePath .. xmlFile)
        end
      end
    end
  end
end

local initByVersion = {
  ["Era"] = function()
    LibQuestieDBTable = {}

    QuestieDB = {}
    QuestieLoader = {
      ImportModule = function()
        return QuestieDB
      end,
    }

    GetBuildInfo = function()
      return "1.14.3", "44403", "Jun 27 2022", 11403
    end

    WOW_PROJECT_ID = 2

    loadTOC("QuestieDB-Classic.toc")
  end,
  ["Tbc"] = function()
    LibQuestieDBTable = {}

    QuestieDB = {}
    QuestieLoader = {
      ImportModule = function()
        return QuestieDB
      end,
    }

    GetBuildInfo = function()
      return "2.5.1", "38644", "May 11 2021", 20501
    end

    WOW_PROJECT_ID = 5

    loadTOC("QuestieDB-BCC.toc")
  end,
  ["Wotlk"] = function()
    LibQuestieDBTable = {}

    QuestieDB = {}
    QuestieLoader = {
      ImportModule = function()
        return QuestieDB
      end,
    }

    GetBuildInfo = function()
      return "3.4.0", "44644", "Jun 12 2022", 30400
    end

    WOW_PROJECT_ID = 11

    loadTOC("QuestieDB-WOTLKC.toc")
  end,
}

local function DumpDatabase(version)
  local lowerVersion = version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the files and set wow version
  initByVersion[capitalizedVersion]()

  -- Drain all the timers
  print("Pre-Drain timer list")
  drainTimerList()

  print("Executing event: ADDON_LOADED")
  LibQuestieDBTable.RegisteredEvents["ADDON_LOADED"](addonName)

  -- Drain all the timers
  print("ADDON_LOADED timer list")
  drainTimerList()

  if not LibQuestieDBTable.Database.Initialized then
    error("Database not initialized")
  end

  local Corrections = LibQuestieDBTable.Corrections
  local publicLibQuestieDB = LibQuestieDB()

  --- Function to print details of the database
  ---@param dataType string
  ---@param dataDB QuestFunctions|ItemFunctions|NpcFunctions|ObjectFunctions
  ---@param dataIds number[]
  ---@param functionOrder function[]
  local function printDetails(dataType, dataDB, dataIds, functionOrder)
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
      end
      -- print(table.concat(printText, "\n"))
    end
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
  LibQuestieDBTable.l10n.RunGetTest(true)
end
local validVersions = {
  ["era"] = true,
  ["tbc"] = true,
  ["wotlk"] = true,
}
local versionString = ""
for version in pairs(validVersions) do
  local v = string.gsub(version, "^%l", string.upper)
  versionString = versionString .. v .. "/"
end
-- Add all
versionString = versionString .. "All"

local parser = argparse("createStatic", "createStatic.lua Era")
parser:argument("version", f("Game version, %s.", versionString))

local args = parser:parse()

if args.version and validVersions[args.version:lower()] then
  DumpDatabase(args.version)
elseif args.version and args.version:lower() == "all" then
  for version in pairs(validVersions) do
    DumpDatabase(version)
  end
else
  print("No version specified")
end
-- for _, questId in pairs(AllQuestIds) do
--   local printText = {}
--   table.insert(printText, f("----------------- Quest %s", questId))
--   for i = 1, #functionOrder do
--     local functionName = functionOrder[i]
--     if publicLibQuestieDB.Quest[functionName] then
--       local success, result = pcall(publicLibQuestieDB.Quest[functionName], questId)
--       if success then
--         if type(result) == "table" then
--           table.insert(printText, f("    %s: %s", functionName, printableTable(result)))
--         else
--           table.insert(printText, f("    %s: %s", functionName, tostring(result)))
--         end
--       else
--         error(f("Function %s failed for id %d: %s", functionName, questId, result))
--       end
--     else
--       error(f("Function %s not found", functionName))
--     end
--   end
--   print(table.concat(printText, "\n"))
-- end
