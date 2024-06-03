## Title: C_Map.GetMapGroupID

**Content:**
Returns the map group for a map.
`uiMapGroupID = C_Map.GetMapGroupID(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `uiMapGroupID`
  - *number*

**Example Usage:**
This function can be used to determine the group ID of a specific map, which can be useful for addons that need to handle map-related data, such as displaying map overlays or managing map transitions.

**Addons:**
Large addons like "TomTom" and "World Quest Tracker" might use this function to manage and display map-related information efficiently. For example, "TomTom" could use it to group waypoints by map group, while "World Quest Tracker" might use it to organize world quests by their map groups.