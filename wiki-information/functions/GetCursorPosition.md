## Title: GetCursorPosition

**Content:**
Returns the cursor's position on the screen.
`x, y = GetCursorPosition()`

**Returns:**
- `x`
  - *number* - x coordinate unaffected by UI scale; 0 at the left edge of the screen.
- `y`
  - *number* - y coordinate unaffected by UI scale; 0 at the bottom edge of the screen.

**Description:**
Returns scale-independent coordinates similar to `Cursor:GetCenter()` if 'Cursor' was a valid frame not affected by scaling.
Assuming `UIParent` spans the entire screen, you can convert these coordinates to `UIParent` offsets by dividing by its effective scale. The following snippet positions a small texture at the cursor's location.

```lua
local uiScale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition()
local tex = UIParent:CreateTexture()
tex:SetTexture(1,1,1)
tex:SetSize(4,4)
tex:SetPoint("CENTER", nil, "BOTTOMLEFT", x / uiScale, y / uiScale)
```

**Example Usage:**
This function is often used in addons that need to track the cursor's position for custom UI elements or interactions. For instance, an addon that creates custom tooltips or context menus at the cursor's location would use `GetCursorPosition` to determine where to display these elements.

**Addons Using This Function:**
Many large addons, such as ElvUI and WeakAuras, utilize `GetCursorPosition` to enhance user interaction by dynamically positioning UI elements relative to the cursor. For example, WeakAuras might use it to display configuration options or visual effects at the cursor's location during setup.