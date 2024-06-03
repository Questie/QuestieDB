## Title: C_PlayerInfo.GetRace

**Content:**
Returns the race of a player.
`raceID = C_PlayerInfo.GetRace(playerLocation)`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin*🔗

**Returns:**
- `raceID`
  - *number?*

**Example Usage:**
```lua
local playerLocation = PlayerLocation:CreateFromUnit("player")
local raceID = C_PlayerInfo.GetRace(playerLocation)
print("Player's race ID is:", raceID)
```

**Description:**
This function is useful for determining the race of a player character, which can be used in various addons to customize behavior or display information based on the player's race. For example, an addon might use this function to provide race-specific tips or to adjust the appearance of the UI based on the player's race.

**Addons Using This Function:**
- **WeakAuras**: This popular addon uses `C_PlayerInfo.GetRace` to customize auras and triggers based on the player's race, allowing for more personalized and relevant notifications.
- **ElvUI**: This comprehensive UI overhaul addon may use this function to adjust the interface elements and themes according to the player's race, providing a more immersive experience.