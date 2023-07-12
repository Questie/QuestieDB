Item = {}
Item.maxId = 190307 -- This is different between expansions

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

  -- itemKeys = {
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
    if data then
      return getNumber(data[7])
    else
      return nil
    end
  end

  ---Returns the food type of the item.
  ---@param id ItemId
  ---@return number?
  function Item.foodType(id)
    local data = glob[id]
    if data then
      return getNumber(data[8])
    else
      return nil
    end
  end

  ---Returns the item level.
  ---@param id ItemId
  ---@return number?
  function Item.itemLevel(id)
    local data = glob[id]
    if data then
      return getNumber(data[9])
    else
      return nil
    end
  end

  ---Returns the required level to equip/use the item.
  ---@param id ItemId
  ---@return number?
  function Item.requiredLevel(id)
    local data = glob[id]
    if data then
      return getNumber(data[10])
    else
      return nil
    end
  end

  ---Returns the ammo type of the item.
  ---@param id ItemId
  ---@return number?
  function Item.ammoType(id)
    local data = glob[id]
    if data then
      return getNumber(data[11])
    else
      return nil
    end
  end

  ---Returns the class of the item.
  ---@param id ItemId
  ---@return number?
  function Item.class(id)
    local data = glob[id]
    if data then
      return getNumber(data[12])
    else
      return nil
    end
  end

  ---Returns the subclass of the item.
  ---@param id ItemId
  ---@return number?
  function Item.subClass(id)
    local data = glob[id]
    if data then
      return getNumber(data[13])
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
      return getTable(data[14])
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
      return getTable(data[15])
    else
      return nil
    end
  end
end