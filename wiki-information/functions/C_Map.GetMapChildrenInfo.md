## Title: C_Map.GetMapChildrenInfo

**Content:**
Returns info for the children of a map.
`info = C_Map.GetMapChildrenInfo(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID
- `mapType`
  - *Enum.UIMapType?* - Filters results by a specific map type.
- `allDescendants`
  - *boolean?* - Whether to recurse on each child or not.

**Returns:**
- `info`
  - *UiMapDetails*
    - `Field`
    - `Type`
    - `Description`
    - `mapID`
      - *number* - UiMapID
    - `name`
      - *string*
    - `mapType`
      - *Enum.UIMapType*
    - `parentMapID`
      - *number* - Returns 0 if there is no parent map
    - `flags`
      - *Enum.UIMapFlag* - Added in 9.0.1

**Enum.UIMapType:**
- `Value`
- `Field`
- `Description`
- `0`
  - Cosmic
- `1`
  - World
- `2`
  - Continent
- `3`
  - Zone
- `4`
  - Dungeon
- `5`
  - Micro
- `6`
  - Orphan

**Enum.UIMapFlag:**
- `Value`
- `Field`
- `Description`
- `0x1`
  - NoHighlight
- `0x2`
  - ShowOverlays
- `0x4`
  - ShowTaxiNodes
- `0x8`
  - GarrisonMap
- `0x10`
  - FallbackToParentMap
- `0x20`
  - NoHighlightTexture
- `0x40`
  - ShowTaskObjectives
- `0x80`
  - NoWorldPositions
- `0x100`
  - HideArchaeologyDigs
- `0x200`
  - DoNotTranslateBranches (Renamed from Deprecated in 10.2.5)
- `0x400`
  - HideIcons
- `0x800`
  - HideVignettes
- `0x1000`
  - ForceAllOverlayExplored
- `0x2000`
  - FlightMapShowZoomOut
- `0x4000`
  - FlightMapAutoZoom
- `0x8000`
  - ForceOnNavbar
- `0x10000`
  - AlwaysAllowUserWaypoints
- `0x20000`
  - AlwaysAllowTaxiPathing

**Usage:**
Children of the "Cosmic" uiMapID (not to be confused with the UIMapType).
```lua
/dump C_Map.GetMapChildrenInfo(946)
{
    {mapType=2, mapID=101, name="Outland", parentMapID=946},
    {mapType=2, mapID=572, name="Draenor", parentMapID=946},
    {mapType=1, mapID=947, name="Azeroth", parentMapID=946}
}
```
Children of the "Cosmic" uiMapID with mapType==2
```lua
/dump C_Map.GetMapChildrenInfo(946, 2)
{
    {mapType=2, mapID=101, name="Outland", parentMapID=946},
    {mapType=2, mapID=572, name="Draenor", parentMapID=946}
}
```