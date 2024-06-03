## Title: GetSummonFriendCooldown

**Content:**
Returns the cooldown info of the RaF Summon Friend ability.
`start, duration = GetSummonFriendCooldown()`

**Returns:**
- `start`
  - *number* - The value of `GetTime()` at the moment the cooldown began, 0 if the ability is ready
- `duration`
  - *number* - The length of the cooldown in seconds, 0 if the ability is ready

**Usage:**
The snippet below prints the remaining time of the cooldown in seconds.
```lua
local start, duration = GetSummonFriendCooldown()
local timeleft = start + duration - GetTime()
print(timeleft)
```