## Event: PET_BATTLE_PET_CHANGED

**Title:** PET BATTLE PET CHANGED

**Content:**
Fired when a team's active battle pet changes.
`PET_BATTLE_PET_CHANGED: owner`

**Payload:**
- `owner`
  - *number* - index of the team the active pet of which has changed.

**Content Details:**
C_PetBattles.GetActivePet returns the index of the new front-line pet when this event fires.