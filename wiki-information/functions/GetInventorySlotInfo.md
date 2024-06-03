## Title: GetInventorySlotInfo

**Content:**
Returns info for an equipment slot.
`invSlotId, textureName, checkRelic = GetInventorySlotInfo(invSlotName)`

**Parameters:**
- `invSlotName`
  - *string* - InventorySlotName to query (e.g. "HEADSLOT").

**Returns:**
- `invSlotId`
  - *number* - The ID to use to refer to that slot in the other GetInventory functions.
- `textureName`
  - *string* - The texture to use for the empty slot on the paper doll display.
- `checkRelic`
  - *boolean*

**Example Usage:**
```lua
local invSlotId, textureName, checkRelic = GetInventorySlotInfo("HEADSLOT")
print("Slot ID:", invSlotId)
print("Texture Name:", textureName)
print("Check Relic:", checkRelic)
```

**Description:**
The `GetInventorySlotInfo` function is useful for addon developers who need to interact with specific equipment slots. For example, it can be used to get the slot ID for the head slot, which can then be used in other inventory-related functions to get or set items in that slot.

**Usage in Addons:**
Large addons like "ElvUI" and "WeakAuras" use this function to manage and display equipment slots. For instance, ElvUI uses it to customize the appearance of the character frame, while WeakAuras might use it to trigger alerts based on the player's equipped items.