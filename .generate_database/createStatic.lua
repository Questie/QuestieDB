require("cli.dump")

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

tremove = table.remove
tinsert = table.insert

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

---comment
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

  local reversedKeys = {}
  for key, id in pairs(dataKeys) do
    reversedKeys[id] = key
  end

  -- DevTools_Dump({typeLookup})
  -- assert(true==false, "stop")
  local allResults = { "{\n", }
  for _, sortKey in ipairs(sortedKeys) do
    -- print(sortKey)
    local value = tbl[sortKey]

    local resulttable = {}
    for _ in pairs(dataKeys) do
      resulttable[#resulttable + 1] = "nil"
    end

    for key in ipairs(resulttable) do
      -- The name of the key e.g. "objectDrops"
      local dataName = dataKeys[key] == nil and reversedKeys[key] or key
      -- The id of the key e.g. "3"-(objectDrops)
      local dataKey = type(key) == "number" and key or dataKeys[key]
      -- print(dataName)
      -- Get the data from the table
      local data = value[key]

      -- Because we build it with nil we have to check for nil here, if the value is nil we just print nil
      if data ~= "nil" and data ~= nil then
        local dumpFunction = dumpFunctions[dataName]
        if dumpFunction then
          local dumpedData = dumpFunction(data)
          -- Replace double '' with single '
          -- dumpedData = dumpedData:gsub("''", "'")
          -- if cli_debug then
          --   local debugString = ", --" .. dataKey .. ":" .. dataName
          --   resulttable[dataKey] = "\n  " .. dumpedData .. "" .. debugString
          -- else
          --   resulttable[dataKey] = "" .. dumpedData .. ""
          resulttable[dataKey] = dumpedData
          -- end
        else
          error("No dump function for key: " .. "dataName" .. " (" .. tostring(dataName) .. ")" .. " dataKey: " .. tostring(dataKey))
        end
      else
        -- if cli_debug then
        --   local debugString = ", --" .. dataKey .. ":" .. dataName
        --   resulttable[dataKey] = "\n  nil" .. debugString
        -- else
        resulttable[dataKey] = "nil"
        -- end
      end
    end
    -- DevTools_Dump({resulttable})
    -- assert(true==false, "stop")
    -- DevTools_Dump({ resulttable, })
    -- local combinedString = LibQuestieDBTable.Corrections.ItemMeta.combine(resulttable)
    if combineFunc then
      combineFunc(resulttable)
    end
    -- print("test", combinedString)
    -- DevTools_Dump({resulttable})
    -- allResults[#allResults + 1] = function() return "  [" .. sortKey .. "] = {" .. table.concat(resulttable, ",") .. "},\n", sortKey, resulttable end
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


local function _CheckClassicDatabase()
  GetBuildInfo = function()
    return "1.14.3", "44403", "Jun 27 2022", 11403
  end

  print("\n\27[36mCompiling Classic database...\27[0m")
  loadTOC("QuestieDB-Classic.toc")
  -- Drain all the timers
  drainTimerList()

  local itemOverride = {}
  local npcOverride = {}
  local objectOverride = {}
  local questOverride = {}

  local Corrections = LibQuestieDBTable.Corrections

  Corrections.DumpFunctions.testDumpFunctions()

  do
    loadFile(".generate_database/_data/Era/classicItemDB.lua")
    itemOverride = loadstring(QuestieDB.itemData)()
    LibQuestieDBTable.Item.LoadOverrideData()
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
    loadFile(".generate_database/_data/Era/classicNpcDB.lua")
    npcOverride = loadstring(QuestieDB.npcData)()
    LibQuestieDBTable.Npc.LoadOverrideData()
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
    loadFile(".generate_database/_data/Era/classicObjectDB.lua")
    objectOverride = loadstring(QuestieDB.objectData)()
    LibQuestieDBTable.Object.LoadOverrideData()
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
    loadFile(".generate_database/_data/Era/classicQuestDB.lua")
    questOverride = loadstring(QuestieDB.questData)()
    LibQuestieDBTable.Quest.LoadOverrideData()
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
  local file = io.open(".generate_database/_data/Era/ItemOverride.lua-table", "w")
  print("Dumping item overrides")
  local itemData = dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs, Corrections.ItemMeta.combine)
  file:write(itemData)
  file:close()

  file = io.open(".generate_database/_data/Era/QuestOverride.lua-table", "w")
  print("Dumping quest overrides")
  local questData = dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  file:write(questData)
  file:close()

  local file = io.open(".generate_database/_data/Era/NpcOverride.lua-table", "w")
  print("Dumping npc overrides")
  local npcData = dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs, Corrections.NpcMeta.combine)
  file:write(npcData)
  file:close()

  file = io.open(".generate_database/_data/Era/ObjectOverride.lua-table", "w")
  print("Dumping object overrides")
  local objectData = dumpData(objectOverride, Corrections.ObjectMeta.objectKeys, Corrections.ObjectMeta.dumpFuncs)
  file:write(objectData)
  file:close()

  print("\n\27[32mClassic corrections dumped successfully\27[0m")
end
_CheckClassicDatabase()

