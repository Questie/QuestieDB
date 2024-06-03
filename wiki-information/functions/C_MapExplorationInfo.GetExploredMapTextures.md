## Title: C_MapExplorationInfo.GetExploredMapTextures

**Content:**
Returns explored map textures for a map.
`overlayInfo = C_MapExplorationInfo.GetExploredMapTextures(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `overlayInfo`
  - *UiMapExplorationInfo*
    - `Field`
    - `Type`
    - `Description`
    - `textureWidth`
      - *number*
    - `textureHeight`
      - *number*
    - `offsetX`
      - *number*
    - `offsetY`
      - *number*
    - `isShownByMouseOver`
      - *boolean*
    - `isDrawOnTopLayer`
      - *boolean*
    - `fileDataIDs`
      - *number*
    - `hitRect`
      - *UiMapExplorationHitRect*
        - `UiMapExplorationHitRect`
          - `Field`
          - `Type`
          - `Description`
          - `top`
            - *number*
          - `bottom`
            - *number*
          - `left`
            - *number*
          - `right`
            - *number*

**Added in:**
Patch 10.0.0