## Event: UPDATE_UI_WIDGET

**Title:** UPDATE UI WIDGET

**Content:**
Returns updated UI widget information.
`UPDATE_UI_WIDGET: widgetInfo`

**Payload:**
- `widgetInfo`
  - *UIWidgetInfo*
    - **Field**
      - **Type**
      - **Description**
    - `widgetID`
      - *number*
      - UiWidget.db2
    - `widgetSetID`
      - *number*
      - UiWidgetSetID
    - `widgetType`
      - *Enum.UIWidgetVisualizationType*
    - `unitToken`
      - *string?*
      - UnitId; Added in 9.0.1
    - *Enum.UIWidgetVisualizationType*
      - **Value**
      - **Key**
      - **Data Function**
      - **Description**
    - 0
      - IconAndText
      - C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo
    - 1
      - CaptureBar
      - C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo
    - 2
      - StatusBar
      - C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo
    - 3
      - DoubleStatusBar
      - C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo
    - 4
      - IconTextAndBackground
      - C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo
    - 5
      - DoubleIconAndText
      - C_UIWidgetManager.GetDoubleIconAndTextWidgetVisualizationInfo
    - 6
      - StackedResourceTracker
      - C_UIWidgetManager.GetStackedResourceTrackerWidgetVisualizationInfo
    - 7
      - IconTextAndCurrencies
      - C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo
    - 8
      - TextWithState
      - C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo
    - 9
      - HorizontalCurrencies
      - C_UIWidgetManager.GetHorizontalCurrenciesWidgetVisualizationInfo
    - 10
      - BulletTextList
      - C_UIWidgetManager.GetBulletTextListWidgetVisualizationInfo
    - 11
      - ScenarioHeaderCurrenciesAndBackground
      - C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo
    - 12
      - TextureAndText
      - C_UIWidgetManager.GetTextureAndTextVisualizationInfo
      - Added in 8.2.0
    - 13
      - SpellDisplay
      - C_UIWidgetManager.GetSpellDisplayVisualizationInfo
      - Added in 8.1.0
    - 14
      - DoubleStateIconRow
      - C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo
      - Added in 8.1.5
    - 15
      - TextureAndTextRow
      - C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo
      - Added in 8.2.0
    - 16
      - ZoneControl
      - C_UIWidgetManager.GetZoneControlVisualizationInfo
      - Added in 8.2.0
    - 17
      - CaptureZone
      - C_UIWidgetManager.GetCaptureZoneVisualizationInfo
      - Added in 8.2.5
    - 18
      - TextureWithAnimation
      - C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo
      - Added in 9.0.1
    - 19
      - DiscreteProgressSteps
      - C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo
      - Added in 9.0.1
    - 20
      - ScenarioHeaderTimer
      - C_UIWidgetManager.GetScenarioHeaderTimerWidgetVisualizationInfo
      - Added in 9.0.1
    - 21
      - TextColumnRow
      - C_UIWidgetManager.GetTextColumnRowVisualizationInfo
      - Added in 9.1.0
    - 22
      - Spacer
      - C_UIWidgetManager.GetSpacerVisualizationInfo
      - Added in 9.1.0
    - 23
      - UnitPowerBar
      - C_UIWidgetManager.GetUnitPowerBarWidgetVisualizationInfo
      - Added in 9.2.0
    - 24
      - FillUpFrames
      - C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo
      - Added in 10.0.0
    - 25
      - TextWithSubtext
      - C_UIWidgetManager.GetTextWithSubtextWidgetVisualizationInfo
      - Added in 10.0.2
    - 26
      - WorldLootObject
      - Added in 10.1.0
    - 27
      - ItemDisplay
      - C_UIWidgetManager.GetItemDisplayVisualizationInfo
      - Added in 10.1.0

**Usage:**
Prints UI widget information when UPDATE_UI_WIDGET fires.
```lua
local function OnEvent(self, event, w)
    local typeInfo = UIWidgetManager:GetWidgetTypeInfo(w.widgetType)
    local visInfo = typeInfo.visInfoDataFunction(w.widgetID)
    print(w.widgetSetID, w.widgetType, w.widgetID, visInfo)
end

local f = CreateFrame("Frame")
f:RegisterEvent("UPDATE_UI_WIDGET")
f:SetScript("OnEvent", OnEvent)
```
You can query the information from the specific data function yourself, or use visInfo which does it programmatically.
E.g. for the Arathi Basin PvP objective:
Widget Set ID: 1 - Top center part of the screen
Widget Type: 3 - Enum.UIWidgetVisualizationType.DoubleStatusBar
Widget ID: 1671 - UiWidget.VisID -> UiWidgetVisualization.ID 1200 "PvP - Domination - Double Status Bar"
/dump C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo(1671)