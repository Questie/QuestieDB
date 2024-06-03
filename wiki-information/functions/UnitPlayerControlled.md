## Title: UnitPlayerControlled

**Content:**
Returns true if the unit is controlled by a player.
`UnitIsPlayerControlled = UnitPlayerControlled(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `UnitIsPlayerControlled`
  - *boolean* - Returns true if the "unit" is controlled by a player. Returns false if the "unit" is an NPC.

**Usage:**
```lua
if (UnitPlayerControlled("target")) then
  DEFAULT_CHAT_FRAME:AddMessage("Your selected target is a player.", 1, 1, 0)
else
  DEFAULT_CHAT_FRAME:AddMessage("Your selected target is an NPC.", 1, 1, 0)
end
```

**Example Use Case:**
This function can be used in addons to determine if the player's current target is another player or an NPC. For instance, in PvP-focused addons, this check can be used to apply specific logic or display different information based on whether the target is a player or an NPC.

**Addons Using This Function:**
Many large addons, such as "Recount" and "Details! Damage Meter," use this function to differentiate between player-controlled units and NPCs when tracking combat statistics and displaying detailed combat logs.