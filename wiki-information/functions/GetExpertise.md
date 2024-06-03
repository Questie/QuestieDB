## Title: GetExpertise

**Content:**
Returns the player's expertise percentage for main hand, offhand, and ranged attacks.
`mainhandExpertise, offhandExpertise, rangedExpertise = GetExpertise()`

**Returns:**
- `mainhandExpertise`
  - *number* - Expertise percentage for swings with your main hand weapon.
- `offhandExpertise`
  - *number* - Expertise percentage for swings with your offhand weapon.
- `rangedExpertise`
  - *number* - Expertise percentage for your ranged weapon.

**Description:**
Expertise reduces the chance that the player's attacks are dodged or parried by an enemy. This function returns the amount of percentage points Expertise reduces the dodge/parry chance by (e.g. a return value of 3.5 means a 3.5% reduction to both dodge and parry probabilities).

**Reference:**
`GetCombatRating(CR_EXPERTISE)`