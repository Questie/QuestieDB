---@class LibQuestieDB
---@field Item Item
local LibQuestieDB = select(2, ...)

---@class Item:ItemFunctions
local Item = LibQuestieDB.Item
GItem = Item

--*---- Import Modules -------
local Database = LibQuestieDB.Database
local Corrections = LibQuestieDB.Corrections
local DebugText = LibQuestieDB.DebugText

local debug = DebugText:Get("Item")

--*---------------------------
--- The nil value for the database
local _nil = Database._nil

---- Contains the data ----
local glob = {}
local override = {}

---- Contains the id strings ----
local AllIdStrings = {}

---- Local Functions ----
local tonumber = tonumber
local tConcat = table.concat
local tInsert = table.insert
local wipe = wipe
local loadstring = loadstring
local sFind = string.find


function Item.InitializeDynamic()
  -- This will be assigned from the initialize function
  local itemData = Database.LoadDatafileList("ItemData")
  -- localized for faster access
  local loadFile = Database.LoadFile
  -- Get the binary search function
  local binarySearch, _ = Database.CreateFindDataBinarySearchFunction(itemData)

  ---@type table<ItemId, table<number, FontString>>
  glob = setmetatable({},
    {
      __index = function(t, k)
        return loadFile(binarySearch(k), t, k)
      end,
      __newindex = function()
        error("Attempt to modify read-only table")
      end
    }
  )
  Item.glob = glob
  Item.LoadOverrideData()
end

---@param includeDynamic boolean? @If true, include dynamic data Default true
---@param includeStatic boolean? @If true, include dynamic data Default false
function Item.LoadOverrideData(includeDynamic, includeStatic)
  if includeDynamic == nil then
    includeDynamic = true
  end
  if includeStatic == nil then
    includeStatic = Database.debugEnabled or false
  end
  -- Clear the override data
  Item.ClearOverrideData()

  print("Loading Item Corrections")
  local loadOrder = 0
  local totalLoaded = 0
  -- Load all Item Corrections
  for _, list in pairs(Corrections.GetCorrections("item", includeStatic, includeDynamic)) do
    for id, func in pairs(list) do
      local correctionData = func()
      totalLoaded = totalLoaded + Item.AddOverrideData(correctionData, Corrections.ItemMeta.itemKeys)
      if Database.debugEnabled then
        debug:Print("  " .. tostring(loadOrder) .. "  Loaded", id)
      end
      loadOrder = loadOrder + 1
    end
  end
  if Database.debugEnabled then
    debug:Print("  # Item Corrections", totalLoaded)
  end
  Item.override = override
end

