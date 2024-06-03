## Title: GetInventoryItemID

**Content:**
Returns the item ID for an equipped item.
`itemId, unknown = GetInventoryItemID(unit, invSlotId)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit whose inventory is to be queried.
- `invSlotId`
  - *number* : InventorySlotId - to be queried, obtained via `GetInventorySlotInfo`.

**Returns:**
- `itemId`
  - *number* - item id of the item in the inventory slot; nil if there is no item.
- `unknown`
  - *number* - ?

**Example Usage:**
```lua
local unit = "player"
local invSlotId = GetInventorySlotInfo("HeadSlot")
local itemId = GetInventoryItemID(unit, invSlotId)
print("Item ID in Head Slot: ", itemId)
```

**Common Usage in Addons:**
- **WeakAuras**: This function is often used to check if a player has a specific item equipped, which can then trigger custom visual or audio alerts.
- **Pawn**: Utilizes this function to compare currently equipped items with potential upgrades, helping players make better gear choices.