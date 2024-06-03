## Title: C_Map.GetMapLinksForMap

**Content:**
Returns the map pins that link to another map.
`mapLinks = C_Map.GetMapLinksForMap(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `mapLinks`
  - *MapLinkInfo*
    - `Field`
    - `Type`
    - `Description`
    - `areaPoiID`
      - *number*
    - `position`
      - *Vector2DMixin* 🔗
    - `name`
      - *string*
    - `atlasName`
      - *string*
    - `linkedUiMapID`
      - *number*