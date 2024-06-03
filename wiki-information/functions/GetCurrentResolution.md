## Title: GetCurrentResolution

**Content:**
Returns the index of the current screen resolution.
`index = GetCurrentResolution()`

**Parameters:**
- Nothing

**Returns:**
- `index`
  - *number* - This value will be the index of one of the values yielded by `GetScreenResolutions()`

**Usage:**
```lua
message('The current screen resolution is ' .. ({GetScreenResolutions()})[GetCurrentResolution()])
```
Output:
```
The current screen resolution is 1024x768
```