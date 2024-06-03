## Title: ExpandTrainerSkillLine

**Content:**
Expands a header in the trainer window, showing all spells below it.
`ExpandTrainerSkillLine(index)`

**Parameters:**
- `index`
  - *number* - The index of a line in the trainer window (if the supplied index is not a header, an error is produced).
  - Index 0 ("All") will expand all headers.
  - Note that indices are affected by the trainer filter, see `GetTrainerServiceTypeFilter()` and `SetTrainerServiceTypeFilter()`

**Reference:**
- `GetTrainerServiceInfo()`

**Example Usage:**
```lua
-- Expanding all headers in the trainer window
ExpandTrainerSkillLine(0)

-- Expanding a specific header by index
ExpandTrainerSkillLine(2)
```

**Additional Information:**
This function is useful in addons that manage or enhance the trainer window interface, such as those that provide additional filtering or sorting options for available skills.