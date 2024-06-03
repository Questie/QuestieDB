## Title: GetBattlefieldStatInfo

**Content:**
Get list of battleground specific columns on the scoreboard.
`name, icon, tooltip = GetBattlefieldStatInfo(index)`

**Parameters:**
- `index`
  - *number* - Column to get data for

**Returns:**
- `name`
  - *string* - Name of the column (e.g., Flags Captured)
- `icon`
  - *string* - Icon displayed when on the scoreboard rows (e.g., Horde flag icon next to the flag captures of an Alliance player)
- `tooltip`
  - *string* - Tooltip displayed when hovering over a column's name

**Description:**
Used to retrieve the custom scoreboard columns inside a battleground.

**Example Usage:**
```lua
local index = 1
local name, icon, tooltip = GetBattlefieldStatInfo(index)
print("Column Name: ", name)
print("Icon: ", icon)
print("Tooltip: ", tooltip)
```

**Battleground Specific Columns:**
- **Warsong Gulch:**
  - Flags Captured
  - Flags Returned
- **Arathi Basin:**
  - Bases Assaulted
  - Bases Defended
- **Alterac Valley:**
  - Graveyards Assaulted
  - Graveyards Defended
  - Towers Assaulted
  - Towers Defended
  - Mines Captured
  - Leaders Killed
  - Secondary Objectives