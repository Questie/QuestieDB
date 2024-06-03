## Title: C_Map.GetPlayerMapPosition

**Content:**
Returns the location of the unit on a map.
`position = C_Map.GetPlayerMapPosition(uiMapID, unitToken)`

**Parameters:**
- `uiMapID`
  - *number* : UiMapID
- `unitToken`
  - *string* : UnitId

**Returns:**
- `position`
  - *Vector2DMixin?*

**Usage:**
Prints the current map coords for the player.
```lua
local map = C_Map.GetBestMapForUnit("player")
local position = C_Map.GetPlayerMapPosition(map, "player")
print(position:GetXY()) -- 0.54766619205475, 0.54863452911377
```

Sending a map pin for a target:
Sends a map pin to General chat for the target (but still uses your own location).
```lua
/run local c,p,t,m=C_Map,"player","target"m=c.GetBestMapForUnit(p)c.SetUserWaypoint{uiMapID=m,position=c.GetPlayerMapPosition(m,p)}SendChatMessage(format("%%t (%d%%)%s",UnitHealth(t)/UnitHealthMax(t)*100,c.GetUserWaypointHyperlink()),"CHANNEL",nil,1)
```

**Reference:**
WoWInterface: C_Map.GetPlayerMapPosition Memory Usage