## Title: C_Item.GetItemMaxStackSizeByID

**Content:**
Needs summary.
`stackSize = C_Item.GetItemMaxStackSizeByID(itemInfo)`

**Parameters:**
- `itemInfo`
  - *string*

**Returns:**
- `stackSize`
  - *number?*

**Example Usage:**
This function can be used to determine the maximum stack size of an item in World of Warcraft. For instance, if you want to know how many potions you can stack in one inventory slot, you can use this function to get that information.

**Addon Usage:**
Large addons like Auctioneer may use this function to determine how many items can be listed in a single auction stack, optimizing the auction creation process for users.