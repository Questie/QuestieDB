## Title: CheckInteractDistance

**Content:**
Returns true if the player is in range to perform a specific interaction with the unit.
`inRange = CheckInteractDistance(unit, distIndex)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to compare distance to.
- `distIndex`
  - *number* - A value from 1 to 5:
    - 1 = Compare Achievements, 28 yards
    - 2 = Trade, 8 yards
    - 3 = Duel, 7 yards
    - 4 = Follow, 28 yards
    - 5 = Pet-battle Duel, 7 yards

**Returns:**
- `inRange`
  - *boolean* - 1 if you are in range to perform the interaction, nil otherwise.

**Description:**
If "unit" is a hostile unit, the return values are the same. But you obviously won't be able to do things like Trade.

**Usage:**
```lua
if ( CheckInteractDistance("target", 4) ) then
    FollowUnit("target");
else
    -- we're too far away to follow the target
end
```

**Example Use Case:**
This function can be used in addons that need to check if a player is within a certain range to perform actions like trading, dueling, or following another player. For instance, an addon that automates following a party member would use this function to ensure the player is close enough to follow the target.

**Addons Using This Function:**
Many large addons, such as "Questie" and "Zygor Guides," use this function to determine if the player is within range to interact with NPCs or other players for quest objectives or guide steps.