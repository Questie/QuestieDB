## Title: IsMouseButtonDown

**Content:**
Returns whether a mouse button is being held down.
`isDown = IsMouseButtonDown()`

**Parameters:**
- `button`
  - *string?* - Name of the button. If not passed, then it returns if any mouse button is pressed.
  - Possible values: `LeftButton`, `RightButton`, `MiddleButton`, `Button4`, `Button5`

**Returns:**
- `isDown`
  - *boolean* - Returns whether the given mouse button is held down.