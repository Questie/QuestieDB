## Title: C_Map.GetBestMapForUnit

**Content:**
Returns the current UI map for the given unit. Only works for the player and group members.
`uiMapID = C_Map.GetBestMapForUnit(unitToken)`

**Parameters:**
- `unitToken`
  - *string* : UnitId

**Returns:**
- `uiMapID`
  - *number?* : UiMapID - Returns the "lowest" map the unit is on. For example, if a unit is in a microdungeon it will return that instead of the zone or continent map.

**Description:**
Related API:
- `C_Map.GetMapInfo`
- `GetInstanceInfo`

Related Events:
- `ZONE_CHANGED`
- `ZONE_CHANGED_NEW_AREA`

**Usage:**
Prints the current map for the player.
```lua
/run local mapID = C_Map.GetBestMapForUnit("player"); print(format("You are in %s (%d)", C_Map.GetMapInfo(mapID).name, mapID))
-- You are in Stormwind City (84)
```