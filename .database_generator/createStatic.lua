local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local argparse = require("argparse")
local helpers = require(".db_helpers")

require(".dump")

require("cli.Addon_Meta")
require("cli.CLI_Helpers")
local lfs = require("lfs")

assert(Is_CLI, "This function should only be called from the CLI environment")

local f = string.format

Is_Create_Static = true

function DumpDatabase(version)
  local lowerVersion = version:lower()
  local capitalizedVersion = lowerVersion:gsub("^%l", string.upper)
  print(f("\n\27[36mCompiling %s database...\27[0m", capitalizedVersion))

  -- Reset data objects, load the files and set wow version
  LibQuestieDBTable = AddonInitializeVersion(capitalizedVersion)

  -- Drain all the timers
  C_Timer.drainTimerList()

  local itemOverride = {}
  local npcOverride = {}
  local objectOverride = {}
  local questOverride = {}

  local Corrections = LibQuestieDBTable.Corrections

  Corrections.DumpFunctions.testDumpFunctions()

  do
    CLI_Helpers.loadFile(f("%s/_data/%sItemDB.lua", script_dir, lowerVersion))
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
    CLI_Helpers.loadFile(f("%s/_data/%sNpcDB.lua", script_dir, lowerVersion))
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
    CLI_Helpers.loadFile(f("%s/_data/%sObjectDB.lua", script_dir, lowerVersion))
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
    CLI_Helpers.loadFile(f("%s/_data/%sQuestDB.lua", script_dir, lowerVersion))
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

  local basePath = f("%s/_data/output", script_dir)
  if not lfs.attributes(basePath, "mode") then
    lfs.mkdir(basePath)
    print("Created directory: " .. basePath)
  end
  local entityTypes = { "Item", "Npc", "Object", "Quest", }
  for _, entityType in ipairs(entityTypes) do
    local path = f("%s/%s", basePath, entityType)
    if not lfs.attributes(path, "mode") then
      lfs.mkdir(path)
      print("Created directory: " .. path)
    end
    local versionPath = f("%s/%s", path, capitalizedVersion)
    if not lfs.attributes(versionPath, "mode") then
      lfs.mkdir(versionPath)
      print("Created directory: " .. versionPath)
    end
  end


  -- ! We write all these files to disk for the sake of comparing changes between versions
  -- Write all the overrides to disk
  print("Dumping item overrides")
  local itemDataString = helpers.dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs,
                                          Corrections.ItemMeta.combine)
  local itemFile = io.open(f("%s/_data/output/Item/%s/ItemData.lua-table", script_dir, capitalizedVersion), "w")
  assert(itemFile, "Failed to open file for writing")
  itemFile:write(itemDataString)
  itemFile:close()
  print("Dumping item overrides to HTML")
  GenerateHtmlForEntityType(itemOverride, Corrections.ItemMeta, "Item", version)

  print("Dumping quest overrides")
  local questDataString = helpers.dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  local questFile = io.open(f("%s/_data/output/Quest/%s/QuestData.lua-table", script_dir, capitalizedVersion), "w")
  assert(questFile, "Failed to open file for writing")
  questFile:write(questDataString)
  questFile:close()
  print("Dumping quest overrides to HTML")
  GenerateHtmlForEntityType(questOverride, Corrections.QuestMeta, "Quest", version)

  print("Dumping npc overrides")
  local npcDataString = helpers.dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs,
                                         Corrections.NpcMeta.combine)
  local npcFile = io.open(f("%s/_data/output/Npc/%s/NpcData.lua-table", script_dir, capitalizedVersion), "w")
  assert(npcFile, "Failed to open file for writing")
  npcFile:write(npcDataString)
  npcFile:close()
  print("Dumping npc overrides to HTML")
  GenerateHtmlForEntityType(npcOverride, Corrections.NpcMeta, "Npc", version)

  print("Dumping object overrides")
  local objectDataString = helpers.dumpData(objectOverride, Corrections.ObjectMeta.objectKeys,
                                            Corrections.ObjectMeta.dumpFuncs)
  local objectFile = io.open(f("%s/_data/output/Object/%s/ObjectData.lua-table", script_dir, capitalizedVersion), "w")
  assert(objectFile, "Failed to open file for writing")
  objectFile:write(objectDataString)
  objectFile:close()
  print("Dumping object overrides to HTML")
  GenerateHtmlForEntityType(objectOverride, Corrections.ObjectMeta, "Object", version)


  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedVersion))
end
