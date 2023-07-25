Item = {}

local glob = {}
local override = {}

local tonumber = tonumber

function Item.Initialize(dataGlob, dataOverride, overrideKeys)
  glob = dataGlob
  Item.glob = glob
  Item.override = override
  Database.Override(dataOverride, override, overrideKeys)
end

do
  if not Database then
    error("Database not loaded")
  end
  local getNumber = Database.getNumber
  local getTable = Database.getTable

  -- itemKeysOriginal = {
  --   ['name'] = 1,           -- string
  --   ['npcDrops'] = 2,       -- table or nil, NPC IDs
  --   ['objectDrops'] = 3,    -- table or nil, object IDs
  --   ['itemDrops'] = 4,      -- table or nil, item IDs
  --   ['startQuest'] = 5,     -- int or nil, ID of the quest started by this item
  --   ['questRewards'] = 6,   -- table or nil, quest IDs
  --   ['flags'] = 7,          -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
  --   ['foodType'] = 8,       -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
  --   ['itemLevel'] = 9,      -- int, the level of this item
  --   ['requiredLevel'] = 10, -- int, the level required to equip/use this item
  --   ['ammoType'] = 11,      -- int,
  --   ['class'] = 12,         -- int,
  --   ['subClass'] = 13,      -- int,
  --   ['vendors'] = 14,       -- table or nil, NPC IDs
  --   ['relatedQuests'] = 15, -- table or nil, IDs of quests that are related to this item
  -- }

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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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
    if override[id] then
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

