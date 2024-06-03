## Title: CanJoinBattlefieldAsGroup

**Content:**
Returns true if the player can join a battlefield with a group.
`isTrue = CanJoinBattlefieldAsGroup()`

**Returns:**
- `isTrue`
  - *boolean* - returns true, if the player can join the battlefield as group

**Usage:**
```lua
if (CanJoinBattlefieldAsGroup()) then
  JoinBattlefield(0, 1) -- join battlefield as group
else
  JoinBattlefield(0, 0) -- join battlefield as single player
end
```

**Result:**
Queries the player either as group or as single player.