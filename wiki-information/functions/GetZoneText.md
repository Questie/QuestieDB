## Title: GetZoneText

**Content:**
Returns the name of the zone the player is in.
`zoneName = GetZoneText()`

**Returns:**
- `zoneName`
  - *string* - Localized zone name.

**Description:**
The `ZONE_CHANGED_NEW_AREA` event is triggered when the main area changes (such as exiting or leaving a major city).
If you want more detail, `ZONE_CHANGED` is also triggered every time you move between sub-sections of an area, (such as going from Shattrath's center to Lower City, etc).
There is `ZONE_CHANGED_INDOORS` for specialized cases.

**Usage:**
Returns the name of the zone the player is currently in.
```lua
/run print("Current Zone: " .. GetZoneText())
```

**Reference:**
- `GetSubZoneText()`
- `GetRealZoneText()`
- `GetMinimapZoneText()`