## Title: C_Map.GetMapArtID

**Content:**
Returns the art for a (phased) map.
`uiMapArtID = C_Map.GetMapArtID(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `uiMapArtID`
  - *number*

**Example Usage:**
This function can be used to retrieve the art ID for a specific map, which can then be used to display the correct map art in a custom UI or addon.

**Addon Usage:**
Large addons like "TomTom" or "HandyNotes" might use this function to ensure they are displaying the correct map art for phased areas, ensuring that waypoints and notes are accurately placed on the map.