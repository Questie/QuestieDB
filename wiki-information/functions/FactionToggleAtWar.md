## Title: FactionToggleAtWar

**Content:**
Toggles the At War status for a faction.
`FactionToggleAtWar(rowIndex)`

**Parameters:**
- `rowIndex`
  - *number* - The row index of the faction to toggle the At War status for. The row must have a true `canToggleAtWar` value (From `GetFactionInfo`).

**Description:**
The `UPDATE_FACTION` event will be fired after the change.