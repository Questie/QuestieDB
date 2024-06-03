## Title: CreateFont

**Content:**
Creates a Font object.
`fontObject = CreateFont(name)`

**Parameters:**
- `name`
  - *string* - Globally-accessible name to be assigned for use as `_G`.

**Returns:**
- `fontObject`
  - *Font* - Reference to the new font object.

**Description:**
Font objects, similar to XML `<Font>` elements, may be used to create a common font pattern assigned to several widgets via `FontInstance:SetFontObject(fontObject)`.
Subsequently changing the font object will affect the text displayed on every widget it was assigned to.
Since the new font object is created without any properties, it should be initialized via `FontInstance:SetFont(path, height)` or `Font:CopyFontObject(otherFont)`.

**Example Usage:**
```lua
local myFont = CreateFont("MyFont")
myFont:SetFont("Fonts\\FRIZQT__.TTF", 12)
myText:SetFontObject(myFont)
```

**Addons Using This:**
Many large addons, such as ElvUI and WeakAuras, use `CreateFont` to create custom font objects for consistent text styling across various UI elements. For example, ElvUI uses it to ensure that all text elements adhere to the user's chosen font settings, providing a cohesive look and feel.