## Title: GetMouseFocus

**Content:**
Returns the frame that currently has mouse focus.
`frame = GetMouseFocus()`

**Returns:**
- `frame`
  - *Frame* - The frame that currently has the mouse focus.

**Description:**
The frame must have `enableMouse="true"`

**Usage:**
You can get the name of the mouse-enabled frame beneath the pointer with this:
```lua
/dump GetMouseFocus():GetName() -- WorldFrame
```