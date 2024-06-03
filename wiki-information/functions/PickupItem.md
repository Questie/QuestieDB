## Title: PickupItem

**Content:**
Place the item on the cursor.
`PickupItem(itemID or itemString or itemName or itemLink)`

**Parameters:**
- `(itemId or "itemString" or "itemName" or "itemLink")`
  - `itemId`
    - *number* - The numeric ID of the item. i.e., 12345
  - `itemString`
    - *string* - The full item ID in string format, e.g., `"item:12345:0:0:0:0:0:0:0"`. Also supports partial itemStrings, by filling up any missing `:x` value with `:0`, e.g., `"item:12345:0:0:0"`
  - `itemName`
    - *string* - The Name of the Item, e.g., `"Hearthstone"`. The item must have been equipped, in your bags, or in your bank once in this session for this to work.
  - `itemLink`
    - *string* - The itemLink, when Shift-Clicking items.

**Usage:**
```lua
PickupItem(6948)
PickupItem("item:6948")
PickupItem("Hearthstone")
PickupItem(GetContainerItemLink(0, 1))
```
Common usage:
```lua
PickupItem(link)
```

**Miscellaneous:**
Result:
Picks up the Hearthstone. The 4th example picks up the item in backpack slot 1.