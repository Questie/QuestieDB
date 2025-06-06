---@class LibQuestieDB
local LibQuestieDB = select(2, ...)

--- Imports
local DumpFunctions = LibQuestieDB.Corrections.DumpFunctions

---@class ItemMeta
local ItemMeta = {}

-- Add ItemMeta to Meta namespace
---@class Meta
local Meta = LibQuestieDB.Meta
Meta.ItemMeta = ItemMeta

---@class ItemDBKeys @ Contains name of data as keys and their index as value
ItemMeta.itemKeys = {
  ['name'] = 1,           -- string
  ['npcDrops'] = 2,       -- table or nil, NPC IDs
  ['objectDrops'] = 3,    -- table or nil, object IDs
  ['itemDrops'] = 4,      -- table or nil, item IDs
  ['startQuest'] = 5,     -- int or nil, ID of the quest started by this item
  ['questRewards'] = 6,   -- table or nil, quest IDs
  ['flags'] = 7,          -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
  ['foodType'] = 8,       -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
  ['itemLevel'] = 9,      -- int, the level of this item
  ['requiredLevel'] = 10, -- int, the level required to equip/use this item
  ['ammoType'] = 11,      -- int,
  ['class'] = 12,         -- int,
  ['subClass'] = 13,      -- int,
  ['vendors'] = 14,       -- table or nil, NPC IDs
  ['relatedQuests'] = 15, -- table or nil, IDs of quests that are related to this item
  ['teachesSpell'] = 16,  -- int, spellID taught by this item upon use
}

--- Contains the name of data as keys and their index as value for quick lookup
ItemMeta.NameIndexLookupTable = {}
for key, index in pairs(ItemMeta.itemKeys) do
  ItemMeta.NameIndexLookupTable[index] = key
  ItemMeta.NameIndexLookupTable[key] = index
end

-- Contains the type of data as keys and their index as value
ItemMeta.itemTypes = {
  ['name'] = "string",
  ['npcDrops'] = "table",
  ['objectDrops'] = "table",
  ['itemDrops'] = "table",
  ['startQuest'] = "number",
  ['questRewards'] = "table",
  ['flags'] = "number",
  ['foodType'] = "number",
  ['itemLevel'] = "number",
  ['requiredLevel'] = "number",
  ['ammoType'] = "number",
  ['class'] = "number",
  ['subClass'] = "number",
  ['vendors'] = "table",
  ['relatedQuests'] = "table",
  ['teachesSpell'] = "number",
}
-- Add the index keys to itemTypes
for key, index in pairs(ItemMeta.itemKeys) do
  ItemMeta.itemTypes[index] = ItemMeta.itemTypes[key]
end

-- See end of ItemMeta.lua to see all the itemClasses
---@enum ItemClass
ItemMeta.itemClasses = {
  QUEST = 12,
}

ItemMeta.dumpFuncs = {
  ['name'] = DumpFunctions.dump,
  ['npcDrops'] = DumpFunctions.dumpAsArraySorted,
  ['objectDrops'] = DumpFunctions.dumpAsArraySorted,
  ['itemDrops'] = DumpFunctions.dumpAsArraySorted,
  ['startQuest'] = DumpFunctions.dump,
  ['questRewards'] = DumpFunctions.dumpAsArraySorted,
  ['flags'] = DumpFunctions.dump,
  ['foodType'] = DumpFunctions.dump,
  ['itemLevel'] = DumpFunctions.dump,
  ['requiredLevel'] = DumpFunctions.dump,
  ['ammoType'] = DumpFunctions.dump,
  ['class'] = DumpFunctions.dump,
  ['subClass'] = DumpFunctions.dump,
  ['vendors'] = DumpFunctions.dumpAsArraySorted,
  ['relatedQuests'] = DumpFunctions.dumpAsArraySorted,
  ['teachesSpell'] = DumpFunctions.dump,
}

