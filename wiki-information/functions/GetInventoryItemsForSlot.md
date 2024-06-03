## Title: GetInventoryItemsForSlot

**Content:**
Returns a list of items that can be equipped in a given inventory slot.
`returnTable = GetInventoryItemsForSlot(slot, returnTable)`

**Parameters:**
- `slot`
  - *number* : InvSlotId - The inventory slot ID.
- `returnTable`
  - *table* - The table that will be populated with available items.
- `transmogrify`
  - *boolean?*

**Returns:**
- `returnTable`
  - *table* - A key-value table ItemLocation bitfield -> ItemLink.

**Usage:**
Prints all items that can go in the main hand slot, one is currently equipped, the other is in the backpack.
```lua
/dump GetInventoryItemsForSlot(INVSLOT_MAINHAND, {})
-- Output:
-- {
--   [bitfield1] = "ItemLink1",
--   [bitfield2] = "ItemLink2"
-- }
```

Prints the information in a more user-readable state.
```lua
local locations = {
    "player",
    "bank",
    "bags",
    "voidStorage",
    "slot",
    "bag",
    "tab",
    "voidSlot",
}

function PrintInventoryItemsForSlot(slot)
    local items = GetInventoryItemsForSlot(slot, {})
    for bitfield, link in pairs(items) do
        print(link, string.format("0x%X", bitfield))
        local locs = {EquipmentManager_UnpackLocation(bitfield)}
        local t = {}
        for k, v in pairs(locs) do
            t[k] = v or nil
        end
        DevTools_Dump(t)
    end
end

-- /run PrintInventoryItemsForSlot(INVSLOT_MAINHAND)
-- Example Output:
-- "ItemLink1", 0x100010
--   player=true,
--   slot=16
-- "ItemLink2", 0x30000A
--   player=true,
--   bags=true,
--   bag=0,
--   slot=10
```

**Example Use Case:**
This function can be used to list all items that can be equipped in a specific slot, which is useful for creating custom equipment managers or transmogrification tools.

**Addon Usage:**
Large addons like "Pawn" and "ItemRack" use this function to determine which items can be equipped in specific slots, helping players optimize their gear and manage equipment sets efficiently.