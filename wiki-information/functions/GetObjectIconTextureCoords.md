## Title: GetObjectIconTextureCoords

**Content:**
Returns texture coordinates of an object icon.
`left, right, top, bottom = GetObjectIconTextureCoords(objectIcon)`

**Parameters:**
- `objectIcon`
  - *number* - index of the object icon to retrieve texture coordinates for, ascending from -2.

**Returns:**
- `left`
  - *number* - left edge of the specified icon, 0 for the texture's left edge and 1 for the texture's right edge.
- `right`
  - *number* - right edge of the specified icon, 0 for the texture's left edge and 1 for the texture's right edge.
- `top`
  - *number* - top edge of the specified icon, 0 for the texture's top edge and 1 for the texture's bottom edge.
- `bottom`
  - *number* - bottom edge of the specified icon, 0 for the texture's top edge and 1 for the texture's bottom edge.

**Description:**
Returns texture coordinates into `Interface\\MINIMAP\\OBJECTICONS.blp`, the minimap blip texture.