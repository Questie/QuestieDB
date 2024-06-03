## Title: C_PlayerInfo.GetName

**Content:**
Returns the name of a player.
`name = C_PlayerInfo.GetName(playerLocation)`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin*🔗

**Returns:**
- `name`
  - *string?*

**Example Usage:**
```lua
local playerLocation = PlayerLocation:CreateFromUnit("player")
local playerName = C_PlayerInfo.GetName(playerLocation)
print("Player's name is: " .. (playerName or "Unknown"))
```

**Description:**
This function is useful for retrieving the name of a player based on their location. It can be particularly handy in addons that need to display or log player names dynamically.

**Addons Using This Function:**
- **Details! Damage Meter**: Uses this function to fetch and display player names in the damage and healing meters.
- **WeakAuras**: Utilizes this function to get player names for custom triggers and displays.