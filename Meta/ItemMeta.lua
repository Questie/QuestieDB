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
