## Title: GetItemFamily

**Content:**
Returns the bag type that an item can go into, or for bags the type of items that it can contain.
`bagType = GetItemFamily(item)`

**Parameters:**
- `item`
  - *number|string* : Item ID, Link or Name

**Returns:**
- `bagType`
  - *number* : ItemFamily - Bitfield of the type of bags an item can go into, or if the item is a container what it can contain. Will return nil for uncached items, like most item API.

**Usage:**
```lua
local itemFamilyIDs = {
    [0x1] = "Arrows",
    [0x2] = "Bullets",
    [0x4] = "Soul Shards",
    [0x8] = "Leatherworking Supplies",
    [0x10] = "Inscription Supplies",
    [0x20] = "Herbs",
    [0x40] = "Enchanting Supplies",
    [0x80] = "Engineering Supplies",
    [0x100] = "Keys",
    [0x200] = "Gems",
    [0x400] = "Mining Supplies",
    [0x800] = "Soulbound Equipment",
    [0x1000] = "Vanity Pets",
    [0x2000] = "Currency Tokens",
    [0x4000] = "Quest Items",
    [0x8000] = "Fishing Supplies",
    [0x10000] = "Cooking Supplies",
    [0x20000] = "Toys",
    [0x40000] = "Archaeology",
    [0x80000] = "Alchemy",
    [0x100000] = "Blacksmithing",
    [0x200000] = "First Aid",
    [0x400000] = "Jewelcrafting",
    [0x800000] = "Skinning",
    [0x1000000] = "Tailoring",
}
local itemFamilyFlags = {}
for k, v in pairs(itemFamilyIDs) do
    itemFamilyFlags[k] = v
end
local function PrintItemFamily(item)
    local bagType = GetItemFamily(item)
    print(format("0x%X", bagType))
    for k, v in pairs(itemFamilyFlags) do
        if bit.band(bagType, k) > 0 then
            print(format("0x%X, %s", k, v))
        end
    end
end
PrintItemFamily(22786) -- Dreaming Glory
-- 0x200020
-- 0x20, Herbs
-- 0x200000, Alchemy
PrintItemFamily(190395) -- Serevite Ore
-- 0x1400480
-- 0x80, Engineering Supplies
-- 0x400, Mining Supplies
-- 0x400000, Blacksmithing
-- 0x1000000, Jewelcrafting
PrintItemFamily(37700) -- Crystallized Air
-- 0x4004C8
-- 0x8, Leatherworking Supplies
-- 0x40, Enchanting Supplies
-- 0x80, Engineering Supplies
-- 0x400, Mining Supplies
-- 0x400000, Blacksmithing
PrintItemFamily(38347) -- Mammoth Mining Bag
-- 0x400
-- 0x400, Mining Supplies
```

**Description:**
To simply check if an item is a bag, with itemEquipLoc:
```lua
select(9, GetItemInfo(item)) == "INVTYPE_BAG"
```
Checking if an item is a specific type of bag, with item subclassID:
```lua
select(13, GetItemInfo(item)) == 4 -- Engineering Bag
```

**Reference:**
- `C_Container.GetContainerNumFreeSlots` - Returns the number of free slots & the bagType that an equipped bag or backpack belongs to.