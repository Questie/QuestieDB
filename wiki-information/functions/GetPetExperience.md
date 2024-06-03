## Title: GetPetExperience

**Content:**
Returns the pet's current and total XP required for the next level.
`currXP, nextXP = GetPetExperience()`

**Returns:**
- `currXP`
  - *number* - The current XP total
- `nextXP`
  - *number* - The XP total required for the next level

**Usage:**
```lua
local currXP, nextXP = GetPetExperience();
DEFAULT_CHAT_FRAME:AddMessage("Pet experience: " .. currXP .. " / " .. nextXP);
```

**Miscellaneous:**
Result:
Pet experience is displayed in the default chat frame.