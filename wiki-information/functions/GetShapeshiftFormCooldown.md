## Title: GetShapeshiftFormCooldown

**Content:**
Returns cooldown information for a specified form.
`startTime, duration, isActive = GetShapeshiftFormCooldown(index)`

**Parameters:**
- `index`
  - *number* - Index of the desired form

**Returns:**
- `startTime`
  - *number* - Cooldown start time (per GetTime) in seconds.
- `duration`
  - *number* - Cooldown duration in seconds.
- `isActive`
  - *boolean* - Returns 1 if the cooldown is running, nil if it isn't

**Usage:**
Displays the seconds remaining on the shapeshift form at index 1 or "Not Active" if there's no cooldown on that form.
```lua
local startTime, duration, isActive = GetShapeshiftFormCooldown(1)
if isActive then
  print("Not Active")
else
  print(string.format("Form 1 has %f seconds remaining", startTime + duration - GetTime()))
end
```