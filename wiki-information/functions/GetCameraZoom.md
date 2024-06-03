## Title: GetCameraZoom

**Content:**
Returns the current zoom level of the camera.
`zoom = GetCameraZoom()`

**Returns:**
- `zoom`
  - *number* - the currently set zoom level

**Description:**
Doesn't take camera collisions with the environment into account and will return what the camera would be at. If the camera is in motion, the zoom level that is set that frame is used, not the zoom level that the camera is traveling to.