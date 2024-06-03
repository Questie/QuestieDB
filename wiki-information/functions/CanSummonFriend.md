## Title: CanSummonFriend

**Content:**
Returns whether you can RaF summon a particular unit.
`summonable = CanSummonFriend(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The player to check whether you can summon.

**Returns:**
- `summonable`
  - *boolean* - 1 if you can summon the unit using RaF, nil otherwise.

**Usage:**
The snippet below checks whether you can summon the target, and, if so, whispers and summons her to you.
```lua
local t = "target"; 
if CanSummonFriend(t) then 
  SendChatMessage("I am summoning you!", "WHISPER", nil, t) 
  SummonFriend(t) 
end
```