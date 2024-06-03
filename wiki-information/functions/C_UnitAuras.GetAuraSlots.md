## Title: C_UnitAuras.GetAuraSlots

**Content:**
Needs summary.
`outContinuationToken, slots = C_UnitAuras.GetAuraSlots(unitToken, filter)`

**Parameters:**
- `unitToken`
  - *string* - UnitToken
- `filter`
  - *string*
- `maxSlots`
  - *number?*
- `continuationToken`
  - *number?*

**Returns:**
- `outContinuationToken`
  - *number?* - (Variable returns)
- `slots`
  - *number*

**Description:**
This function is used to retrieve the aura slots for a given unit. The `unitToken` parameter specifies the unit whose auras are being queried, and the `filter` parameter allows for filtering specific types of auras (e.g., "HELPFUL", "HARMFUL"). The `maxSlots` and `continuationToken` parameters are optional and can be used to handle large numbers of auras by paginating the results.

**Example Usage:**
```lua
local unitToken = "player"
local filter = "HELPFUL"
local maxSlots = 40
local continuationToken = nil

continuationToken, slots = C_UnitAuras.GetAuraSlots(unitToken, filter, maxSlots, continuationToken)

for i, slot in ipairs(slots) do
    local aura = C_UnitAuras.GetAuraDataBySlot(unitToken, slot)
    print(aura.name, aura.duration)
end
```

**Addons Using This Function:**
- **WeakAuras**: This popular addon uses `C_UnitAuras.GetAuraSlots` to track and display buffs and debuffs on units, allowing players to create custom visual and audio alerts based on aura conditions.
- **ElvUI**: This comprehensive UI replacement addon uses the function to manage and display unit auras in its unit frames, providing players with detailed information about buffs and debuffs on themselves and their targets.