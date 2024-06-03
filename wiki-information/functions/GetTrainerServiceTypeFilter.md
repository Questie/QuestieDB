## Title: GetTrainerServiceTypeFilter

**Content:**
Returns the status of a skill filter in the trainer window.
`status = GetTrainerServiceTypeFilter(type)`

**Parameters:**
- `type`
  - *string* - Possible values:
    - `"available"`
    - `"unavailable"`
    - `"used"` (already known)

**Returns:**
- `status`
  - *boolean* - true if currently displaying trainer services of the specified type, false otherwise.