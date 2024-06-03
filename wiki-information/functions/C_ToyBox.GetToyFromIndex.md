## Title: C_ToyBox.GetToyFromIndex

**Content:**
Returns a toy by index.
`itemID = C_ToyBox.GetToyFromIndex(index)`

**Parameters:**
- `index`
  - *number* - Ranging from 1 to `C_ToyBox.GetNumFilteredToys`.

**Returns:**
- `itemID`
  - *number* - The Item ID of the toy. Returns -1 if the index is invalid.