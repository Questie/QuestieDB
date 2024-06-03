## Title: GetFramerate

**Content:**
Returns the current framerate.
`framerate = GetFramerate()`

**Returns:**
- `framerate`
  - *number* - The current framerate in frames per second.

**Usage:**
```lua
local framerate = GetFramerate()
print("Your current framerate is "..floor(framerate).." fps")
```

**Description:**
Notice the returned value adjusts slowly when the FPS quickly drops from 60 to 6, for example. If the FPS drops very fast, this function will be decreasing to 40, 20, 15, etc, for the next couple of seconds until it reaches 6. This delay means it is not as accurate as third-party FPS programs, but still functional. Alternatively, no delay is seen when the FPS is increased quickly.

You can also toggle the Framerate Display with `ToggleFramerate` (normally the Ctrl-R hotkey). You can also see the same framerate in the tooltip of the GameMenu button on the main action bar.