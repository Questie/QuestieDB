## Title: TurnOrActionStart

**Content:**
Starts a "right click" in the 3D game world.
`TurnOrActionStart()`

**Description:**
This function is called when right-clicking in the 3D world.
Calling this function clears the "mouseover" unit.
When used alone, puts you into a "mouseturn" mode until `TurnOrActionStop` is called.
**IMPORTANT:** The normal restrictions regarding hardware event initiations still apply to anything this function might do.