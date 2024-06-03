## Title: GetActionCooldown

**Content:**
Returns cooldown info for the specified action slot.
`start, duration, enable, modRate = GetActionCooldown(slot)`

**Parameters:**
- `slot`
  - *number* - The action slot to retrieve data from.

**Returns:**
- `start`
  - *number* - The time at which the current cooldown period began (relative to the result of GetTime), or 0 if the cooldown is not active or not applicable.
- `duration`
  - *number* - The duration of the current cooldown period in seconds, or 0 if the cooldown is not active or not applicable.
- `enable`
  - *number* - Indicates if cooldown is enabled, is greater than 0 if a cooldown could be active, and 0 if a cooldown cannot be active. This lets you know when a shapeshifting form has ended and the actual countdown has started.
- `modRate`
  - *number* - The rate at which the cooldown widget's animation should be updated.

**Usage:**
```lua
local start, duration, enable, modRate = GetActionCooldown(slot);
if ( start == 0 ) then
    -- do stuff when cooldown is not active
else
    -- do stuff when cooldown is under effect
end
```

**Example Use Case:**
This function is commonly used in addons that manage action bars, such as Bartender4 or Dominos, to display cooldown timers on action buttons. It helps players to know when they can use their abilities again by showing a visual cooldown overlay on the action buttons.