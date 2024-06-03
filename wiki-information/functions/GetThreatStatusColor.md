## Title: GetThreatStatusColor

**Content:**
Returns the color for a threat status.
`r, g, b = GetThreatStatusColor(status)`

**Parameters:**
- `status`
  - *number* - Usually the return of `UnitThreatSituation`

**Returns:**
- `r`
  - *number* - a value between 0 and 1 for the red content of the color
- `g`
  - *number* - a value between 0 and 1 for the green content of the color
- `b`
  - *number* - a value between 0 and 1 for the blue content of the color

**Description:**
Usually returns one of the following:
- 1: 1.00, 1.00, 0.47 (yellow)
- 2: 1.00, 0.60, 0.00 (orange)
- 3: 1.00, 0.00, 0.00 (red)

Other values observed in the wild, but these situations do not occur in the default UI:
- 0: 0.69, 0.69, 0.69 (grey)
- 4 to 4294967294: 1.00, 0.00, 1.00 (magenta)
- 4294967295: 1.00, 1.00, 1.00 (white)

**Usage:**
Prints a description of the player's threat situation to the chat frame, colored appropriately. e.g.
```lua
local statustxts = { "low on threat", "overnuking", "losing threat", "tanking securely" }
local status = UnitThreatSituation("player", "target") -- returns nil, 0, 1, 2 or 3
if (status) then
    local r, g, b = GetThreatStatusColor(status)
    print(status .. ": You are " .. statustxts[status + 1] .. ".", r, g, b)
else
    print("nil: You are not on their threat table.")
end
```
Results in one of the following:
- 0: You are low on threat.
- 1: You are overnuking.
- 2: You are losing threat.
- 3: You are tanking securely.
- nil: You are not on their threat table.

**Reference:**
[API UnitDetailedThreatSituation](https://wowpedia.fandom.com/wiki/API_UnitDetailedThreatSituation)