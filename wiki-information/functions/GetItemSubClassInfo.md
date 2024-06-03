## Title: GetItemSubClassInfo

**Content:**
Returns the name of the item subtype.
`name, isArmorType = GetItemSubClassInfo(classID, subClassID)`

**Parameters:**
- `classID`
  - *number* - ID of the ItemType
- `subClassID`
  - *number* - ID of the item subtype

**Returns:**
- `name`
  - *string* - Name of the item subtype
- `isArmorType`
  - *boolean* - Seems to only return true for classID 4: Armor - subClassID 0 to 4 Miscellaneous, Cloth, Leather, Mail, Plate

**Usage:**
Prints the Herbalism subtype for the Profession itemtype.
```lua
print(GetItemSubClassInfo(Enum.ItemClass.Profession, Enum.ItemProfessionSubclass.Herbalism))
-- "Herbalism", false
```

Prints the info of all Profession subtypes.
```lua
for i = Enum.ItemProfessionSubclassMeta.MinValue, Enum.ItemProfessionSubclassMeta.MaxValue do
    print(i, GetItemSubClassInfo(Enum.ItemClass.Profession, i))
end
-- Output:
-- 0, "Blacksmithing", false
-- 1, "Leatherworking", false
-- 2, "Alchemy", false
-- 3, "Herbalism", false
-- 4, "Cooking", false
-- 5, "Mining", false
-- 6, "Tailoring", false
-- 7, "Engineering", false
-- 8, "Enchanting", false
-- 9, "Fishing", false
-- 10, "Skinning", false
-- 11, "Jewelcrafting", false
-- 12, "Inscription", false
-- 13, "Archaeology", false
```

**Reference:**
- `GetItemClassInfo`
- `GetItemInfo`