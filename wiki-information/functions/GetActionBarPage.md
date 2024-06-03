## Title: GetActionBarPage

**Content:**
Returns the current action bar page.
`index = GetActionBarPage()`

**Returns:**
- `index`
  - *number* - integer index of the current action bar page, ascending from 1.

**Description:**
The returned value reflects the player-selected action bar, which might not actually be available if overridden by a vehicle, mind control, temporary shapeshift, or other similar mechanics.
This function is available in the RestrictedEnvironment.
Can be queried using the macro conditional.
CURRENT_ACTIONBAR_PAGE is obsolete.