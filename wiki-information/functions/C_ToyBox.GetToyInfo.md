## Title: C_ToyBox.GetToyInfo

**Content:**
Returns toy info.
`itemID, toyName, icon, isFavorite, hasFanfare, itemQuality = C_ToyBox.GetToyInfo(itemID)`

**Parameters:**
- `itemID`
  - *number* - The itemID returned from `C_ToyBox.GetToyFromIndex()`; possible values listed at ToyID.

**Returns:**
- `itemID`
  - *number* - The Item ID of the toy.
- `toyName`
  - *string* - The name of the toy.
- `icon`
  - *number* - The icon texture (FileID).
- `isFavorite`
  - *boolean* - Whether the toy is set to favorite.
- `hasFanfare`
  - *boolean* - Shows a highlight for the toy.
- `itemQuality`
  - *Enum.ItemQuality*