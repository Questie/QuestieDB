## Title: C_PlayerInfo.IsConnected

**Content:**
Returns true if the player is connected.
`isConnected = C_PlayerInfo.IsConnected()`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin?*

**Returns:**
- `isConnected`
  - *boolean?*

**Reference:**
- `UnitIsConnected()`

**Example Usage:**
This function can be used to check if a specific player is currently connected to the game. This is particularly useful in scenarios where you need to verify the connection status of a player before performing certain actions, such as sending a message or inviting them to a group.

**Addon Usage:**
Large addons like "ElvUI" and "WeakAuras" might use this function to ensure that the player or other players are connected before updating UI elements or triggering certain events. For instance, "ElvUI" could use it to check the connection status of group members to display accurate information in the unit frames.