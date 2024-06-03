## Title: C_Map.GetWorldPosFromMapPos

**Content:**
Translates a map position to a world map position.
`continentID, worldPosition = C_Map.GetWorldPosFromMapPos(uiMapID, mapPosition)`

**Parameters:**
- `uiMapID`
  - *number* : UiMapID
- `mapPosition`
  - *Vector2DMixin* - as returned from `C_Map.GetPlayerMapPosition()`

**Returns:**
- `continentID`
  - *number* : InstanceID
- `worldPosition`
  - *Vector2DMixin*

**Usage:**
Prints the world coords and size for the boundary box of Elwynn Forest.
```lua
/dump C_Map.GetWorldPosFromMapPos(37, {x=0, y=0}) -- x = -7939.580078125, y = 1535.4200439453
/dump C_Map.GetWorldPosFromMapPos(37, {x=1, y=1}) -- x = -10254.200195312, y = -1935.4200439453
/dump C_Map.GetMapWorldSize(37) -- 3470.8400878906, 2314.6201171875
```

**Reference:**
- `UnitPosition()`
- HereBeDragons library