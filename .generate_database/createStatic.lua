require("cli.dump")

---@type LibQuestieDB
LibQuestieDBTable = {}

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
  io.stderr:write(printstring .. "\n")
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
        loadFile(line)
      elseif string.find(line, ".xml") then
        line = line:gsub("\\", "/")
        line = line:gsub("%s+", "")
        print(line)
        local filedata = io.open(line, "r")
        local filetext = filedata:read("*all")
        local xmlFilePath = line:match("^(.*)/.-%.xml$") .. "/"
        print(xmlFilePath)
        for xmlFile in string.gmatch(filetext, "<Script.-file%=\"(.-)\"") do
          loadFile(xmlFilePath .. xmlFile)
        end
      end
    end
  end
end

local function _Debug(_, ...)
  --print(...)
end

local function _ErrorOrWarning(_, text, ...)
  io.stderr:write(tostring(text) .. "\n")
end

local function space(num)
  local spaces = ''
  for _ = 1, num do
    spaces = spaces .. '  '
  end
  return spaces
end

local function dumpTable(o, level)
  if level == nil then level = 0 end
  if type(o) == 'table' then
    local s = '{'
    local indexTable = true
    local indexCount = #o
    local totalCount = 0
    for _ in pairs(o) do
      totalCount = totalCount + 1
    end
    if indexCount ~= totalCount then
      indexTable = false
    end

    local count = 0
    for k, v in pairs(o) do
      count = count + 1
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      if v == "nil" then
        v = nil
      end
      if type(v) == "string" then
        v = v:gsub('"', '\\"')
        v = '"' .. v .. '"'
      end

      if not indexTable then
        s = s .. (level <= 2 and '\n' .. space(level + 1) or '') .. '[' .. k .. '] = ' .. dumpTable(v, level + 1) .. ','
      else
        s = s .. (level <= 2 and '\n' .. space(level + 1) or '') .. dumpTable(v, level + 1) .. ','
      end
    end
    return s .. ((count >= totalCount and level <= 2) and "\n" .. space(level) or "") .. '}'
  else
    return tostring(o)
  end
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

  do
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
  local file = io.open(".generate_database/_data/Era/ItemOverride.lua-table", "w")
  file:write(dumpTable(itemOverride))
  file:close()

  file = io.open(".generate_database/_data/Era/QuestOverride.lua-table", "w")
  file:write(dumpTable(questOverride))
  file:close()

  file = io.open(".generate_database/_data/Era/NpcOverride.lua-table", "w")
  file:write(dumpTable(npcOverride))
  file:close()

  file = io.open(".generate_database/_data/Era/ObjectOverride.lua-table", "w")
  file:write(dumpTable(objectOverride))
  file:close()

  print("\n\27[32mClassic corrections dumped successfully\27[0m")
end
_CheckClassicDatabase()

LibQuestieDBTable = {}
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

  do
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
  local file = io.open(".generate_database/_data/Tbc/ItemOverride.lua-table", "w")
  file:write(dumpTable(itemOverride))
  file:close()

  file = io.open(".generate_database/_data/Tbc/QuestOverride.lua-table", "w")
  file:write(dumpTable(questOverride))
  file:close()

  file = io.open(".generate_database/_data/Tbc/NpcOverride.lua-table", "w")
  file:write(dumpTable(npcOverride))
  file:close()

  file = io.open(".generate_database/_data/Tbc/ObjectOverride.lua-table", "w")
  file:write(dumpTable(objectOverride))
  file:close()

  print("\n\27[TBC corrections dumped successfully\27[0m")
end
_CheckTBCDatabase()

LibQuestieDBTable = {}
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

  do
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
  file:write(dumpTable(itemOverride))
  file:close()

  file = io.open(".generate_database/_data/Wotlk/QuestOverride.lua-table", "w")
  file:write(dumpTable(questOverride))
  file:close()

  file = io.open(".generate_database/_data/Wotlk/NpcOverride.lua-table", "w")
  file:write(dumpTable(npcOverride))
  file:close()

  file = io.open(".generate_database/_data/Wotlk/ObjectOverride.lua-table", "w")
  file:write(dumpTable(objectOverride))
  file:close()

  print("\n\27[Wotlk corrections dumped successfully\27[0m")
end
_CheckWotlkDatabase()
