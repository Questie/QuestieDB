## Title: C_UIWidgetManager.GetAllWidgetsBySetID

**Content:**
Returns all widgets for a widget set ID.
`widgets = C_UIWidgetManager.GetAllWidgetsBySetID(setID)`

**Parameters:**
- `setID`
  - *number* : UiWidgetSetID

**ID Location Function:**
- `1` - `C_UIWidgetManager.GetTopCenterWidgetSetID()`
- `2` - `C_UIWidgetManager.GetBelowMinimapWidgetSetID()`
- `240` - `C_UIWidgetManager.GetObjectiveTrackerWidgetSetID()`
- `283` - `C_UIWidgetManager.GetPowerBarWidgetSetID()`

**Returns:**
- `widgets`
  - *UIWidgetInfo*
    - `Field`
    - `Type`
    - `Description`
    - `widgetID`
      - *number* - UiWidget.db2
    - `widgetSetID`
      - *number* - UiWidgetSetID
    - `widgetType`
      - *Enum.UIWidgetVisualizationType*
    - `unitToken`
      - *string?* - UnitId; Added in 9.0.1

**Enum.UIWidgetVisualizationType:**
- `Value` - `Key` - `Data Function` - `Description`
- `0` - `IconAndText` - `C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo`
- `1` - `CaptureBar` - `C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo`
- `2` - `StatusBar` - `C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo`
- `3` - `DoubleStatusBar` - `C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo`
- `4` - `IconTextAndBackground` - `C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo`
- `5` - `DoubleIconAndText` - `C_UIWidgetManager.GetDoubleIconAndTextWidgetVisualizationInfo`
- `6` - `StackedResourceTracker` - `C_UIWidgetManager.GetStackedResourceTrackerWidgetVisualizationInfo`
- `7` - `IconTextAndCurrencies` - `C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo`
- `8` - `TextWithState` - `C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo`
- `9` - `HorizontalCurrencies` - `C_UIWidgetManager.GetHorizontalCurrenciesWidgetVisualizationInfo`
- `10` - `BulletTextList` - `C_UIWidgetManager.GetBulletTextListWidgetVisualizationInfo`
- `11` - `ScenarioHeaderCurrenciesAndBackground` - `C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo`
- `12` - `TextureAndText` - `C_UIWidgetManager.GetTextureAndTextVisualizationInfo` (Added in 8.2.0)
- `13` - `SpellDisplay` - `C_UIWidgetManager.GetSpellDisplayVisualizationInfo` (Added in 8.1.0)
- `14` - `DoubleStateIconRow` - `C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo` (Added in 8.1.5)
- `15` - `TextureAndTextRow` - `C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo` (Added in 8.2.0)
- `16` - `ZoneControl` - `C_UIWidgetManager.GetZoneControlVisualizationInfo` (Added in 8.2.0)
- `17` - `CaptureZone` - `C_UIWidgetManager.GetCaptureZoneVisualizationInfo` (Added in 8.2.5)
- `18` - `TextureWithAnimation` - `C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo` (Added in 9.0.1)
- `19` - `DiscreteProgressSteps` - `C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo` (Added in 9.0.1)
- `20` - `ScenarioHeaderTimer` - `C_UIWidgetManager.GetScenarioHeaderTimerWidgetVisualizationInfo` (Added in 9.0.1)
- `21` - `TextColumnRow` - `C_UIWidgetManager.GetTextColumnRowVisualizationInfo` (Added in 9.1.0)
- `22` - `Spacer` - `C_UIWidgetManager.GetSpacerVisualizationInfo` (Added in 9.1.0)
- `23` - `UnitPowerBar` - `C_UIWidgetManager.GetUnitPowerBarWidgetVisualizationInfo` (Added in 9.2.0)
- `24` - `FillUpFrames` - `C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo` (Added in 10.0.0)
- `25` - `TextWithSubtext` - `C_UIWidgetManager.GetTextWithSubtextWidgetVisualizationInfo` (Added in 10.0.2)
- `26` - `WorldLootObject` (Added in 10.1.0)
- `27` - `ItemDisplay` - `C_UIWidgetManager.GetItemDisplayVisualizationInfo` (Added in 10.1.0)

**Usage:**
Prints all UI widget IDs for the top center part of the screen, e.g. on Warsong Gulch:
```lua
local topCenter = C_UIWidgetManager.GetTopCenterWidgetSetID()
local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(topCenter)
for _, w in pairs(widgets) do
    print(w.widgetType, w.widgetID)
end
-- Output:
-- 0, 6 -- IconAndText, VisID 3: Icon And Text: No Texture Kit
-- 3, 2 -- DoubleStatusBar, VisID 1197: PvP - CTF - Double Status Bar
-- 14, 1640 -- DoubleStateIconRow, VisID 1201: PvP - CTF - Flag Status
```

**Reference:**
`UPDATE_UI_WIDGET`