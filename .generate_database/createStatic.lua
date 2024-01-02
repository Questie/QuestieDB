---@diagnostic disable: need-check-nil
require("cli.dump")
local argparse = require("argparse")

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

---Dumps the data for Item, Quest, Npc, Object into a string
---@param tbl table<number, table<number, any>> @ Table that will be dumped, Item, Quest, Npc, Object
---@param dataKeys ItemDBKeys|QuestDBKeys|NpcDBKeys|ObjectDBKeys @ Contains name of data as keys and their index as value
---@param dumpFunctions table<string, function> @ Contains the functions that will be used to dump the data
---@param combineFunc function? @ Function that will be used to combine the data, if nil the data will not be combined
---@return string
local function dumpData(tbl, dataKeys, dumpFunctions, combineFunc)
  -- sort tbl by key
  local sortedKeys = {}
  for key in pairs(tbl) do
    sortedKeys[#sortedKeys + 1] = key
  end
  table.sort(sortedKeys)

  local nrDataKeys = 0
  local reversedKeys = {}
  for key, id in pairs(dataKeys) do
    reversedKeys[id] = key
    nrDataKeys = nrDataKeys + 1
  end

  local allResults = { "{\n", }
  for sortKeyIndex=1, #sortedKeys do
    local sortKey = sortedKeys[sortKeyIndex]

    -- print(sortKey)
    local value = tbl[sortKey]

    local resulttable = {}
    for i = 1, nrDataKeys do
      resulttable[i] = "nil"
    end

    for key = 1, nrDataKeys do
      -- The name of the key e.g. "objectDrops"
      local dataName = dataKeys[key] == nil and reversedKeys[key] or key
      -- The id of the key e.g. "3"-(objectDrops)
      local dataKey = type(key) == "number" and key or dataKeys[key]

      -- print(key, dataName, dataKey)

      -- Get the data from the table
      local data = value[key]

      -- Because we build it with nil we have to check for nil here, if the value is nil we just print nil
      if data ~= "nil" and data ~= nil then
        local dumpFunction = dumpFunctions[dataName]
        if dumpFunction then
          local dumpedData = dumpFunction(data)
          resulttable[dataKey] = dumpedData
        else
          error("No dump function for key: " .. "dataName" .. " (" .. tostring(dataName) .. ")" .. " dataKey: " .. tostring(dataKey))
        end
      else
        resulttable[dataKey] = "nil"
      end
    end
    -- DevTools_Dump({resulttable})

    -- If a combine funnction exist we run it here
    assert(#resulttable == nrDataKeys, "resulttable length is not equal to dataKeys length, combine will fail")
    if combineFunc then
      combineFunc(resulttable)
    end
    -- DevTools_Dump({resulttable})

    -- Concat the data into a string
    local data = table.concat(resulttable, ",")
    -- Remove trailing nil
    repeat
      local count = 0
      data, count = string.gsub(data, ",nil$", "")
    until count == 0

    -- Add the data to the result
    allResults[#allResults + 1] = "  [" .. sortKey .. "] = {"
    allResults[#allResults + 1] = data
    allResults[#allResults + 1] = ",},\n"
  end
  allResults[#allResults + 1] = "}"
  -- return result .. "}"
  return table.concat(allResults)
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
  end
}

local function DumpDatabase(version)
  local lowerVersion = version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the files and set wow version
  initByVersion[capitalizedVersion]()

  -- Drain all the timers
  drainTimerList()

  local itemOverride = {}
  local npcOverride = {}
  local objectOverride = {}
  local questOverride = {}

  local Corrections = LibQuestieDBTable.Corrections

  Corrections.DumpFunctions.testDumpFunctions()

  do
    loadFile(f(".generate_database/_data/%s/%sItemDB.lua", capitalizedVersion, lowerVersion))
    itemOverride = loadstring(QuestieDB.itemData)()
    LibQuestieDBTable.Item.LoadOverrideData(false, true)
    local itemMeta = Corrections.ItemMeta
    for itemId, corrections in pairs(LibQuestieDBTable.Item.override) do
      if not itemOverride[itemId] then
        itemOverride[itemId] = {}
      end
      for key, correction in pairs(corrections) do
        local correctionIndex = itemMeta.itemKeys[key]
        itemOverride[itemId][correctionIndex] = correction
      end
    end
  end

  do
    loadFile(f(".generate_database/_data/%s/%sNpcDB.lua", capitalizedVersion, lowerVersion))
    npcOverride = loadstring(QuestieDB.npcData)()
    LibQuestieDBTable.Npc.LoadOverrideData(false, true)
    local npcMeta = Corrections.NpcMeta
    for npcId, corrections in pairs(LibQuestieDBTable.Npc.override) do
      if not npcOverride[npcId] then
        npcOverride[npcId] = {}
      end
      for key, correction in pairs(corrections) do
        local correctionIndex = npcMeta.npcKeys[key]
        npcOverride[npcId][correctionIndex] = correction
      end
    end
  end

  do
    loadFile(f(".generate_database/_data/%s/%sObjectDB.lua", capitalizedVersion, lowerVersion))
    objectOverride = loadstring(QuestieDB.objectData)()
    LibQuestieDBTable.Object.LoadOverrideData(false, true)
    local objectMeta = Corrections.ObjectMeta
    for objectId, corrections in pairs(LibQuestieDBTable.Object.override) do
      if not objectOverride[objectId] then
        objectOverride[objectId] = {}
      end
      for key, correction in pairs(corrections) do
        local correctionIndex = objectMeta.objectKeys[key]
        objectOverride[objectId][correctionIndex] = correction
      end
    end
  end

  do
    loadFile(f(".generate_database/_data/%s/%sQuestDB.lua", capitalizedVersion, lowerVersion))
    questOverride = loadstring(QuestieDB.questData)()
    LibQuestieDBTable.Quest.LoadOverrideData(false, true)
    local questMeta = Corrections.QuestMeta
    for questId, corrections in pairs(LibQuestieDBTable.Quest.override) do
      if not questOverride[questId] then
        questOverride[questId] = {}
      end
      for key, correction in pairs(corrections) do
        local correctionIndex = questMeta.questKeys[key]
        questOverride[questId][correctionIndex] = correction
      end
    end
  end

  -- Write all the overrides to disk
  ---@diagnostic disable-next-line: param-type-mismatch
  local file = io.open(f(".generate_database/_data/%s/ItemOverride.lua-table", capitalizedVersion), "w")
  print("Dumping item overrides")
  local itemData = dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs, Corrections.ItemMeta.combine)
  ---@diagnostic disable-next-line: undefined-field
  file:write(itemData)
  ---@diagnostic disable-next-line: undefined-field
  file:close()

  ---@diagnostic disable-next-line: param-type-mismatch
  file = io.open(f(".generate_database/_data/%s/QuestOverride.lua-table", capitalizedVersion), "w")
  print("Dumping quest overrides")
  local questData = dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  ---@diagnostic disable-next-line: undefined-field
  file:write(questData)
  ---@diagnostic disable-next-line: undefined-field
  file:close()

  ---@diagnostic disable-next-line: param-type-mismatch
  file = io.open(f(".generate_database/_data/%s/NpcOverride.lua-table", capitalizedVersion), "w")
  print("Dumping npc overrides")
  local npcData = dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs, Corrections.NpcMeta.combine)
  ---@diagnostic disable-next-line: undefined-field
  file:write(npcData)
  ---@diagnostic disable-next-line: undefined-field
  file:close()

  ---@diagnostic disable-next-line: param-type-mismatch
  file = io.open(f(".generate_database/_data/%s/ObjectOverride.lua-table", capitalizedVersion), "w")
  print("Dumping object overrides")
  local objectData = dumpData(objectOverride, Corrections.ObjectMeta.objectKeys, Corrections.ObjectMeta.dumpFuncs)
  ---@diagnostic disable-next-line: undefined-field
  file:write(objectData)
  ---@diagnostic disable-next-line: undefined-field
  file:close()

  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedVersion))
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
