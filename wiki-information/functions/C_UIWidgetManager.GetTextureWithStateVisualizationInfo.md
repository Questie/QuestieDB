## Title: C_UIWidgetManager.GetTextureWithStateVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetTextureWithStateVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number*

**Returns:**
- `widgetInfo`
  - *structure* - TextureWithStateVisualizationInfo (nilable)
    - `Key`
    - `Type`
    - `Description`
    - `shownState`
      - *Enum.WidgetShownState*
    - `name`
      - *string*
    - `backgroundTextureKitID`
      - *number*
    - `portraitTextureKitID`
      - *number*
    - `hasTimer`
      - *boolean*
    - `orderIndex`
      - *number*
    - `widgetTag`
      - *string*
    - `Enum.WidgetShownState`
      - `Value`
      - `Field`
      - `Description`
        - `0`
          - Hidden
        - `1`
          - Shown

**Reference:**
Blizzard API Documentation