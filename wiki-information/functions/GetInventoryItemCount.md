## Title: GetInventoryItemCount

**Content:**
Determine the quantity of an item in an inventory slot.
`count = GetInventoryItemCount(unit, invSlotId)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit whose inventory is to be queried.
- `invSlotId`
  - *number* : InventorySlotId - to be queried, obtained via `GetInventorySlotInfo`.

**Returns:**
- `count`
  - *number* - Returns 1 on empty slots (Thus, on empty ammo slot, 1 is returned). For containers (Bags, etc.), this returns the number of items stored inside the container (Thus, empty containers return 0). Under all other conditions, this function returns the amount of items in the specified slot.

**Usage:**
```lua
local ammoSlot = GetInventorySlotInfo("AmmoSlot");
local ammoCount = GetInventoryItemCount("player", ammoSlot);
if ((ammoCount == 1) and (not GetInventoryItemTexture("player", ammoSlot))) then
  ammoCount = 0;
end;
```

**Example Use Case:**
This function can be used to check the amount of ammunition a player has left in their ammo slot. This is particularly useful for classes that rely on ammunition, such as Hunters in earlier expansions of World of Warcraft.

**Addon Usage:**
Large addons like WeakAuras might use this function to create custom alerts or notifications for players when their ammunition is running low. This helps players to manage their inventory more effectively during gameplay.