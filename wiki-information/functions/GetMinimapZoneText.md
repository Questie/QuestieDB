## Title: GetMinimapZoneText

**Content:**
Returns the zone text that is displayed over the minimap.
`zone = GetMinimapZoneText()`

**Returns:**
- `zone`
  - *string* - name of the (sub-)zone currently shown above the minimap, e.g. "Trade District".

**Description:**
The `MINIMAP_ZONE_CHANGED` event fires when the return value of this function changes.
The return value equals that of `GetSubZoneText()` or `GetZoneText()` depending on whether the player is currently in a named sub-zone or not.

**Reference:**
- `GetRealZoneText()`