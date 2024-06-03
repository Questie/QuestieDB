## Title: GetItemQualityColor

**Content:**
Returns the color for an item quality.
`r, g, b, hex = GetItemQualityColor(quality)`

**Parameters:**
- `quality`
  - *Enum.ItemQuality* - The quality of the item.

**Returns:**
- `r`
  - *number* - Red component of the color (0 to 1, inclusive).
- `g`
  - *number* - Green component of the color (0 to 1, inclusive).
- `b`
  - *number* - Blue component of the color (0 to 1, inclusive).
- `hex`
  - *string* - UI escape sequence for this color, without the leading `|c`.

**Description:**
It is recommended to use the global `ITEM_QUALITY_COLORS` table instead of repeatedly calling this function.
In particular, `ITEM_QUALITY_COLORS.hex` already includes the leading `|c` escape sequence whereas the fourth return value of this function does not.
If an invalid quality index is specified, `GetItemQualityColor()` returns white (same as index 1):
- `r = 1`
- `g = 1`
- `b = 1`
- `hex = |cffffffff`

**Usage:**
```lua
for i = 0, 8 do
  local r, g, b, hex = GetItemQualityColor(i)
  print(i, '|c'..hex, _G, string.sub(hex, 3))
end
```

**Miscellaneous:**
**Result:**
Will print all qualities, in their individual colors.
- 0 Poor 9d9d9d
- 1 Common ffffff
- 2 Uncommon 1eff00
- 3 Rare 0070dd
- 4 Epic a335ee
- 5 Legendary ff8000
- 6 Artifact e6cc80
- 7 Heirloom 00ccff
- 8 WoW Token 00ccff