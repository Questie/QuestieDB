## Title: GetTrainerServiceAbilityReq

**Content:**
Returns the name of a requirement for training a skill and if the player meets the requirement.
`ability, hasReq = GetTrainerServiceAbilityReq(trainerIndex, reqIndex)`

**Parameters:**
- `trainerIndex`
  - *number* - Index of the trainer service to retrieve information about. Note that indices are affected by the trainer filter. (See `GetTrainerServiceTypeFilter` and `SetTrainerServiceTypeFilter`.)
- `reqIndex`
  - *number* - Index of the requirement to retrieve information about.

**Returns:**
- `ability`
  - *string* - The name of the required ability. Not readily available on function call, see `SpellMixin:ContinueOnSpellLoad`.
- `hasReq`
  - *boolean* - Flag for if the player meets the requirement.