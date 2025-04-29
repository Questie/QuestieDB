---@class LibQuestieDB
---@field Item Item
local LibQuestieDB = select(2, ...)

local Corrections = LibQuestieDB.Corrections
local l10n = LibQuestieDB.l10n

---@class (exact) Item:DatabaseType
---@class (exact) Item:ItemFunctions
local Item = LibQuestieDB.CreateDatabaseInTable(LibQuestieDB.Item, "Item", Corrections.ItemMeta.itemKeys)
GItem = Item

do
  -- Class for all the GET functions for the Item namespace
  ---@class ItemFunctions
  local ItemFunctions = {}

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

  -- ? If we have debug enabled always use l10n, but otherwise don't for performance reasons as most users will be using enUS
  if l10n.currentLocale == "enUS" then
    ---Returns the name of the item.
    ---@type fun(id: ItemId):Name?
    ItemFunctions.name = Item.AddStringGetter(1, "name")
  else
    local fallbackName = Item.AddStringGetter(1, "name")
    ItemFunctions.name = function(id)
      ---@diagnostic disable-next-line: return-type-mismatch
      return l10n.itemName(id) or fallbackName(id)
    end
  end

  ---Returns the IDs of NPCs that drop this item.
  ---@type fun(id: ItemId):NpcId[]?
  ItemFunctions.npcDrops = Item.AddTableGetter(2, "npcDrops")

  ---Returns the IDs of objects that drop this item.
  ---@type fun(id: ItemId):ObjectId[]?
  ItemFunctions.objectDrops = Item.AddTableGetter(3, "objectDrops")

  ---Returns the IDs of items that drop this item.
  ---@type fun(id: ItemId):ItemId[]?
  ItemFunctions.itemDrops = Item.AddTableGetter(4, "itemDrops")

  ---Returns the ID of the quest started by this item.
  ---@type fun(id: ItemId):QuestId?
  ItemFunctions.startQuest = Item.AddNumberGetter(5, "startQuest", 0)

  ---Returns the IDs of quests that reward this item.
  ---@type fun(id: ItemId):QuestId[]?
  ItemFunctions.questRewards = Item.AddTableGetter(6, "questRewards")

  ---Returns the flags of the item.
  ---@type fun(id: ItemId):number?
  ItemFunctions.flags = Item.AddPatternGetter(7, "flags", "^(%d+);", nil, tonumber)

  ---Returns the food type of the item.
  ---@type fun(id: ItemId):number?
  ItemFunctions.foodType = Item.AddPatternGetter(7, "foodType", "^%d+;(%d+);", nil, tonumber)

  ---Returns the item level.
  ---@type fun(id: ItemId):number?
  ItemFunctions.itemLevel = Item.AddPatternGetter(7, "itemLevel", "^%d+;%d+;(%d+);", nil, tonumber)

  ---Returns the required level to equip/use the item.
  ---@type fun(id: ItemId):number?
  ItemFunctions.requiredLevel = Item.AddPatternGetter(7, "requiredLevel", "^%d+;%d+;%d+;(%d+);", nil, tonumber)

  ---Returns the ammo type of the item.
  ---@type fun(id: ItemId):number?
  ItemFunctions.ammoType = Item.AddPatternGetter(7, "ammoType", "^%d+;%d+;%d+;%d+;(%d+)", 0, tonumber)

  ---Returns the class of the item.
  ---@type fun(id: ItemId):number?
  ItemFunctions.class = Item.AddPatternGetter(7, "class", "^%d+;%d+;%d+;%d+;%d+;(%d+)", nil, tonumber)

  ---Returns the subclass of the item
  ---@type fun(id: ItemId):number?
  ItemFunctions.subClass = Item.AddPatternGetter(7, "subClass", "^%d+;%d+;%d+;%d+;%d+;%d+;(%d+)", nil, tonumber)

  ---Returns the IDs of NPCs that sell this item.
  ---@type fun(id: ItemId):NpcId[]?
  ItemFunctions.vendors = Item.AddTableGetter(8, "vendors")

  ---Returns the IDs of quests that are related to this item.
  ---@type fun(id: ItemId):QuestId[]?
  ItemFunctions.relatedQuests = Item.AddTableGetter(9, "relatedQuests")

  ---Returns the ID of the spell taught by this item upon use.
  ---@type fun(id: ItemId):number?
  ItemFunctions.teachesSpell = Item.AddNumberGetter(10, "teachesSpell", 0)

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
    publicItem.GetAllIds = Item.GetAllIds
  end

  exportFunctions()
end
