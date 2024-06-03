## Title: GetPVPTimer

**Content:**
Returns the time left in milliseconds until the player is unflagged for PvP.
`timer = GetPVPTimer()`

**Returns:**
- `timer`
  - *number* - Amount of time (in milliseconds) until your PVP flag wears off.

**Description:**
- If you are flagged for PVP permanently, the function returns 301000.
- If you are not flagged for PVP the function returns either 301000 or -1.

**Usage:**
The following snippet displays your current PVP status:
```lua
local sec = math.floor(GetPVPTimer()/1000)
local msg = (not UnitIsPVP("player")) and "You are not flagged for PVP" or 
 (sec==301 and "You are perma-flagged for PVP" or 
 "Your PVP flag wears off in "..(sec>60 and math.floor(sec/60).." minutes " or "")..(sec%60).." seconds")
DEFAULT_CHAT_FRAME:AddMessage(msg)
```

**Example Use Case:**
This function can be used in addons that manage or display player status, particularly in PvP environments. For instance, an addon could use this function to show a countdown timer for when a player will be unflagged from PvP, helping players to manage their PvP status more effectively.

**Addons Using This Function:**
- **PvPStatus**: An addon that tracks and displays the player's PvP flag status and the remaining time until the flag is removed. It uses `GetPVPTimer` to provide real-time updates to the player.