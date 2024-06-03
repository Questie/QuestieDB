## Title: GetPetActionCooldown

**Content:**
Returns cooldown info for an action on the pet action bar.
`startTime, duration, enable = GetPetActionCooldown(index)`

**Parameters:**
- `index`
  - *number* - The index of the pet action button you want to query for cooldown info.

**Returns:**
- `startTime`
  - *number* - The time when the cooldown started (as returned by GetTime()) or zero if no cooldown
- `duration`
  - *number* - The number of seconds the cooldown will last, or zero if no cooldown
- `enable`
  - *boolean* - 0 if no cooldown, 1 if cooldown is in effect (probably)

**Example Usage:**
```lua
local index = 1 -- Example index for the first pet action button
local startTime, duration, enable = GetPetActionCooldown(index)
if enable == 1 then
    print("Cooldown started at:", startTime)
    print("Cooldown duration:", duration)
else
    print("No cooldown in effect.")
end
```

**Additional Information:**
This function is commonly used in addons that manage pet abilities, such as those for hunters and warlocks. For example, the popular addon "PetTracker" might use this function to display cooldowns for pet abilities on the action bar.