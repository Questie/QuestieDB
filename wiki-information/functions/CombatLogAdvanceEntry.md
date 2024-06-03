## Title: CombatLogAdvanceEntry

**Content:**
Advances the combat log selection by the given amount of entries.
`CombatLogAdvanceEntry(count)`

**Parameters:**
- `count`
  - *number* - number of entries to traverse within the combat log, see details below. Can be negative.
- `ignoreFilter`
  - *boolean* - set to true to ignore combat log filters

**Returns:**
- `isValidIndex`
  - *boolean* - will return false if the new index does not exist in the combat log, but will still set the entry regardless. Otherwise, returns true for valid indices.

**Description:**
This function will traverse through the combat log by the given number of entries. It will not fail, or throw an error if you attempt to advance to an index that does not exist, instead it will return false but will still set the selected entry to that invalid index, and does NOT wrap around to the beginning when it reaches the end.

**Usage:**
Combat log indexing and traversal
```lua
CombatLogSetCurrentEntry(0, true); -- sets current entry to the most recent entry, ignoring filters.
-- will return false
-- the above function sets the selected entry to 0, or the last value in the list. attempting to advance +1 entries from the end will result in an invalid index.
local success = CombatLogAdvanceEntry(1, true);

-- will return true
-- instead of adding one to the index, we subtract one to move backwards through the combat log history.
local success = CombatLogAdvanceEntry(-1, true); 

CombatLogSetCurrentEntry(1, true); -- sets current entry to the first, or oldest entry, ignoring filters.
-- will return true
-- adding one to the index, we now traverse up from the oldest entry, as set above.
local success = CombatLogAdvanceEntry(1, true);
```

**Reference:**
- `CombatLogSetCurrentEntry()`
- `COMBAT_LOG_EVENT`