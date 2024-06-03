## Title: SetCursor

**Content:**
Sets the current cursor texture.
`changed = SetCursor(cursor)`

**Parameters:**
- `cursor`
  - *string* - cursor to switch to; either a built-in cursor identifier (like "ATTACK_CURSOR"), path to a cursor texture (e.g. "Interface/Cursor/Taxi"), or `nil` to reset to a default cursor.

**Returns:**
- `changed`
  - *boolean* - always 1.

**Description:**
If the cursor is hovering over WorldFrame, the SetCursor function will have no effect - cursor is locked to reflect what the player is currently pointing at.
Texture paths may be suffixed by ".crosshair" to offset the position of the texture such that it will be centered on the cursor.
If called with an invalid argument, the cursor is replaced by a black square.