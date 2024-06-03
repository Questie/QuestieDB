## Title: ConfirmLootRoll

**Content:**
Confirms a loot roll.
`ConfirmLootRoll(rollID)`

**Parameters:**
- `rollID`
  - *number* - As passed by the event. (The number increases with every roll you have in a party)
- `roll`
  - *number* - Type of roll: (also passed by the event)
    - `1` : Need roll
    - `2` : Greed roll
    - `3` : Disenchant roll

**Usage:**
```lua
local f = CreateFrame("Frame", "MyAddon")
f:RegisterEvent("CONFIRM_LOOT_ROLL")
f:SetScript("OnEvent", function(self, event, ...)
  if event == "CONFIRM_LOOT_ROLL" then
    local rollID, roll = ...
    ConfirmLootRoll(rollID, roll)
  end
end)
```

**Reference:**
- `CONFIRM_LOOT_ROLL`
- `CONFIRM_DISENCHANT_ROLL`