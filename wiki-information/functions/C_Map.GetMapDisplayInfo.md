## Title: C_Map.GetMapDisplayInfo

**Content:**
Returns whether group member pins should be hidden.
`hideIcons = C_Map.GetMapDisplayInfo(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `hideIcons`
  - *boolean*

**Example Usage:**
This function can be used to determine if the map should hide group member icons, which can be useful for custom map displays or addons that modify the map interface.

**Addon Usage:**
Large addons like "TomTom" or "HandyNotes" might use this function to decide whether to display group member icons on custom map overlays.