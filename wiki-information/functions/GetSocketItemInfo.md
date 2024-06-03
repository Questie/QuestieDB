## Title: GetSocketItemInfo

**Content:**
Returns info for the item currently being socketed.
`itemName, iconPathName, itemQuality = GetSocketItemInfo()`

**Returns:**
- `itemName`
  - *string* - Localized name of the item currently being socketed, or nil if the socketing UI is not open.
- `iconPathName`
  - *string* - Virtual path name (i.e. `Interface\\Icons\\inv_belt_52`) for the icon displayed in the character window (PaperDollFrame) for this item, or nil if the socketing UI is not open.
- `itemQuality`
  - *number* - 0) Socketing UI not currently open, 1) Common, 2) Uncommon, 3) Rare, 4) Epic, etc. (the colors correlate to the color of the font used by the game when it draws the item's name).

**Usage:**
```lua
-- from Blizzard_ItemSocketingUI.lua
local name, icon, quality = GetSocketItemInfo();
local sname, sicon, squality = tostring(name), tostring(icon), tostring(quality)
print("name:" .. sname .. " icon:" .. sicon .. " quality:" .. squality)
```

**Miscellaneous:**
Result:

Simple print statement displaying the values returned. In this example, I used Merlin's Robe (item id:47604):
```
name:Merlin's Robe icon:Interface\\Icons\\INV_Chest_Cloth_64 quality:4
```