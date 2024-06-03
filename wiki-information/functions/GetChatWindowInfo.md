## Title: GetChatWindowInfo

**Content:**
Returns info for a chat window.
`name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(frameIndex)`

**Parameters:**
- `frameIndex`
  - *number* - The index of the chat window to get information for (starts at 1).

**Returns:**
- `name`
  - *string* - The name of the chat window, or an empty string for its default name.
- `fontSize`
  - *number* - The font size for the window.
- `r`
  - *number* - The red component of the window's background color (0.0 - 1.0).
- `g`
  - *number* - The green component of the window's background color (0.0 - 1.0).
- `b`
  - *number* - The blue component of the window's background color (0.0 - 1.0).
- `alpha`
  - *number* - The alpha level (opacity) of the window background (0.0 - 1.0).
- `shown`
  - *number* - 1 if the window is shown, 0 if it is hidden.
- `locked`
  - *number* - 1 if the window is locked in place, 0 if it is movable.
- `docked`
  - *number* - 1 to NUM_CHAT_WINDOWS; Index Order of docked tab EG: General = 1, Combat Log = 2. nil if floating.
- `uninteractable`
  - *number* - 1 if the window is uninteractable, 0 if it is interactable.

**Usage:**
```lua
local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);
```

**Description:**
Retrieves Chat Window configuration information. This is what FrameXML uses to know how to display the actual windows. This configuration information is set via the `SetChatWindow...()` family of functions which causes the "UPDATE_CHAT_WINDOWS" event to fire. FrameXML calls `GetChatWindowInfo()` when it receives this event.
`frameIndex` can be any chat window index between 1 and NUM_CHAT_WINDOWS. `1` is the main chat window.