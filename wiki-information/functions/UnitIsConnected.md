## Title: UnitIsConnected

**Content:**
Returns true if the unit is connected to the game (i.e. not offline).
`isOnline = UnitIsConnected(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `isConnected`
  - *boolean*

**Example Usage:**
This function can be used to check if a player in your party or raid is currently online. For instance, in a raid management addon, you might use this to determine which players are available for an encounter.

**Addons Using This Function:**
Many raid management and unit frame addons, such as ElvUI and Grid, use `UnitIsConnected` to display the online/offline status of players. This helps raid leaders and players to quickly identify who is available and who is not.