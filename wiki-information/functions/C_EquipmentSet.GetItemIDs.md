## Title: C_EquipmentSet.GetItemIDs

**Content:**
Returns the item IDs of an equipment set.
`itemIDs = C_EquipmentSet.GetItemIDs(equipmentSetID)`

**Parameters:**
- `equipmentSetID`
  - *number* - Appears to return valid info for indices

**Returns:**
- `itemIDs`
  - *table* - a table of numbers indexed by InventorySlotId

**Usage:**
To print all items that are part of the first set:
```lua
local items = C_EquipmentSet.GetItemIDs(0)
for i = 1, 19 do
    if items then
        print(i, (GetItemInfo(items[i])))
    end
end
```

**Example Use Case:**
This function can be used to retrieve and display the item IDs of all items in a specific equipment set. This is particularly useful for addons that manage or display equipment sets, such as those that help players quickly switch between different gear configurations for different activities (e.g., PvP, PvE, or specific roles like tanking or healing).

**Addons Using This Function:**
- **Outfitter**: A popular addon that allows players to create, manage, and switch between different equipment sets. It uses this function to retrieve the item IDs for the sets it manages.
- **ItemRack**: Another addon for managing equipment sets, which uses this function to display and switch between different sets of gear.