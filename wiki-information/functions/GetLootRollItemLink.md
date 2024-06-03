## Title: GetLootRollItemLink

**Content:**
Retrieves the itemLink of an item being rolled on.
`itemLink = GetLootRollItemLink(id)`

**Parameters:**
- `id`
  - *number* - id is a number used by the server to keep track of items being rolled on. It is generated server side and transmitted to the client.

**Returns:**
- `itemLink`
  - *itemLink*

**Example Usage:**
This function can be used in an addon to display the item link of an item currently being rolled on in a loot roll frame. For instance, an addon could use this to show detailed information about the item to help players decide whether to roll Need, Greed, or Pass.

**Addons Using This Function:**
Many loot management addons, such as "LootRollManager" or "XLoot", use this function to enhance the default loot roll interface by providing additional item information and customization options.