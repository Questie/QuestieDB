## Title: C_Social.GetScreenshotInfoByIndex

**Content:**
Returns the display resolution of a screenshot.
`screenWidth, screenHeight = C_Social.GetScreenshotInfoByIndex(index)`

**Parameters:**
- `index`
  - *number* - index of the screenshot. Does not persist between sessions.

**Returns:**
- `screenWidth`
  - *number* - width of the screen in pixels.
- `screenHeight`
  - *number* - height of the screen in pixels.

**Usage:**
Prints the screenshot information of this session.
```lua
for i = 1, C_Social.GetLastScreenshotIndex() do
    local width, height = C_Social.GetScreenshotInfoByIndex(i)
    print(i, width, height)
end
```