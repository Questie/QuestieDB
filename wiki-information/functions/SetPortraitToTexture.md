## Title: SetPortraitToTexture

**Content:**
Applies a circular mask to a texture, making it resemble a portrait.
`SetPortraitToTexture(texture, path)`

**Parameters:**
- `texture`
  - *Texture*
- `path`
  - *string|number* : fileID

**Description:**
This function only accepts texture assets that have dimensions of 64x64 or smaller. Larger textures will raise a "Texture is not 64x64 pixels" error.
For larger textures, consider instead using MaskTexture objects which do not suffer from this same limitation.

**Usage:**
```lua
local f = CreateFrame("Frame")
f:SetPoint("CENTER")
f:SetSize(64, 64)
f.tex = f:CreateTexture()
f.tex:SetAllPoints(f)
SetPortraitToTexture(f.tex, "interface/icons/inv_mushroom_11")
```

**Reference:**
- MaskTexture