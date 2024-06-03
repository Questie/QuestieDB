## Title: CameraOrSelectOrMoveStart

**Content:**
Begin "Left click" in the 3D world.
`CameraOrSelectOrMoveStart()`

**Description:**
This function is called when left-clicking in the 3-D world. It is most useful for selecting a target for a pending spell cast.
Calling this function clears the "mouseover" unit.
When used alone, puts you into a "mouselook" mode until `CameraOrSelectOrMoveStop` is called.