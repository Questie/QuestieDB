## Title: ItemTextGetMaterial

**Content:**
Returns the material texture for the item text.
`materialName = ItemTextGetMaterial()`

**Returns:**
- `materialName`
  - *string* - The name of the material to use for displaying the item text. If nil then the material is "Parchment".

**Description:**
This is used once the `ITEM_TEXT_READY` event has been received for a page.
See `FrameXML/ItemTextFrame.lua` for examples of how the material is used to select a set of textures.