## Title: GetBindLocation

**Content:**
Returns the subzone the character's Hearthstone is set to.
`location = GetBindLocation()`

**Returns:**
Returns the String name of the subzone the player's Hearthstone is set to, e.g. "Tarren Mill", "Crossroads", or "Brill".

**Usage:**
```lua
bindLocation = GetBindLocation();
-- If the player's Hearthstone is set to the inn at Allerian Stronghold then bindLocation is assigned "Allerian Stronghold".
```

**Example Use Case:**
This function can be used in addons that need to display or utilize the player's current Hearthstone location. For instance, an addon that manages travel routes or provides information about the nearest flight paths might use this function to offer more relevant suggestions based on the player's bind location.

**Addons Using This Function:**
Many travel and utility addons, such as "TomTom" and "Hearthstone Tracker," use this function to provide players with information about their Hearthstone location and to enhance the player's travel experience in the game.