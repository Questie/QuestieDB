## Title: CursorHasItem

**Content:**
Returns true if the cursor currently holds an item.
`hasItem = CursorHasItem()`

**Returns:**
- `hasItem`
  - *boolean* - Whether the cursor is holding an item.

**Description:**
This function returns nil if the item on the cursor was not picked up via `PickupContainerItem`, e.g. items from the guild bank (which are picked up via `PickupGuildBankItem`) or a merchant item.