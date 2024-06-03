## Title: GetLootSlotInfo

**Content:**
Returns info for a loot slot.
`lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(slot)`

**Parameters:**
- `slot`
  - *number* - the index of the loot (1 is the first item, typically coin)

**Returns:**
- `lootIcon`
  - *string* - The path of the graphical icon for the item.
- `lootName`
  - *string* - The name of the item.
- `lootQuantity`
  - *number* - The quantity of the item in a stack. Note: Quantity for coin is always 0.
- `currencyID`
  - *number* - The identifying number of the currency loot in slot, if applicable. Note: Returns nil for slots with coin and regular items.
- `lootQuality`
  - *number* - The Enum.ItemQuality code for the item.
- `locked`
  - *boolean* - Whether you are eligible to loot this item or not. Locked items are by default shown tinted red.
- `isQuestItem`
  - *boolean* - Self-explanatory.
- `questID`
  - *number* - The identifying number for the quest.
- `isActive`
  - *boolean* - True if the item starts a quest that you are not currently on.

**Description:**
When returning coin data, the 'quantity' is always 0 and the 'item' contains the amount and text. It also includes a line break after each type of coin. The linebreak can be removed by string substitution.
`print("coins: "..string.gsub(item,"\\n"," "))`

**Reference:**
- `GetLootSourceInfo`
- `GetLootSlotLink`
- `GetLootSlotType`