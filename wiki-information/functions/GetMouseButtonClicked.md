## Title: GetMouseButtonClicked

**Content:**
Returns the mouse button responsible during an OnClick event (e.g. "RightButton").
`buttonName = GetMouseButtonClicked()`

**Returns:**
- `buttonName`
  - *string* - name of the button responsible for the innermost OnClick event. For example, "LeftButton"

**Description:**
The `buttonName` return value may be an arbitrary string (as the `Button:Click` method accepts arbitrary arguments).
If there are multiple OnClick handler dispatches on the call stack, information about the innermost one is returned.