## Title: SetActionBarToggles

**Content:**
Sets the visible state for each action bar.
`SetActionBarToggles(bottomLeftState, bottomRightState, sideRightState, sideRight2State, alwaysShow)`

**Parameters:**
- `bottomLeftState`
  - *Flag* - 1 if the left-hand bottom action bar is to be shown, 0 or nil otherwise.
- `bottomRightState`
  - *Flag* - 1 if the right-hand bottom action bar is to be shown, 0 or nil otherwise.
- `sideRightState`
  - *Flag* - 1 if the first (outer) right side action bar is to be shown, 0 or nil otherwise.
- `sideRight2State`
  - *Flag* - 1 if the second (inner) right side action bar is to be shown, 0 or nil otherwise.
- `alwaysShow`
  - *Flag* - 1 if the bars are always shown, 0 or nil otherwise.

**Description:**
Note that this doesn't actually change the action bar states directly, it simply registers the desired states for the next time the game is loaded. The states during play are in the variables `SHOW_MULTI_ACTIONBAR_1`, `SHOW_MULTI_ACTIONBAR_2`, `SHOW_MULTI_ACTIONBAR_3`, `SHOW_MULTI_ACTIONBAR_4`, and reflected by calling `MultiActionBar_Update()`.