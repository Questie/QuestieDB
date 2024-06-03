## Title: GetScreenWidth

**Content:**
Returns the width of the window measured at UIParent scale (effectively the same as `UIParent:GetWidth()`).
`screenWidth = GetScreenWidth()`

**Returns:**
- `screenWidth`
  - *number* - Width of window at UIParent scale

**Usage:**
```lua
-- Note that the return value does not match the screen resolution set in the Video Options, but will instead represent a dimension with the same aspect ratio.
DEFAULT_CHAT_FRAME:AddMessage( ( GetScreenWidth() * UIParent:GetEffectiveScale() ).."x"..( GetScreenHeight() * UIParent:GetEffectiveScale() ) )
```