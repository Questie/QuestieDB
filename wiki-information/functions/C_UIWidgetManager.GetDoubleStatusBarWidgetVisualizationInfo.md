## Title: C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number* - Returned from `UPDATE_UI_WIDGET` and `C_UIWidgetManager.GetAllWidgetsBySetID()`

**Returns:**
- `widgetInfo`
  - *DoubleStatusBarWidgetVisualizationInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `shownState`
      - *Enum.WidgetShownState*
    - `leftBarMin`
      - *number*
    - `leftBarMax`
      - *number*
    - `leftBarValue`
      - *number*
    - `leftBarTooltip`
      - *string*
    - `rightBarMin`
      - *number*
    - `rightBarMax`
      - *number*
    - `rightBarValue`
      - *number*
    - `rightBarTooltip`
      - *string*
    - `barValueTextType`
      - *Enum.StatusBarValueTextType*
    - `text`
      - *string*
    - `leftBarTooltipLoc`
      - *Enum.UIWidgetTooltipLocation*
    - `rightBarTooltipLoc`
      - *Enum.UIWidgetTooltipLocation*
    - `fillMotionType`
      - *Enum.UIWidgetMotionType*
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

**Enum.StatusBarValueTextType**
- `Value`
- `Field`
- `Description`
  - `0`
    - Hidden
  - `1`
    - Percentage
  - `2`
    - Value
  - `3`
    - Time
  - `4`
    - TimeShowOneLevelOnly
  - `5`
    - ValueOverMax
  - `6`
    - ValueOverMaxNormalized

**Enum.UIWidgetTooltipLocation**
- `Value`
- `Field`
- `Description`
  - `0`
    - Default
  - `1`
    - BottomLeft
  - `2`
    - Left
  - `3`
    - TopLeft
  - `4`
    - Top
  - `5`
    - TopRight
  - `6`
    - Right
  - `7`
    - BottomRight
  - `8`
    - Bottom

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