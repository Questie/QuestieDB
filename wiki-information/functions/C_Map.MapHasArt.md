## Title: C_Map.MapHasArt

**Content:**
Returns true if the map has art and can be displayed by the FrameXML.
`hasArt = C_Map.MapHasArt(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `hasArt`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific map has art assets before attempting to display it in a custom UI element. For instance, an addon that provides enhanced map features might use this function to ensure that the map data is available before rendering additional overlays or markers.

**Addon Usage:**
Large addons like "TomTom" or "HandyNotes" might use this function to verify the presence of map art before adding waypoints or notes to the map, ensuring that their features are only applied to maps that can be properly displayed.