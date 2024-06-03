## Title: GetLFGDeserterExpiration

**Content:**
Returns the time at which you may once again use the dungeon finder after prematurely leaving a group.
`expiryTime = GetLFGDeserterExpiration()`

**Returns:**
- `expiryTime`
  - *number?* - time (GetTime() value) at which you may once again use the dungeon finder; nil if you're not currently under the effects of the deserter penalty.

**Reference:**
- `GetLFGRandomCooldownExpiration`
- `UnitHasLFGDeserter`

**Example Usage:**
```lua
local expiryTime = GetLFGDeserterExpiration()
if expiryTime then
    print("You can use the dungeon finder again at: " .. date("%Y-%m-%d %H:%M:%S", expiryTime))
else
    print("You are not currently under the deserter penalty.")
end
```

**Addons Using This Function:**
- **DBM (Deadly Boss Mods):** Utilizes this function to inform players about their deserter status and when they can rejoin the dungeon finder.
- **ElvUI:** Uses this function to display cooldown timers for various penalties, including the deserter debuff, in its user interface.