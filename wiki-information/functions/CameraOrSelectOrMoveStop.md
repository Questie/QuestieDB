## Title: CameraOrSelectOrMoveStop

**Content:**
Called when you release the "Left-Click" mouse button.
`CameraOrSelectOrMoveStop()`

**Parameters:**
- `stickyFlag`
  - *Flag (optional)* - If present and set then any camera offset is 'sticky' and remains until explicitly cancelled.

**Description:**
This function is called when left-clicking in the 3-D world.
When used alone, it can cancel a "mouselook" started by a call to `CameraOrSelectOrMoveStart`.
**IMPORTANT:** The normal restrictions regarding hardware event initiations still apply to anything this function might do.