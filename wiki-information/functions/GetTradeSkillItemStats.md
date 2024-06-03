## Title: GetTradeSkillItemStats

**Content:**
Gets the link string for a trade skill item.
`itemStats = GetTradeSkillItemStats(skillId)`

**Parameters:**
- `(index)`
  - `index`
    - *number* - The row of the tradeskill listbox containing the item. The indices include the category headers. The tradeskill window doesn't have to be open, but the tradeskill and indices reflect the last state of the tradeskill window. The indices change if you expand or collapse headings (i.e. they exactly reflect the line number of the item as it is currently displayed in the tradeskill window).

**Example:**
Trade Blacksmithing: (window is open, all categories shown)
- `Index` | `Name`
- `1` | `- Daggers`
- `2` | `Deadly Bronze Poniard`
- `3` | `Pearl-handled Dagger`
- `4` | `Big Bronze Knife`
- `5` | `- One-Handed Axes`

Trade Blacksmithing: (window is open, only trade items are shown)
- `Index` | `Name`
- `1` | `- Trade Items`
- `2` | `Elemental Sharpening Stone`
- `3` | `Thorium Shield Spike`

**Returns:**
- `itemStats`
  - *table of string*

**Usage:**
```lua
itemStats = {GetTradeSkillItemStats(2)} -- Get item stats for Deadly Bronze Poniard (see above)
itemStats = {GetTradeSkillItemStats(2)} -- Get item stats for Deadly Bronze Poniard (see above)
```

**Miscellaneous:**
**Result:**
```lua
itemStats = { "Uncommon", "Binds when equipped", "One-Hand", "|cffff2020Dagger|r", "16 - 30 Damage", "Speed 18", "+4 Strength", "Level 25", "Requires Level 20" }
```

**Notes and Caveats:**
The curly braces around the function call are critical, if you forget those your result will be:
```lua
itemStats = "Uncommon"
```