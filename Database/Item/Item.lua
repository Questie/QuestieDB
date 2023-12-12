Item = {}

local glob = {}
local override = {}

local tonumber = tonumber

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
  Item.override = override
end

function Item.AddOverrideData(dataOverride, overrideKeys)
  if not glob or not override then
    error("You must initialize the Item database before adding override data")
  end
  Database.Override(dataOverride, override, overrideKeys)
end

function Item.ClearOverrideData()
  if override then
    override = wipe(override)
  end
end

---Get all item ids.
---@return ItemId[]
function Item.GetAllItemIds()
  local loadstringFunction = Database.GetAllEntityIdsFunction("Item")
  -- Replace the function with the loadstringFunction
  ---@cast loadstringFunction fun():ItemId[]
  Item.GetAllItemIds = loadstringFunction
  return loadstringFunction()
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

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

  ---Returns the item name.
  ---@param id ItemId
  ---@return Name?
  function Item.name(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["name"] then
      return override[id]["name"]
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
  function Item.npcDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["npcDrops"] then
      return override[id]["npcDrops"]
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
  function Item.objectDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["objectDrops"] then
      return override[id]["objectDrops"]
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
  function Item.itemDrops(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["itemDrops"] then
      return override[id]["itemDrops"]
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
  function Item.startQuest(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["startQuest"] then
      return override[id]["startQuest"]
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
  function Item.questRewards(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["questRewards"] then
      return override[id]["questRewards"]
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
  function Item.flags(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["flags"] then
      return override[id]["flags"]
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
  function Item.foodType(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["foodType"] then
      return override[id]["foodType"]
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
  function Item.itemLevel(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["itemLevel"] then
      return override[id]["itemLevel"]
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
  function Item.requiredLevel(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["requiredLevel"] then
      return override[id]["requiredLevel"]
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
  function Item.ammoType(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["ammoType"] then
      return override[id]["ammoType"]
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
  function Item.class(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["class"] then
      return override[id]["class"]
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
  function Item.subClass(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["subClass"] then
      return override[id]["subClass"]
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
  function Item.vendors(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["vendors"] then
      return override[id]["vendors"]
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
  function Item.relatedQuests(id)
    --? Returns the overridden value, e.g. faction specific fixes
    if override[id] and override[id]["relatedQuests"] then
      return override[id]["relatedQuests"]
    end
    local data = glob[id]
    if data then
      return getTable(data[9])
    else
      return nil
    end
  end
end

