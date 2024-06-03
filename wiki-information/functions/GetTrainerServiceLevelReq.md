## Title: GetTrainerServiceLevelReq

**Content:**
Returns the required level to learn a skill from the trainer.
`reqLevel = GetTrainerServiceLevelReq(id)`

**Parameters:**
- `id`
  - *number* - Index of the trainer service to retrieve information about. Note that indices are affected by the trainer filter. (See `GetTrainerServiceTypeFilter` and `SetTrainerServiceTypeFilter`.)

**Returns:**
- `reqLevel`
  - *number* - The required level (for pet or player) to learn the skill.