-- Localize these variables to clean up the code
do
  -- This combines the values that are going to be converted into a string
  -- The lowest index is the one that will be replaced with the combined string
  local combineValues = {
    [7] = 'flags',
    [8] = 'foodType',
    [9] = 'itemLevel',
    [10] = 'requiredLevel',
    [11] = 'ammoType',
    [12] = 'class',
    [13] = 'subClass',
  }

  -- Combine all values into one string 0;0;0;0;;
  -- where numbers become 0 if they are nil and strings become empty such as 0;<string>;0
  ---@param tbl table<number, any> @ Table that will be modified
  ---@return table<number, any> @ Returns the table inputted with the combined value
  ---@return string @ Returns the combined value string that was inserted into the table
  function ItemMeta.combine(tbl)
    return DumpFunctions.combine(tbl, combineValues, ItemMeta.itemTypes)
  end

  -- Check if combineValues is empty or not
  if next(combineValues) == nil then
    -- If combineValues is empty, set the combine function to nil
    ItemMeta.combine = nil
  end
end

-- item class/subClass combinations
--class subClass
-- 0         0     Consumable
-- 1         0     Container, Bag
-- 1         1     Container, Soul bag
-- 1         2     Container, Herb bag
-- 1         3     Container, Enchanting bag
-- 1         4     Container, Engineering bag
-- 2         0     Weapon, Axe 1H
-- 2         1     Weapon, Axe 2H
-- 2         2     Weapon, Bow
-- 2         3     Weapon, Gun
-- 2         4     Weapon, Mace 1H
-- 2         5     Weapon, Mace 2H
-- 2         6     Weapon, Polearm
-- 2         7     Weapon, Sword 1H
-- 2         8     Weapon, Sword 2H
-- 2         9     Weapon, Obsolete
-- 2         10    Weapon, Staff
-- 2         11    Weapon, Exotic
-- 2         12    Weapon, Exotic
-- 2         13    Weapon, Fist
-- 2         14    Weapon, Miscellaneous
-- 2         15    Weapon, Dagger
-- 2         16    Weapon, Thrown
-- 2         17    Weapon, Spear
-- 2         18    Weapon, Crossbow
-- 2         19    Weapon, Wand
-- 2         20    Weapon, Fishing Pole
-- 4         0     Armor, Miscellaneous
-- 4         1     Armor, Cloth
-- 4         2     Armor, Leather
-- 4         3     Armor, Mail
-- 4         4     Armor, Plate
-- 4         5     Armor, Buckler(OBSOLETE)
-- 4         6     Armor, Shield
-- 4         7     Armor, Libram
-- 4         8     Armor, Idol
-- 4         9     Armor, Totem
-- 5         0     Reagent
-- 6         0     Projectile, Wand(OBSOLETE)
-- 6         1     Projectile, Bolt(OBSOLETE)
-- 6         2     Projectile, Arrow
-- 6         3     Projectile, Bullet
-- 6         4     Projectile, Thrown(OBSOLETE)
-- 7         0     Trade Goods
-- 9         0     Recipe, Book
-- 9         1     Recipe, Leatherworking
-- 9         2     Recipe, Tailoring
-- 9         3     Recipe, Engineering
-- 9         4     Recipe, Blacksmithing
-- 9         5     Recipe, Cooking
-- 9         6     Recipe, Alchemy
-- 9         7     Recipe, First Aid
-- 9         8     Recipe, Enchanting
-- 9         9     Recipe, Fishing
-- 11        0     Quiver, Quiver(OBSOLETE)
-- 11        1     Quiver, Quiver(OBSOLETE)
-- 11        2     Quiver, Quiver
-- 11        3     Quiver, Ammo Pouch
-- 12        0     Quest
-- 13        0     Key, Key
-- 13        1     Key, Lockpick
-- 14        0     Permanent, Permanent
-- 15        0     Junk, Junk
-- 16        0     Glyph, Warrior
-- 16        1     Glyph, Paladin
-- 16        2     Glyph, Hunter
-- 16        3     Glyph, Rogue
-- 16        4     Glyph, Priest
-- 16        5     Glyph, Death Knight
-- 16        6     Glyph, Shaman
-- 16        7     Glyph, Mage
-- 16        8     Glyph, Warlock
-- 16        9     Glyph, Druid
