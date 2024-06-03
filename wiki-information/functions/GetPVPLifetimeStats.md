## Title: GetPVPLifetimeStats

**Content:**
Returns the character's lifetime PvP statistics.
`lifetimeHonorableKills, lifetimeMaxPVPRank = GetPVPLifetimeStats()`

**Returns:**
- `lifetimeHonorableKills`
  - *number* - The number of honorable kills you have made
- `lifetimeMaxPVPRank`
  - *number* - The highest rank you have achieved (Use `GetPVPRankInfo(highestRank)` to get the name of the rank)

**Usage:**
Prints the player's PVP rank name to the default chat frame.
```lua
local _, _, highestRank = GetPVPLifetimeStats()
local pvpRank = GetPVPRankInfo(highestRank)
print(pvpRank)
```