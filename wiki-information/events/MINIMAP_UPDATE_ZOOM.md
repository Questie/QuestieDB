## Event: MINIMAP_UPDATE_ZOOM

**Title:** MINIMAP UPDATE ZOOM

**Content:**
Fired when the minimap scaling factor is changed. This happens, generally, whenever the player moves indoors from outside, or vice versa. To test the player's location, compare the minimapZoom and minimapInsideZoom CVars with the current minimap zoom level (see Minimap:GetZoom).
`MINIMAP_UPDATE_ZOOM`

**Payload:**
- `None`

**Content Details:**
This event does not relate to the + and - minimap zoom buttons.