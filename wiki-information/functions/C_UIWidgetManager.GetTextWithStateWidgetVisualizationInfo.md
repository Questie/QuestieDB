## Title: C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo

**Content:**
Needs summary.
`widgetInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgetID)`

**Parameters:**
- `widgetID`
  - *number* - Returned from `UPDATE_UI_WIDGET` and `C_UIWidgetManager.GetAllWidgetsBySetID()`

**Returns:**
- `widgetInfo`
  - *TextWithStateWidgetVisualizationInfo?*
    - `shownState`
      - *Enum.WidgetShownState*
    - `enabledState`
      - *Enum.WidgetEnabledState*
    - `text`
      - *string*
    - `tooltip`
      - *string*
    - `textSizeType`
      - *Enum.UIWidgetTextSizeType*
    - `fontType`
      - *Enum.UIWidgetFontType*
    - `bottomPadding`
      - *number*
    - `tooltipLoc`
      - *Enum.UIWidgetTooltipLocation*
    - `hAlign`
      - *Enum.WidgetTextHorizontalAlignmentType*
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
- **Value**
  - **Field**
  - **Description**
  - `0`
    - Hidden
  - `1`
    - Shown

**Enum.WidgetEnabledState**
- **Value**
  - **Field**
  - **Description**
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

**Enum.UIWidgetTextSizeType**
- **Value**
  - **Field**
  - **Description**
  - `0`
    - Small12Pt
  - `1`
    - Medium16Pt
  - `2`
    - Large24Pt
  - `3`
    - Huge27Pt
  - `4`
    - Standard14Pt
  - `5`
    - Small10Pt
  - `6`
    - Small11Pt
  - `7`
    - Medium18Pt
  - `8`
    - Large20Pt

**Enum.UIWidgetFontType**
- **Value**
  - **Field**
  - **Description**
  - `0`
    - Normal
  - `1`
    - Shadow
  - `2`
    - Outline

**Enum.UIWidgetTooltipLocation**
- **Value**
  - **Field**
  - **Description**
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

**Enum.WidgetTextHorizontalAlignmentType**
- **Value**
  - **Field**
  - **Description**
  - `0`
    - Left
  - `1`
    - Center
  - `2`
    - Right

**Enum.WidgetAnimationType**
- **Value**
  - **Field**
  - **Description**
  - `0`
    - None
  - `1`
    - Fade

**Enum.UIWidgetScale**
- **Value**
  - **Field**
  - **Description**
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
- **Value**
  - **Field**
  - **Description**
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
- **Value**
  - **Field**
  - **Description**
  - `0`
    - None
  - `1`
    - Front
  - `2`
    - Back