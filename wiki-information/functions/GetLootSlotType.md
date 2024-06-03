## Title: GetLootSlotType

**Content:**
Returns an integer loot type for a given loot slot.
`slotType = GetLootSlotType(slotIndex)`

**Parameters:**
- `slotIndex`
  - *number* - Position in loot window to query, from 1 - `GetNumLootItems()`.

**Returns:**
- `slotType`
  - *number* - Type ID indicating slot content type:
    - `0`: `LOOT_SLOT_NONE` / `Enum.LootSlotType.None` - No contents
    - `1`: `LOOT_SLOT_ITEM` / `Enum.LootSlotType.Item` - A regular item
    - `2`: `LOOT_SLOT_MONEY` / `Enum.LootSlotType.Money` - Gold/silver/copper coin
    - `3`: `LOOT_SLOT_CURRENCY` / `Enum.LootSlotType.Currency` - Other currency amount, such as 

As of 10.0.0.46455 the constants `LOOT_SLOT_NONE`, `LOOT_SLOT_ITEM`, `LOOT_SLOT_MONEY`, `LOOT_SLOT_CURRENCY` are no longer defined. A new enumerator table is defined (`Enum.LootSlotType`) with the same values.

**Usage:**
The following snippet takes all items from the open loot window, leaving other loot types:
```lua
for slot = 1, GetNumLootItems() do
  if GetLootSlotType(slot) == Enum.LootSlotType.Item then
    LootSlot(slot);
  end
end
```

**Reference:**
- `GetNumLootItems`
- `LootSlot`
- `LOOT_OPENED`