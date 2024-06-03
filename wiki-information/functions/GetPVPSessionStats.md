## Title: GetPVPSessionStats

**Content:**
Returns the character's Honor statistics for this session.
`honorableKills, dishonorableKills = GetPVPSessionStats()`

**Returns:**
- `honorableKills`
  - *number* - Amount of honorable kills you have today, returns 0 if you haven't killed anybody today.
- `dishonorableKills`
  - *number* - Note: Not sure if this is dishonorable kills or estimated honor points for today.

**Description:**
Used for retrieving how many honorable kills and honor points you have for today, currently the honor points value is calculated using the estimated honor points from killing an enemy player, and does not take diminishing returns or bonus honor into effect.

**Usage:**
Displays how many honorable kills and estimated honor points you have for today.
```lua
local hk, hp = GetPVPSessionStats();
DEFAULT_CHAT_FRAME:AddMessage("You currently have " .. hk .. " honorable kills today, and an estimated " .. hp .. " honor points.");
```