## Title: C_MountJournal.Pickup

**Content:**
Picks up the specified mount onto the cursor, usually in preparation for placing it on an action button.
`C_MountJournal.Pickup(displayIndex)`

**Parameters:**
- `displayIndex`
  - *number* - Index of the mount, in the range of 1 to `C_MountJournal.GetNumMounts()` (inclusive), or 0 to pick up the "Summon Random Favorite Mount" button.

**Description:**
- Triggers `CURSOR_UPDATE` to indicate that the contents of the cursor have changed.
- Triggers `ACTIONBAR_SHOWGRID` to indicate that the outlines of empty action bar buttons are now being displayed.
- Does nothing if the specified index is out of bounds or belongs to a mount that the player has not collected.
- When a mount is on the cursor, `GetCursorInfo()` returns `"mount", <mountActionID>` where `<mountActionID>` is the same as the second value returned by `GetActionInfo()` for an action button containing the same mount.
- When the "Summon Random Favorite Mount" button is on the cursor or action button, the `mountActionID` is 268435455.

**Reference:**
- `ClearCursor()`
- `GetCursorInfo()`
- `PlaceAction()`

**Example Usage:**
This function can be used in macros or addons to allow players to easily place mounts on their action bars. For instance, an addon could provide a user interface for managing mounts and use `C_MountJournal.Pickup` to let players drag and drop mounts onto their action bars.

**Addon Usage:**
Large addons like Bartender4 or Dominos, which provide extensive customization of action bars, might use this function to facilitate the placement of mounts on action buttons. This allows users to manage their mounts directly from the addon’s interface.