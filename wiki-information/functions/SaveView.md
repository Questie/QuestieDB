## Title: SaveView

**Content:**
Saves a camera angle. The last position loaded is stored in the CVar `cameraView`.
`SaveView(viewIndex)`

**Parameters:**
- `viewIndex`
  - *number* - The index (2-5) to save the camera angle to. (1 is reserved for first person view)

**Description:**
Saved views are preserved across sessions.
Use `ResetView(viewIndex)` to reset a view to its default.
The last position loaded is stored in the CVar `cameraView`.
The game's camera following style is not applied while you are in a saved view. (See: [Camera Following Style Problem/Bug](https://us.forums.blizzard.com/en/wow/t/camera-following-style-problembug/442862/17))

**Miscellaneous:**
Fixed: A bug in 3.0-patches causes SaveView variables not to load the first time you load a character after entering the game.
Reloading the UI, or reloading the character from the character selection screen, will fix this bug. Source