## Title: C_System.GetFrameStack

**Content:**
Returns an array of all UI objects under the mouse cursor, as would be exposed through the frame stack tooltip. The returned table is ordered from highest object level to lowest.
`objects = C_System.GetFrameStack()`

**Returns:**
- `objects`
  - *ScriptRegion* - A table of all UI objects under the mouse cursor, ordered from highest object level to lowest.