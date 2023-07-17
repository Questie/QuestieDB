Item = {}

local glob = {}

function Item.Initialize(dataGlob)
  glob = dataGlob
  print("Loaded Item Data")
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
  --   1.  ['flags']          -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
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
    local data = glob[id]
    if data then
      return data[1]:GetText()
    else
      return nil
    end
  end

  ---Returns the IDs of NPCs that drop this item.
  ---@param id ItemId
  ---@return NpcId[]?
  function Item.npcDrops(id)
    local data = glob[id]
    if data then
      return getTable(data[2])
    else
      return nil
    end
  end

  --- Please continue here:

  ---Returns the IDs of objects that drop this item.
  ---@param id ItemId
  ---@return ObjectId[]?
  function Item.objectDrops(id)
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
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^(%d+);"))
    else
      return nil
    end
  end

  ---Returns the food type of the item.
  ---@param id ItemId
  ---@return number?
  function Item.foodType(id)
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the item level.
  ---@param id ItemId
  ---@return number?
  function Item.itemLevel(id)
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^%d+;%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the required level to equip/use the item.
  ---@param id ItemId
  ---@return number?
  function Item.requiredLevel(id)
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;(%d+);"))
    else
      return nil
    end
  end

  ---Returns the ammo type of the item.
  ---@param id ItemId
  ---@return number?
  function Item.ammoType(id)
    local data = glob[id]
    if data[7] then
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
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the subclass of the item.
  ---@param id ItemId
  ---@return number?
  function Item.subClass(id)
    local data = glob[id]
    if data[7] then
      return tonumber(data[7]:GetText():match("^%d+;%d+;%d+;%d+;%d+;%d+;(%d+)"))
    else
      return nil
    end
  end

  ---Returns the IDs of NPCs that sell this item.
  ---@param id ItemId
  ---@return NpcId[]?
  function Item.vendors(id)
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
    local data = glob[id]
    if data then
      return getTable(data[9])
    else
      return nil
    end
  end
end

Item.testItemGetFunctions = function()
  for id in pairs(glob) do
    print("Testing Item " .. id)
    local data = {}

    -- Test Item.name
    table.insert(data, "Name: " .. (Item.name(id) or "nil"))

    -- Test Item.npcDrops
    local npcDrops = Item.npcDrops(id)
    if npcDrops then
      table.insert(data, "NPC Drops:")
      for _, npcID in ipairs(npcDrops) do
        table.insert(data, "  NPC ID: " .. npcID)
      end
    else
      table.insert(data, "NPC Drops: nil")
    end

    -- Test Item.objectDrops
    local objectDrops = Item.objectDrops(id)
    if objectDrops then
      table.insert(data, "Object Drops:")
      for _, objectID in ipairs(objectDrops) do
        table.insert(data, "  Object ID: " .. objectID)
      end
    else
      table.insert(data, "Object Drops: nil")
    end

    -- Test Item.itemDrops
    local itemDrops = Item.itemDrops(id)
    if itemDrops then
      table.insert(data, "Item Drops:")
      for _, itemID in ipairs(itemDrops) do
        table.insert(data, "  Item ID: " .. itemID)
      end
    else
      table.insert(data, "Item Drops: nil")
    end

    -- Test Item.startQuest
    table.insert(data, "Start Quest: " .. (Item.startQuest(id) or "nil"))

    -- Test Item.questRewards
    local questRewards = Item.questRewards(id)
    if questRewards then
      table.insert(data, "Quest Rewards:")
      for _, questID in ipairs(questRewards) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Quest Rewards: nil")
    end

    -- Test Item.flags
    table.insert(data, "Flags: " .. (Item.flags(id) or "nil"))

    -- Test Item.foodType
    table.insert(data, "Food Type: " .. (Item.foodType(id) or "nil"))

    -- Test Item.itemLevel
    table.insert(data, "Item Level: " .. (Item.itemLevel(id) or "nil"))

    -- Test Item.requiredLevel
    table.insert(data, "Required Level: " .. (Item.requiredLevel(id) or "nil"))

    -- Test Item.ammoType
    table.insert(data, "Ammo Type: " .. (Item.ammoType(id) or "nil"))

    -- Test Item.class
    table.insert(data, "Class: " .. (Item.class(id) or "nil"))

    -- Test Item.subClass
    table.insert(data, "Subclass: " .. (Item.subClass(id) or "nil"))

    -- Test Item.vendors
    local vendors = Item.vendors(id)
    if vendors then
      table.insert(data, "Vendors:")
      for _, npcID in ipairs(vendors) do
        table.insert(data, "  NPC ID: " .. npcID)
      end
    else
      table.insert(data, "Vendors: nil")
    end

    -- Test Item.relatedQuests
    local relatedQuests = Item.relatedQuests(id)
    if relatedQuests then
      table.insert(data, "Related Quests:")
      for _, questID in ipairs(relatedQuests) do
        table.insert(data, "  Quest ID: " .. questID)
      end
    else
      table.insert(data, "Related Quests: nil")
    end

    table.insert(data, "--------------------------------------------------")
    print(table.concat(data, "\n"))
  end
  print("Item Test Done")
end
