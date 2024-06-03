## Title: C_CameraDefaults.GetCameraFOVDefaults

**Content:**
Needs summary.
`fieldOfViewDegreesDefault, fieldOfViewDegreesPlayerMin, fieldOfViewDegreesPlayerMax = C_CameraDefaults.GetCameraFOVDefaults()`

**Returns:**
- `fieldOfViewDegreesDefault`
  - *number*
- `fieldOfViewDegreesPlayerMin`
  - *number*
- `fieldOfViewDegreesPlayerMax`
  - *number*

**Example Usage:**
This function can be used to retrieve the default field of view (FOV) settings for the camera in World of Warcraft. This can be particularly useful for addons that aim to modify or reset camera settings to their default values.

**Addon Usage:**
Large addons that deal with camera settings or provide custom camera controls, such as DynamicCam, might use this function to ensure they are working within the default FOV parameters set by the game.