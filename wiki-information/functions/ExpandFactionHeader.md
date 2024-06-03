## Title: ExpandFactionHeader

**Content:**
Expand a faction header row.
`ExpandFactionHeader(rowIndex)`

**Parameters:**
- `rowIndex`
  - *number* - The row index of the header to expand (Specifying a non-header row can have unpredictable results). The `UPDATE_FACTION` event is fired after the change since faction indexes will have been shifted around.

**Reference:**
- `CollapseFactionHeader`

**Example Usage:**
```lua
-- Example of expanding a faction header
local factionIndex = 1 -- Assuming the first faction is a header
ExpandFactionHeader(factionIndex)
```

**Additional Information:**
This function is often used in addons that manage or display faction reputation information. For example, an addon like "ReputationBars" might use this function to ensure all faction headers are expanded before displaying detailed reputation bars for each faction.