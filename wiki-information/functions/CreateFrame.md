## Title: CreateFrame

**Content:**
Creates a Frame object.
`frame = CreateFrame(frameType)`

**Parameters:**
- `frameType`
  - *string* - Type of the frame; e.g. "Frame" or "Button".
- `name`
  - *string?* - Globally accessible name to assign to the frame, or nil for an anonymous frame.
- `parent`
  - *Frame?* - Parent object to assign to the frame, or nil to be parentless; cannot be a string. Can also be set with `Region:SetParent()`.
- `template`
  - *string?* - Comma-delimited list of virtual XML templates to inherit; see also a complete list of FrameXML templates.
- `id`
  - *number?* - ID to assign to the frame. Can also be set with `Frame:SetID()`.

**Returns:**
- `frame`
  - *Frame* - The created Frame object or one of the other frame type objects.

**Miscellaneous:**
Possible frame types are available from the XML schema:
- Frame
- ArchaeologyDigSiteFrame
- Browser
- Button
- CheckButton
- Checkout
- CinematicModel
- ColorSelect
- Cooldown
- DressUpModel
- EditBox
- FogOfWarFrame
- GameTooltip
- MessageFrame
- Model
- ModelScene
- MovieFrame
- OffScreenFrame
- PlayerModel
- QuestPOIFrame
- ScenarioPOIFrame
- ScrollFrame
- SimpleHTML
- Slider
- StatusBar
- TabardModel
- UnitPositionFrame

**Description:**
Fires the frame's OnLoad script, if it has one from an inherited template.
Frames cannot be deleted or garbage collected, so it may be preferable to reuse them.
Intrinsic frames may also be used.

**Usage:**
Shows a texture which is also parented to UIParent so it will have the same UI scale and hidden when toggled with Alt-Z
```lua
local f = CreateFrame("Frame", nil, UIParent)
f:SetPoint("CENTER")
f:SetSize(64, 64)
f.tex = f:CreateTexture()
f.tex:SetAllPoints(f)
f.tex:SetTexture("interface/icons/inv_mushroom_11")
```

Creates a button which inherits textures and widget scripts from UIPanelButtonTemplate
```lua
local btn = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
btn:SetPoint("CENTER")
btn:SetSize(100, 40)
btn:SetText("Click me")
btn:SetScript("OnClick", function(self, button, down)
    print("Pressed", button, down and "down" or "up")
end)
btn:RegisterForClicks("AnyDown", "AnyUp")
```

Displays an animated model for a DisplayID.
```lua
local m = CreateFrame("PlayerModel")
m:SetPoint("CENTER")
m:SetSize(200, 200)
m:SetDisplayInfo(21723) -- murloccostume.m2
```

Registers for events being fired, like chat messages and when you start/stop moving.
```lua
local function OnEvent(self, event, ...)
    print(event, ...)
end
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_CHANNEL")
f:RegisterEvent("PLAYER_STARTED_MOVING")
f:RegisterEvent("PLAYER_STOPPED_MOVING")
f:SetScript("OnEvent", OnEvent)
```

**Reference:**
- `CreateFramePool()`

**Example Use Case:**
CreateFrame is widely used in many addons to create various UI elements. For example, the popular addon "WeakAuras" uses `CreateFrame` to create custom frames for displaying auras and other visual indicators.