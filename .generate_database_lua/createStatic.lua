-- Allow accessing private fields
---@diagnostic disable: invisible
require("cli.dump")
local argparse = require("argparse")
local helpers = require(".helpers")

require("cli.Addon_Meta")
require("cli.CLI_Helpers")

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
    CLI_Helpers.loadFile(f(".generate_database/_data/%sItemDB.lua", lowerVersion))
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
    CLI_Helpers.loadFile(f(".generate_database/_data/%sNpcDB.lua", lowerVersion))
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
    CLI_Helpers.loadFile(f(".generate_database/_data/%sObjectDB.lua", lowerVersion))
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
    CLI_Helpers.loadFile(f(".generate_database/_data/%sQuestDB.lua", lowerVersion))
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
  -- local file = io.open(f(".generate_database/_data/output/Item/%s/ItemData.lua-table", capitalizedVersion), "w")
  print("Dumping item overrides")
  -- assert(file, "Failed to open file for writing")
  local itemData = helpers.dumpData(itemOverride, Corrections.ItemMeta.itemKeys, Corrections.ItemMeta.dumpFuncs, Corrections.ItemMeta.combine)
  ---@diagnostic disable-next-line: undefined-field
  -- file:write(itemData)
  ---@diagnostic disable-next-line: undefined-field
  -- file:close()

  -- ---@diagnostic disable-next-line: param-type-mismatch
  -- file = io.open(f(".generate_database/_data/output/Quest/%s/QuestData.lua-table", capitalizedVersion), "w")
  -- print("Dumping quest overrides")
  -- assert(file, "Failed to open file for writing")
  -- local questData = helpers.dumpData(questOverride, Corrections.QuestMeta.questKeys, Corrections.QuestMeta.dumpFuncs)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:write(questData)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:close()

  -- ---@diagnostic disable-next-line: param-type-mismatch
  -- file = io.open(f(".generate_database/_data/output/Npc/%s/NpcData.lua-table", capitalizedVersion), "w")
  -- print("Dumping npc overrides")
  -- assert(file, "Failed to open file for writing")
  -- local npcData = helpers.dumpData(npcOverride, Corrections.NpcMeta.npcKeys, Corrections.NpcMeta.dumpFuncs, Corrections.NpcMeta.combine)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:write(npcData)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:close()

  -- ---@diagnostic disable-next-line: param-type-mismatch
  -- file = io.open(f(".generate_database/_data/output/Object/%s/ObjectData.lua-table", capitalizedVersion), "w")
  -- print("Dumping object overrides")
  -- assert(file, "Failed to open file for writing")
  -- local objectData = helpers.dumpData(objectOverride, Corrections.ObjectMeta.objectKeys, Corrections.ObjectMeta.dumpFuncs)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:write(objectData)
  -- ---@diagnostic disable-next-line: undefined-field
  -- file:close()

  print(f("\n\27[32m%s corrections dumped successfully\27[0m", capitalizedVersion))
end

-- local validVersions = {
--   ["era"] = true,
--   ["tbc"] = true,
--   ["wotlk"] = true,
-- }
-- local versionString = ""
-- for version in pairs(validVersions) do
--   local v = string.gsub(version, "^%l", string.upper)
--   versionString = versionString .. v .. "/"
-- end
-- -- Add all
-- versionString = versionString .. "All"

-- local parser = argparse("createStatic", "createStatic.lua Era")
-- parser:argument("version", f("Game version, %s.", versionString))

-- local args = parser:parse()

-- if args.version and validVersions[args.version:lower()] then
--   DumpDatabase(args.version)
-- elseif args.version and args.version:lower() == "all" then
--   for version in pairs(validVersions) do
--     DumpDatabase(version)
--   end
-- else
--   print("No version specified")
-- end
