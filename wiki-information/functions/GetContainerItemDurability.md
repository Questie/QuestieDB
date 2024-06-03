## Title: GetContainerItemDurability

**Content:**
Returns the durability of an item in a container slot.
`current, maximum = GetContainerItemDurability(bag, slot)`

**Parameters:**
- `bag`
  - *number* - Index of the bag slot the bag storing the item is in.
- `slot`
  - *number* - Index of the bag slot containing the item to query durability of.

**Returns:**
- `current`
  - *number* - current durability value.
- `maximum`
  - *number* - maximum durability value.

**Reference:**
- `GetInventoryItemDurability`

**Example Usage:**
This function can be used to check the durability of items in a player's inventory, which is useful for addons that manage equipment or provide alerts when items are close to breaking.

**Addon Usage:**
Large addons like "ElvUI" and "WeakAuras" may use this function to display durability information on the user interface, helping players keep track of their gear's condition.