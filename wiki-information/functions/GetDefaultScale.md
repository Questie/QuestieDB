## Title: GetDefaultScale

**Content:**
Returns the default UI scaling value for the current screen size.
`scale = GetDefaultScale()`

**Returns:**
- `scale`
  - *number* - The default scale for the UI as a floating point value.

**Usage:**
The below example creates an unparented frame that will always render at a size of 300x300 pixels. The scale of the frame is managed through the inherited DefaultScaleFrame template, which internally uses this API to apply the correct scale to the frame if the screen size changes.
```lua
UnscaledFrame = CreateFrame("Frame", nil, nil, "BackdropTemplate, DefaultScaleFrame")
UnscaledFrame:SetPoint("CENTER")
UnscaledFrame:SetSize(300, 300)
UnscaledFrame:SetBackdrop({ bgFile = "" })
```