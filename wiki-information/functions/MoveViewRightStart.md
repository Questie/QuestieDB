## Title: MoveViewRightStart

**Content:**
Starts rotating the camera to the right.
`MoveViewRightStart(speed)`

**Parameters:**
- `speed`
  - *number* - Speed at which to begin rotating.

**Returns:**
Nothing

**Usage:**
```lua
MoveViewRightStart(90/tonumber(GetCVar("cameraYawMoveSpeed"))) -- rotate camera to the right at 90 degrees/second
```

**Description:**
Speed is a multiplier on the CVar 'cameraYawMoveSpeed', which is in degrees/second.
If speed is omitted, it is assumed to be 1.0.
Negative numbers go the opposite way, a speed of 0.0 will stop it.
This is not canceled by moving your character or interacting with the camera.
Applying a negative speed is not the same as using the other function to go the opposite way, both vectors are applied simultaneously. If you rotate both ways equally, it will appear to stop, but the rotations are still being applied, though canceling each other.