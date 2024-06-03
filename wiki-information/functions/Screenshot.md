## Title: Screenshot

**Content:**
Takes a screenshot.
`Screenshot()`

**Description:**
- **Name:** Saves a file with the following format: `WoWScrnShot_MMDDYY_HHMMSS.jpg`
- **Path:** `"...\\World of Warcraft\\_retail_\\Screenshots"`
- **Format:** The format is controlled by CVar `screenshotFormat` which can be set to `"jpeg"` (default), `"png"` or `"tga"`.

**Usage:**
`/run Screenshot()`

### Example Use Case:
This function can be used to programmatically take a screenshot in-game, which can be useful for addons that need to capture the screen at specific moments, such as for automated documentation or bug reporting tools.

### Addons:
Many large addons, such as WeakAuras, might use this function to capture screenshots when certain events occur, helping players to document their gameplay or share specific moments with others.