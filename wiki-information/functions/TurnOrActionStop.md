## Title: TurnOrActionStop

**Content:**
Stops a "right click" in the 3D game world.
`TurnOrActionStop()`

**Description:**
This function is called when right-clicking in the 3D world. Most useful, it can initiate an attack on the selected unit if no move occurs. When used alone, it can cancel a "mouseturn" started by a call to `TurnOrActionStart`.

**IMPORTANT:** The normal restrictions regarding hardware event initiations still apply to anything this function might do.