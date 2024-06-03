## Title: C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number* - Returned from `UPDATE_UI_WIDGET` and `C_UIWidgetManager.GetAllWidgetsBySetID()`

**Returns:**
- `widgetInfo`
  - *IconTextAndBackgroundWidgetVisualizationInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `shownState`
      - *Enum.WidgetShownState*
    - `text`
      - *string*
    - `widgetSizeSetting`
      - *number*
    - `textureKit`
      - *string*
    - `frameTextureKit`
      - *string*
    - `hasTimer`
      - *boolean*
    - `orderIndex`
      - *number*
    - `widgetTag`
      - *string*
    - `inAnimType`
      - *Enum.WidgetAnimationType*
    - `outAnimType`
      - *Enum.WidgetAnimationType*
    - `widgetScale`
      - *Enum.UIWidgetScale*
    - `layoutDirection`
      - *Enum.UIWidgetLayoutDirection*
    - `modelSceneLayer`
      - *Enum.UIWidgetModelSceneLayer*
    - `scriptedAnimationEffectID`
      - *number*

**Enum.WidgetShownState**
- `Value`
- `Field`
- `Description`
  - `0`
    - Hidden
  - `1`
    - Shown

**Enum.WidgetAnimationType**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - Fade

**Enum.UIWidgetScale**
- `Value`
- `Field`
- `Description`
  - `0`
    - OneHundred
  - `1`
    - Ninty
  - `2`
    - Eighty
  - `3`
    - Seventy
  - `4`
    - Sixty
  - `5`
    - Fifty

**Enum.UIWidgetLayoutDirection**
- `Value`
- `Field`
- `Description`
  - `0`
    - Default
  - `1`
    - Vertical
  - `2`
    - Horizontal
  - `3`
    - Overlap
  - `4`
    - HorizontalForceNewRow

**Enum.UIWidgetModelSceneLayer**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - Front
  - `2`
    - Back