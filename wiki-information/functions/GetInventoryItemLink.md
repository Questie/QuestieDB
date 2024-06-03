## Title: GetInventoryItemLink

**Content:**
Returns the item link for an equipped item.
`itemLink = GetInventoryItemLink(unit, invSlotId)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit whose inventory is to be queried.
- `invSlotId`
  - *number* : InventorySlotId - The inventory slot to be queried.

**Returns:**
- `itemLink`
  - *string?* : ItemLink - The item link for the specified item.

**Usage:**
```lua
local mainHandLink = GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot"))
local _, _, _, _, _, _, itemType = GetItemInfo(mainHandLink)
DEFAULT_CHAT_FRAME:AddMessage(itemType)
```
**Result:**
Prints the subtype of the mainhand weapon - for example "Mace" or "Sword".