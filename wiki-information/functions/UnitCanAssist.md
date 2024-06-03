## Title: UnitCanAssist

**Content:**
Indicates whether the first unit can assist the second unit.
`canAssist = UnitCanAssist(unitToAssist, unitToBeAssisted)`

**Parameters:**
- `unitToAssist`
  - *UnitId* - the unit that would assist (e.g., "player" or "target")
- `unitToBeAssisted`
  - *UnitId* - the unit that would be assisted (e.g., "player" or "target")

**Returns:**
- `canAssist`
  - *boolean* - 1 if the unitToAssist can assist the unitToBeAssisted, nil otherwise.

**Usage:**
```lua
if (UnitCanAssist("player", "target")) then 
  DEFAULT_CHAT_FRAME:AddMessage("You can assist the target.")
else 
  DEFAULT_CHAT_FRAME:AddMessage("You cannot assist the target.")
end
```

**Miscellaneous:**
Result:
A message indicating whether the player can assist the current target is displayed in the default chat frame.

**Reference:**
- `UnitCanCooperate`