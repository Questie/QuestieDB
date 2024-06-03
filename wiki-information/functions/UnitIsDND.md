## Title: UnitIsDND

**Content:**
Returns true if a unit is DND (Do not disturb).
`isDND = UnitIsDND(unit)`

**Parameters:**
- `unit`
  - The UnitId to return DND status of.

**Returns:**
- `isDND`
  - 1 if unit is DND, nil otherwise.

**Usage:**
If the player is DND, the following script outputs "You are DND" to the default chat window.
```lua
if UnitIsDND("player") then
  DEFAULT_CHAT_FRAME:AddMessage("You are DND");
end
```