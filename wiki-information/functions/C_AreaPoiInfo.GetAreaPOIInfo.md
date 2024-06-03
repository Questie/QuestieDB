## Title: C_AreaPoiInfo.GetAreaPOIInfo

**Content:**
Returns info for an area point of interest (e.g. World PvP objectives).
`poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(uiMapID, areaPoiID)`

**Parameters:**
- `uiMapID`
  - *number* : UiMapID
- `areaPoiID`
  - *number* : AreaPOI

**Returns:**
- `poiInfo`
  - *AreaPOIInfo* - a table containing:
    - `Field`
    - `Type`
    - `Description`
    - `areaPoiID`
      - *number*
    - `position`
      - *vector2* 🔗
    - `name`
      - *string* - e.g. "Domination Point Tower"
    - `description`
      - *string?* - e.g. "Horde Controlled" or "Grand Master Pet Tamer"
    - `textureIndex`
      - *number?*
    - `tooltipWidgetSet`
      - *number?* - Previously widgetSetID (10.2.6)
    - `iconWidgetSet`
      - *number?*
    - `atlasName`
      - *string?* - AtlasID
    - `uiTextureKit`
      - *string?* : textureKit
    - `shouldGlow`
      - *boolean*
    - `factionID`
      - *number?* - Added in 10.0.2
    - `isPrimaryMapForPOI`
      - *boolean* - Added in 10.0.2
    - `isAlwaysOnFlightmap`
      - *boolean* - Added in 10.0.2
    - `addPaddingAboveTooltipWidgets`
      - *boolean?* - Previously addPaddingAboveWidgets (10.2.6)
    - `highlightWorldQuestsOnHover`
      - *boolean*
    - `highlightVignettesOnHover`
      - *boolean*

**Description:**
The textureIndex specifies an icon from Interface/Minimap/POIIcons. You can use `GetPOITextureCoords()` to resolve these indices to texture coordinates.