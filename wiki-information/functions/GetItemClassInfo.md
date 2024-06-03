## Title: GetItemClassInfo

**Content:**
Returns the name of the item type.
`name = GetItemClassInfo(classID)`

**Parameters:**
- `classID`
  - *number* - ID of the ItemType

**Returns:**
- `name`
  - *string* - Name of the item type

**Usage:**
```lua
for i = 0, Enum.ItemClassMeta.NumValues-1 do
    print(i, GetItemClassInfo(i))
end
-- Output:
-- 0, Consumable
-- 1, Container
-- 2, Weapon
-- ...
```

**Reference:**
- `GetItemSubClassInfo`
- `GetItemInfo`