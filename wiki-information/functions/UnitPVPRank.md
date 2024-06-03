## Title: UnitPVPRank

**Content:**
Returns the specified unit's PvP rank ID.
`rankID = UnitPVPRank(unit)`

**Parameters:**
- `unit`
  - *string*

**Values:**
Dishonorable ranks like "Pariah" exist but were never used in Vanilla.

**Rank ID:**
- **Alliance / Horde / Rank Number**
  - 0 / 0 / 1
  - Pariah / Pariah / -4
  - Outlaw / Outlaw / -3
  - Exiled / Exiled / -2
  - Dishonored / Dishonored / -1
  - Private / Scout / 1
  - Corporal / Grunt / 2
  - Sergeant / Sergeant / 3
  - Master Sergeant / Senior Sergeant / 4
  - Sergeant Major / First Sergeant / 5
  - Knight / Stone Guard / 6
  - Knight-Lieutenant / Blood Guard / 7
  - Knight-Captain / Legionnaire / 8
  - Knight-Champion / Centurion / 9
  - Lieutenant Commander / Champion / 10
  - Commander / Lieutenant General / 11
  - Marshal / General / 12
  - Field Marshal / Warlord / 13
  - Grand Marshal / High Warlord / 14

**Returns:**
- `rankID`
  - *number* - Starts at 5 (not at 1) for the first rank. Returns 0 if the unit has no rank. Can be used in `GetPVPRankInfo()` for rank information.

**Usage:**
```lua
local rankID = UnitPVPRank("target")
local rankName, rankNumber = GetPVPRankInfo(rankID)
if rankName then
    print(format("%s is rank ID %d, rank number %d (%s)", UnitName("target"), rankID, rankNumber, rankName))
end
-- Output example: Koribli is rank ID 12, rank number 8 (Knight-Captain)
```