## Title: IsSwimming

**Content:**
Returns true if the character is currently swimming.
`isSwimming = IsSwimming()`

**Returns:**
- `isSwimming`
  - *boolean* - 1 if the player is swimming, nil otherwise.

**Description:**
A swimming character's movement speed is based on their swim speed (per `GetUnitSpeed`).
In some locations and when affected by certain effects, player characters can run at the bottom of the ocean/lake/etc. In those cases, the player is not considered swimming (but is still submerged per `IsSubmerged`).
This function is available within the RestrictedEnvironment.

**Reference:**
- `IsSubmerged`
- `IsFlying`