LibQuestieDBTable = {}
QuestieDB = {}
local function _CheckTBCDatabase()
  GetBuildInfo = function()
    return "2.5.1", "38644", "May 11 2021", 20501
  end
  WOW_PROJECT_ID = 5

  print("\n\27[36mCompiling TBC database...\27[0m")
  loadTOC("QuestieDB-BCC.toc")
  -- Drain all the timers
  drainTimerList()

  local itemOverride = {}
  local npcOverride = {}
  local objectOverride = {}
  local questOverride = {}

  local Corrections = LibQuestieDBTable.Corrections

  Corrections.DumpFunctions.testDumpFunctions()

  do
    loadFile(".generate_database/_data/Tbc/tbcItemDB.lua")
    itemOverride = loadstring(QuestieDB.itemData)()
    LibQuestieDBTable.Item.LoadOverrideData()
    local itemMeta = LibQuestieDBTable.Corrections.ItemMeta
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
    loadFile(".generate_database/_data/Tbc/tbcNpcDB.lua")
    npcOverride = loadstring(QuestieDB.npcData)()
    LibQuestieDBTable.Npc.LoadOverrideData()
    local npcMeta = LibQuestieDBTable.Corrections.NpcMeta
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
    loadFile(".generate_database/_data/Tbc/tbcObjectDB.lua")
    objectOverride = loadstring(QuestieDB.objectData)()
    LibQuestieDBTable.Object.LoadOverrideData()
    local objectMeta = LibQuestieDBTable.Corrections.ObjectMeta
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
    loadFile(".generate_database/_data/Tbc/tbcQuestDB.lua")
    questOverride = loadstring(QuestieDB.questData)()
    LibQuestieDBTable.Quest.LoadOverrideData()
    local questMeta = LibQuestieDBTable.Corrections.QuestMeta
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
  -- local file = io.open(".generate_database/_data/Tbc/ItemOverride.lua-table", "w")
  -- print("Dumping item overrides")
  -- local itemData = dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs, Corrections.ItemMeta.combine)
  -- file:write(itemData)
  -- file:close()

  file = io.open(".generate_database/_data/Tbc/QuestOverride.lua-table", "w")
  print("Dumping quest overrides")
  local questData = dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  file:write(questData)
  file:close()

  file = io.open(".generate_database/_data/Tbc/NpcOverride.lua-table", "w")
  print("Dumping npc overrides")
  local npcData = dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs, Corrections.NpcMeta.combine)
  file:write(npcData)
  file:close()

  file = io.open(".generate_database/_data/Tbc/ObjectOverride.lua-table", "w")
  local objectData = dumpData(objectOverride, Corrections.ObjectMeta.objectKeys, Corrections.ObjectMeta.dumpFuncs)
  file:write(objectData)
  file:close()

  print("\n\27[TBC corrections dumped successfully\27[0m")
end
_CheckTBCDatabase()

LibQuestieDBTable = {}
QuestieDB = {}
local function _CheckWotlkDatabase()
  GetBuildInfo = function()
    return "3.4.0", "44644", "Jun 12 2022", 30400
  end
  WOW_PROJECT_ID = 11

  print("\n\27[36mCompiling Wotlk database...\27[0m")
  loadTOC("QuestieDB-WOTLKC.toc")
  -- Drain all the timers
  drainTimerList()

  local itemOverride = {}
  local npcOverride = {}
  local objectOverride = {}
  local questOverride = {}

  local Corrections = LibQuestieDBTable.Corrections

  Corrections.DumpFunctions.testDumpFunctions()

  do
    loadFile(".generate_database/_data/Wotlk/wotlkItemDB.lua")
    itemOverride = loadstring(QuestieDB.itemData)()
    LibQuestieDBTable.Item.LoadOverrideData()
    local itemMeta = LibQuestieDBTable.Corrections.ItemMeta
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
    loadFile(".generate_database/_data/Wotlk/wotlkNpcDB.lua")
    npcOverride = loadstring(QuestieDB.npcData)()
    LibQuestieDBTable.Npc.LoadOverrideData()
    local npcMeta = LibQuestieDBTable.Corrections.NpcMeta
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
    loadFile(".generate_database/_data/Wotlk/wotlkObjectDB.lua")
    objectOverride = loadstring(QuestieDB.objectData)()
    LibQuestieDBTable.Object.LoadOverrideData()
    local objectMeta = LibQuestieDBTable.Corrections.ObjectMeta
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
    loadFile(".generate_database/_data/Wotlk/wotlkQuestDB.lua")
    questOverride = loadstring(QuestieDB.questData)()
    LibQuestieDBTable.Quest.LoadOverrideData()
    local questMeta = LibQuestieDBTable.Corrections.QuestMeta
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
  local file = io.open(".generate_database/_data/Wotlk/ItemOverride.lua-table", "w")
  local itemData = dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs, Corrections.ItemMeta.combine)
  file:write(itemData)
  file:close()

  file = io.open(".generate_database/_data/Wotlk/QuestOverride.lua-table", "w")
  print("Dumping quest overrides")
  local questData = dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  file:write(questData)
  file:close()

  file = io.open(".generate_database/_data/Wotlk/NpcOverride.lua-table", "w")
  print("Dumping npc overrides")
  local npcData = dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs, Corrections.NpcMeta.combine)
  file:write(npcData)
  file:close()

  file = io.open(".generate_database/_data/Wotlk/ObjectOverride.lua-table", "w")
  local objectData = dumpData(objectOverride, Corrections.ObjectMeta.objectKeys, Corrections.ObjectMeta.dumpFuncs)
  file:write(objectData)
  file:close()

  print("\n\27[Wotlk corrections dumped successfully\27[0m")
end
_CheckWotlkDatabase()
