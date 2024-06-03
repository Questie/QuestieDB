## Title: IsSubmerged

**Content:**
Returns whether the player character is submerged in water.
`isSubmerged = IsSubmerged()`

**Returns:**
- `isSwimming`
  - *boolean* - 1 if the player is submerged, nil otherwise.

**Description:**
This function is similar to `IsSwimming`, but also returns 1 when running at the bottom of a surface of water.
This function is available within the RestrictedEnvironment.

**Reference:**
- `IsSwimming`
- `IsFlying`