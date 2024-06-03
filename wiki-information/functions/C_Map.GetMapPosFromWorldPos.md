## Title: C_Map.GetMapPosFromWorldPos

**Content:**
Translates a world map position to a map position.
`uiMapID, mapPosition = C_Map.GetMapPosFromWorldPos(continentID, worldPosition)`

**Parameters:**
- `continentID`
  - *number* - InstanceID of the continent
- `worldPosition`
  - *Vector2DMixin* - The world position to be translated
- `overrideUiMapID`
  - *number?* - If you don't set this to the map that you want a relative position in, it defaults to the mapID for the player's continent, essentially normalizing world coordinates (i.e. 478.1,598.2) into continent map coordinates (i.e. 0.44,0.61)

**Returns:**
- `uiMapID`
  - *number* - UiMapID
- `mapPosition`
  - *Vector2DMixin* - The translated map position