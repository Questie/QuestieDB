## Title: SetPortraitTexture

**Content:**
Sets a texture to a unit's 2D portrait.
`SetPortraitTexture(textureObject, unitToken)`

**Parameters:**
- `textureObject`
  - *Texture* - The texture object to set the portrait on.
- `unitToken`
  - *string* - UnitToken representing the unit whose portrait is to be set.
- `disableMasking`
  - *boolean?* - Optional parameter, defaults to `false`.

**Usage:**
```lua
local f = CreateFrame("Frame")
f:SetPoint("CENTER")
f:SetSize(64, 64)
f.tex = f:CreateTexture()
f.tex:SetAllPoints(f)
SetPortraitTexture(f.tex, "player")
```

**Example Use Case:**
This function is commonly used in creating custom unit frames or UI elements that display character portraits. For instance, many unit frame addons like "Shadowed Unit Frames" or "PitBull Unit Frames" use this function to set the portrait textures for player, target, and party frames.