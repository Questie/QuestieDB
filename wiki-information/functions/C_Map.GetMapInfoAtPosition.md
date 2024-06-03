## Title: C_Map.GetMapInfoAtPosition

**Content:**
Returns info for any child or adjacent maps at a position on the map.
`info = C_Map.GetMapInfoAtPosition(uiMapID, x, y)`

**Parameters:**
- `uiMapID`
  - *number* : UiMapID
- `x`
  - *number*
- `y`
  - *number*
- `ignoreZoneMapPositionData`
  - *boolean?*

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

**Description:**
No return value in instances, the WoD Garrison, the beginning of the new player experience, or empty regions of the cosmic map.
Otherwise, returns map info for:
- Child maps, such as zones in a continent.
- Adjacent maps, such as zones next to the current one.
- The current map, similar to `C_Map.GetMapInfo()`.