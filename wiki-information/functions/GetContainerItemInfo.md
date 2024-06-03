## Title: GetContainerItemInfo

**Content:**
Returns info for an item in a container slot.
`icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagID, slot)`

**Parameters:**
- `bagID`
  - *number* - BagID of the bag the item is in, e.g. 0 for your backpack.
- `slot`
  - *number* - index of the slot inside the bag to look up.

**Returns:**
1. `texture`
   - *number* - The icon texture (FileID) for the item in the specified bag slot.
2. `itemCount`
   - *number* - The number of items in the specified bag slot.
3. `locked`
   - *boolean* - True if the item is locked by the server, false otherwise.
4. `quality`
   - *number* - The Quality of the item.
5. `readable`
   - *boolean* - True if the item can be "read" (as in a book), false otherwise.
6. `lootable`
   - *boolean* - True if the item is a temporary container containing items that can be looted, false otherwise.
7. `itemLink`
   - *string* - The itemLink of the item in the specified bag slot.
8. `isFiltered`
   - *boolean* - True if the item is grayed-out during the current inventory search, false otherwise.
9. `noValue`
   - *boolean* - True if the item has no gold value, false otherwise.
10. `itemID`
    - *number* - The unique ID for the item in the specified bag slot.
11. `isBound`
    - *boolean* - True if the item is bound to the current character, false otherwise.

**Reference:**
- `GetItemInfo`
- `GetItemInfoInstant`

**Example Usage:**
This function can be used to retrieve detailed information about items in a player's inventory, which is useful for inventory management addons. For example, an addon could use this function to display item counts, quality, and other attributes in a custom inventory UI.

**Addons Using This Function:**
- **Bagnon**: A popular inventory management addon that consolidates all bags into a single window. It uses `GetContainerItemInfo` to display item details and manage inventory efficiently.
- **ArkInventory**: Another comprehensive inventory addon that allows for highly customizable bag layouts and item sorting. It relies on `GetContainerItemInfo` to fetch item data for its various features.