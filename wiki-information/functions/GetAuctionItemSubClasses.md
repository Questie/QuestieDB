## Title: GetAuctionItemSubClasses

**Content:**
Gets a list of the sub-classes for an Auction House item class.
`subClass1, subClass2, subClass3, ... = GetAuctionItemSubClasses(classID)`

**Parameters:**
- `classID`
  - *number* - ID of the item class.

**Returns:**
- `subClass1, subClass2, subClass3, ...`
  - *number* - The valid subclasses for an item class.

**Usage:**
Prints all subclass IDs for the Consumables category.
```lua
local classID = LE_ITEM_CLASS_CONSUMABLE
for _, subClassID in pairs({GetAuctionItemSubClasses(classID)}) do
    print(subClassID, (GetItemSubClassInfo(classID, subClassID)))
end
```
Output:
```
0, Explosives and Devices
1, Potion
2, Elixir
3, Flask
5, Food & Drink
7, Bandage
9, Vantus Runes
8, Other
```

**Reference:**
- ItemType - List of item (sub)classes
- GetItemClassInfo
- GetItemSubClassInfo
- GetAuctionItemClasses (removed)