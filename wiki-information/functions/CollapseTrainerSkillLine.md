## Title: CollapseTrainerSkillLine

**Content:**
Collapses a header in the trainer window, hiding all spells below it.
`CollapseTrainerSkillLine(index)`

**Parameters:**
- `index`
  - *number* - The index of a line in the trainer window (if the supplied index is not a header, an error is produced).
  - Index 0 ("All") will collapse all headers.
  - Note that indices are affected by the trainer filter, see `GetTrainerServiceTypeFilter()` and `SetTrainerServiceTypeFilter()`

**Usage:**
Collapses all trainer headers. This can also be done by using index 0 instead.
```lua
for i = 1, GetNumTrainerServices() do
    local category = select(3, GetTrainerServiceInfo(i))
    if category == "header" then
        CollapseTrainerSkillLine(i)
    end
end
```

**Reference:**
- `GetTrainerServiceInfo()`