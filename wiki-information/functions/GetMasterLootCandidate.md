## Title: GetMasterLootCandidate

**Content:**
Returns the name of an eligible player for receiving master loot by index.
`candidate = GetMasterLootCandidate(slot, index)`

**Parameters:**
- `slot`
  - *number* - The loot slot number of the item you want to get information about
- `index`
  - *number* - The number of the player whose name you wish to return. Typically between 1 and 40.

**Returns:**
- `candidate`
  - *string* - The name of the player.

**Description:**
Only valid if the player is the master looter.

**Reference:**
- `GetNumRaidMembers()`
- `GiveMasterLoot(slot, index)`