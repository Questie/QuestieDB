## Title: C_UIWidgetManager.GetTopCenterWidgetSetID

**Content:**
Returns the widget set ID for the top center part of the screen.
`setID = C_UIWidgetManager.GetTopCenterWidgetSetID()`

**Returns:**
- `setID`
  - *number* : UiWidgetSetID - Returns 1
  - `ID`
  - `Location Function`
    - `1`
      - `C_UIWidgetManager.GetTopCenterWidgetSetID()`
    - `2`
      - `C_UIWidgetManager.GetBelowMinimapWidgetSetID()`
    - `240`
      - `C_UIWidgetManager.GetObjectiveTrackerWidgetSetID()`
    - `283`
      - `C_UIWidgetManager.GetPowerBarWidgetSetID()`

**Usage:**
Prints all UI widget IDs for the top center part of the screen, e.g. on Warsong Gulch:
```lua
local topCenter = C_UIWidgetManager.GetTopCenterWidgetSetID()
local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(topCenter)
for _, w in pairs(widgets) do
    print(w.widgetType, w.widgetID)
end
-- Output example:
-- 0, 6 -- IconAndText, VisID 3: Icon And Text: No Texture Kit
-- 3, 2 -- DoubleStatusBar, VisID 1197: PvP - CTF - Double Status Bar
-- 14, 1640 -- DoubleStateIconRow, VisID 1201: PvP - CTF - Flag Status
```