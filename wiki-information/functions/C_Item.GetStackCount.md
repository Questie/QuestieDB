## Title: C_Item.GetStackCount

**Content:**
Needs summary.
`stackCount = C_Item.GetStackCount(itemLocation)`

**Parameters:**
- `itemLocation`
  - *ItemLocationMixin*

**Returns:**
- `stackCount`
  - *number*

**Example Usage:**
This function can be used to determine the number of items in a specific item location, such as a bag slot or bank slot. For instance, if you want to check how many potions you have in a specific bag slot, you can use this function to get that count.

**Addon Usage:**
Large addons like Bagnon, which manage and display inventory, might use this function to display the stack count of items in the player's bags and bank. This helps in providing a clear and concise view of the player's inventory.