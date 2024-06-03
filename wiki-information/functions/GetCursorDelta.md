## Title: GetCursorDelta

**Content:**
Returns the distance that the cursor has moved since the last frame.
`x, y = GetCursorDelta()`

**Returns:**
- `x`
  - *number* - Distance along the X axis that the cursor has travelled.
- `y`
  - *number* - Distance along the Y axis that the cursor has travelled.

**Description:**
If the cursor hasn't moved between two frames, this function will return zeroes.
Values returned by this function are independent of UI scaling. The `GetScaledCursorDelta` utility function can be used to apply the effective scale of `UIParent` to the returned values.