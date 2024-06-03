## Title: CollapseFactionHeader

**Content:**
Collapse a faction header row.
`CollapseFactionHeader(rowIndex)`

**Parameters:**
- `rowIndex`
  - *number* - The row index of the header to collapse (Specifying a non-header row can have unpredictable results). The `UPDATE_FACTION` event is fired after the change since faction indexes will have been shifted around.

**Reference:**
- `ExpandFactionHeader`