function Item.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Item database before adding override data")
  end
  local newIds = Database.GetNewIds(AllIdStrings, dataOverride)
  if #newIds ~= 0 then
    tInsert(AllIdStrings, tConcat(newIds, ","))
    if Database.debugEnabled then
      print("  # New Item IDs", #newIds)
    end
  end
  return Database.Override(dataOverride, override, overrideKeys)
end

local function InitializeIdString()
  wipe(AllIdStrings)
  local _, idString = Database.GetAllEntityIdsFunction("Item")
  tInsert(AllIdStrings, idString)
end

function Item.ClearOverrideData()
  if override then
    override = wipe(override)
  end
  InitializeIdString()
end

do
  ---Get all item ids.
  ---@return ItemId[]
  function Item.GetAllItemIds()
    return loadstring(string.format("return {%s}", tConcat(AllIdStrings, ",")))()
  end
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- Class for all the GET functions for the Item namespace
  ---@class ItemFunctions
  local ItemFunctions = {}

  --? This function is used to export all the functions to the Public and Private namespaces
  --? It gets called at the end of this file
  local function exportFunctions()
    ---@class ItemFunctions
    local publicItem = LibQuestieDB.PublicLibQuestieDB.Item
    for k, v in pairs(ItemFunctions) do
      Item[k] = v
      publicItem[k] = v
    end
    publicItem.AddOverrideData = Item.AddOverrideData
    publicItem.ClearOverrideData = Item.ClearOverrideData
    publicItem.GetAllItemIds = Item.GetAllItemIds
  end

  -- 1. ['name']           -- string
  -- 2. ['npcDrops']       -- table or nil, NPC IDs
  -- 3. ['objectDrops']    -- table or nil, object IDs
  -- 4. ['itemDrops']      -- table or nil, item IDs
  -- 5. ['startQuest']     -- int or nil, ID of the quest started by this item
  -- 6. ['questRewards']   -- table or nil, quest IDs
  -- 7. ['meta-data']
  --   1. ['flags']          -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
  --   2. ['foodType']       -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
  --   3. ['itemLevel']      -- int, the level of this item
  --   4. ['requiredLevel'] -- int, the level required to equip/use this item
  --   5. ['ammoType']      -- int,
  --   6. ['class']         -- int,
  --   7. ['subClass']      -- int,
  -- 8. ['vendors']       -- table or nil, NPC IDs
  -- 9. ['relatedQuests'] -- table or nil, IDs of quests that are related to this item
  -- 10. ['teachesSpell'] -- int, spellID taught by this item upon use

  ---Returns the item name.
  ---@param id ItemId
  ---@return Name?
  function ItemFunctions.name(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["name"] then
      local name = override[id]["name"]
      return name ~= _nil and name or nil
    end
    local data = glob[id]
    if data[1] then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the IDs of NPCs that drop this item.
  ---@param id ItemId
  ---@return NpcId[]?
  function ItemFunctions.npcDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["npcDrops"] then
      local npcDrops = override[id]["npcDrops"]
      return npcDrops ~= _nil and npcDrops or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[2])
    else
      return nil
    end
  end

  ---Returns the IDs of objects that drop this item.
  ---@param id ItemId
  ---@return ObjectId[]?
  function ItemFunctions.objectDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["objectDrops"] then
      local objectDrops = override[id]["objectDrops"]
      return objectDrops ~= _nil and objectDrops or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[3])
    else
      return nil
    end
  end

  ---Returns the IDs of items that drop this item.
  ---@param id ItemId
  ---@return ItemId[]?
  function ItemFunctions.itemDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["itemDrops"] then
      local itemDrops = override[id]["itemDrops"]
      return itemDrops ~= _nil and itemDrops or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[4])
    else
      return nil
    end
  end

  ---Returns the ID of the quest started by this item.
  ---@param id ItemId
  ---@return QuestId?
  function ItemFunctions.startQuest(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["startQuest"] then
      local startQuest = override[id]["startQuest"]
      return startQuest ~= _nil and startQuest or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[5])
    else
      return nil
    end
  end

  ---Returns the IDs of quests that reward this item.
  ---@param id ItemId
  ---@return QuestId[]?
  function ItemFunctions.questRewards(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["questRewards"] then
      local questRewards = override[id]["questRewards"]
      return questRewards ~= _nil and questRewards or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[6])
    else
      return nil
    end
  end

  ---Returns the flags of the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.flags(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["flags"] then
      local flags = override[id]["flags"]
      return flags ~= _nil and flags or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^(%d+);"))
    else
      return nil
    end
  end

  ---Returns the food type of the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.foodType(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["foodType"] then
      local foodType = override[id]["foodType"]
      return foodType ~= _nil and foodType or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the item level.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.itemLevel(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["itemLevel"] then
      local itemLevel = override[id]["itemLevel"]
      return itemLevel ~= _nil and itemLevel or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the required level to equip/use the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.requiredLevel(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["requiredLevel"] then
      local requiredLevel = override[id]["requiredLevel"]
      return requiredLevel ~= _nil and requiredLevel or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the ammo type of the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.ammoType(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["ammoType"] then
      local ammoType = override[id]["ammoType"]
      return ammoType ~= _nil and ammoType or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;%d+;(%d+)"))
    else
      -- We return 0 here because it's the default value for ammoType
      return 0
    end
  end

  ---Returns the class of the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.class(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["class"] then
      local class = override[id]["class"]
      return class ~= _nil and class or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the subclass of the item.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.subClass(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["subClass"] then
      local subClass = override[id]["subClass"]
      return subClass ~= _nil and subClass or nil
    end
    local data = glob[id]
    if data[7] then
      --! This is slower than a raw value
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the IDs of NPCs that sell this item.
  ---@param id ItemId
  ---@return NpcId[]?
  function ItemFunctions.vendors(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["vendors"] then
      local vendors = override[id]["vendors"]
      return vendors ~= _nil and vendors or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[8])
    else
      return nil
    end
  end

  ---Returns the IDs of quests that are related to this item.
  ---@param id ItemId
  ---@return QuestId[]?
  function ItemFunctions.relatedQuests(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["relatedQuests"] then
      local relatedQuests = override[id]["relatedQuests"]
      return relatedQuests ~= _nil and relatedQuests or nil
    end
    local data = glob[id]
    if data then
      return getTable(data[9])
    else
      return nil
    end
  end

  ---Returns the ID of the spell taught by this item upon use.
  ---@param id ItemId
  ---@return number?
  function ItemFunctions.teachesSpell(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["teachesSpell"] then
      local teachesSpell = override[id]["teachesSpell"]
      return teachesSpell ~= _nil and teachesSpell or nil
    end
    local data = glob[id]
    if data then
      return getNumber(data[10])
    else
      return nil
    end
  end
  exportFunctions()
end

