## Title: C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number* - Returned from `UPDATE_UI_WIDGET` and `C_UIWidgetManager.GetAllWidgetsBySetID()`

**Returns:**
- `widgetInfo`
  - *StatusBarWidgetVisualizationInfo?*
    - `shownState`
      - *Enum.WidgetShownState*
    - `barMin`
      - *number*
    - `barMax`
      - *number*
    - `barValue`
      - *number*
    - `text`
      - *string*
    - `tooltip`
      - *string*
    - `barValueTextType`
      - *Enum.StatusBarValueTextType*
    - `overrideBarText`
      - *string*
    - `overrideBarTextShownType`
      - *Enum.StatusBarOverrideBarTextShownType*
    - `colorTint`
      - *Enum.StatusBarColorTintValue*
    - `partitionValues`
      - *number*
    - `tooltipLoc`
      - *Enum.UIWidgetTooltipLocation*
    - `fillMotionType`
      - *Enum.UIWidgetMotionType*
    - `barTextEnabledState`
      - *Enum.WidgetEnabledState*
    - `barTextFontType`
      - *Enum.UIWidgetFontType*
    - `barTextSizeType`
      - *Enum.UIWidgetTextSizeType*
    - `textEnabledState`
      - *Enum.WidgetEnabledState*
    - `textFontType`
      - *Enum.UIWidgetFontType*
    - `textSizeType`
      - *Enum.UIWidgetTextSizeType*
    - `widgetSizeSetting`
      - *number*
    - `textureKit`
      - *string* : textureKit
    - `frameTextureKit`
      - *string* : textureKit
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

**Enum.WidgetShownState:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Hidden
  - `1`
    - Shown

**Enum.StatusBarValueTextType:**
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

**Enum.StatusBarOverrideBarTextShownType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Never
  - `1`
    - Always
  - `2`
    - OnlyOnMouseover
  - `3`
    - OnlyNotOnMouseover

**Enum.StatusBarColorTintValue:**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - Black
  - `2`
    - White
  - `3`
    - Red
  - `4`
    - Yellow
  - `5`
    - Orange
  - `6`
    - Purple
  - `7`
    - Green
  - `8`
    - Blue

**Enum.UIWidgetTooltipLocation:**
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

**Enum.WidgetAnimationType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - Fade

**Enum.UIWidgetScale:**
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

**Enum.UIWidgetLayoutDirection:**
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

**Enum.UIWidgetModelSceneLayer:**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - Front
  - `2`
    - Back