## Title: UnitInRaid

**Content:**
Returns the index if the unit is in your raid group.
`index = UnitInRaid(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `index`
  - *number* - same number in the raid UnitId, feed into `GetRaidRosterInfo`

**Description:**
Pets are not considered to be part of your raid group.

**Reference:**
- `UnitInParty()`

**Example Usage:**
```lua
local unit = "player"
local raidIndex = UnitInRaid(unit)
if raidIndex then
    print("Player is in the raid at index:", raidIndex)
else
    print("Player is not in the raid.")
end
```

**Usage in Addons:**
- **DBM (Deadly Boss Mods):** This function is used to determine if a player is in a raid group to enable or disable raid-specific features and warnings.
- **ElvUI:** Utilizes this function to adjust UI elements based on whether the player is in a raid group, such as displaying raid frames.