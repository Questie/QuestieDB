## Title: C_DeathInfo.GetCorpseMapPosition

**Content:**
Returns the location of the player's corpse on the map.
`position = C_DeathInfo.GetCorpseMapPosition(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `position`
  - *Vector2DMixin?* - Returns nil when there is no corpse.

**Example Usage:**
This function can be used in addons that need to display the player's corpse location on the map. For instance, an addon that helps players find their way back to their corpse after dying could use this function to mark the corpse's position on the map.

**Addon Usage:**
Large addons like "TomTom" or "Mapster" might use this function to provide additional map functionalities, such as marking the location of the player's corpse to assist in navigation after death.