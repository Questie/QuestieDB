## Title: C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number* - Returned from `UPDATE_UI_WIDGET` and `C_UIWidgetManager.GetAllWidgetsBySetID()`

**Returns:**
- `widgetInfo`
  - *IconTextAndCurrenciesWidgetVisualizationInfo?*
    - `shownState`
      - *Enum.WidgetShownState*
    - `enabledState`
      - *Enum.WidgetEnabledState*
    - `descriptionShownState`
      - *Enum.WidgetShownState*
    - `descriptionEnabledState`
      - *Enum.WidgetEnabledState*
    - `text`
      - *string*
    - `description`
      - *string*
    - `currencies`
      - *UIWidgetCurrencyInfo*
    - `tooltipLoc`
      - *Enum.UIWidgetTooltipLocation*
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

**Enum.WidgetShownState:**
- `Value`
  - `Field`
  - `Description`
  - `0`
    - Hidden
  - `1`
    - Shown

**Enum.WidgetEnabledState:**
- `Value`
  - `Field`
  - `Description`
  - `0`
    - Disabled
  - `1`
    - Yellow (Renamed from Enabled in 10.1.0)
  - `2`
    - Red
  - `3`
    - White (Added in 9.1.0)
  - `4`
    - Green (Added in 9.1.0)
  - `5`
    - Artifact (Renamed from Gold in 10.1.0)
  - `6`
    - Black (Added in 9.2.0)

**UIWidgetCurrencyInfo:**
- `Field`
  - `Type`
  - `Description`
  - `iconFileID`
    - *number*
  - `leadingText`
    - *string*
  - `text`
    - *string*
  - `tooltip`
    - *string*
  - `isCurrencyMaxed`
    - *boolean*

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