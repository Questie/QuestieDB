## Title: GetActionBarToggles

**Content:**
Returns the enabled states for the extra action bars.
`bottomLeftState, bottomRightState, sideRightState, sideRight2State = GetActionBarToggles()`

**Returns:**
- `bottomLeftState`
  - *Flag* - 1 if the left-hand bottom action bar is shown, nil otherwise.
- `bottomRightState`
  - *Flag* - 1 if the right-hand bottom action bar is shown, nil otherwise.
- `sideRightState`
  - *Flag* - 1 if the first (outer) right side action bar is shown, nil otherwise.
- `sideRight2State`
  - *Flag* - 1 if the second (inner) right side action bar is shown, nil otherwise.