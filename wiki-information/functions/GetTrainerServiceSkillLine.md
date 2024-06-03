## Title: GetTrainerServiceSkillLine

**Content:**
Gets the name of the skill at the specified line from the current trainer.
`local skillLine = GetTrainerServiceSkillLine(index)`

**Parameters:**
- `index`
  - *number* - Index of the trainer service to get the name of. Note that indices are affected by the trainer filter. (See `GetTrainerServiceTypeFilter` and `SetTrainerServiceTypeFilter`.)

**Returns:**
- `skillLine`
  - *string* - The name of the skill on the specified line.