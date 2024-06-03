## Title: SetView

**Content:**
Sets the camera to a predefined camera position (1-5).
`SetView(viewIndex)`

**Parameters:**
- `viewIndex`
  - *number* - The view index (1-5) to return to (1 is always first person, and cannot be saved with SaveView)

**Description:**
If SaveView has not previously been used on the view index, then your camera will be set to a preset position and angle.
The first view index defaults to first person.
The last position loaded is stored in the CVar `cameraView`.