## Title: GetScreenHeight

**Content:**
Returns the height of the window measured at UIParent scale (effectively the same as `UIParent:GetHeight()`).
`screenHeight = GetScreenHeight()`

**Returns:**
- `screenHeight`
  - *number* - Height of window at UIParent scale

**Usage:**
```lua
-- Note that the return value does not match the screen resolution set in the Video Options, but will instead represent a dimension with the same aspect ratio.
DEFAULT_CHAT_FRAME:AddMessage( ( GetScreenWidth() * UIParent:GetEffectiveScale() ).."x"..( GetScreenHeight() * UIParent:GetEffectiveScale() ) )
```

**Example Use Case:**
This function can be used to dynamically adjust UI elements based on the screen height. For instance, if you are developing a custom UI addon and need to position elements relative to the screen height, you can use `GetScreenHeight()` to get the current height and adjust your elements accordingly.

**Addons Using This Function:**
Many large addons, such as ElvUI and Bartender4, use this function to ensure their UI elements are correctly scaled and positioned according to the user's screen resolution and UI scale settings. This helps maintain a consistent and visually appealing interface across different screen sizes and resolutions.