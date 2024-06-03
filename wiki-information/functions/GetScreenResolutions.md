## Title: GetScreenResolutions

**Content:**
Returns a list of available preset windowed screen resolutions.
`resolution1, resolution2, resolution3, ... = GetScreenResolutions()`

**Returns:**
- `resolutionN`
  - *string* - An available screen resolution as ___x___ (width .. "x" .. height).

**Description:**
Returns the list that appears in the resolution dropdown only while windowed mode is applied.
Unaffected by full screen or manually changing the window size.

**Usage:**
Prints a list of preset windowed resolutions.
```lua
local resolutions = {GetScreenResolutions()}
for i, entry in ipairs(resolutions) do
    print("Resolution" .. i .. ": " .. entry)
end
--[[
    Resolution 1: 800x600
    Resolution 2: 1024x760
    Resolution 3: 1280x1024
    ...
--]]
```

Gets the most-recently chosen preset as width and height.
```lua
local current = GetCurrentResolution()
if current then
    local width, height = string.match(select(current, GetScreenResolutions()), "(%d+)x(%d+)")
    print(width, height) -- 1920, 1080
end
```

**Reference:**
- `GetCurrentResolution()`
- `gxWindowedResolution`