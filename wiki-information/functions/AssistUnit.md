## Title: AssistUnit

**Content:**
Assists the unit by targeting the same target.
`AssistUnit(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Description:**
If the player's target was changed by a Targeting Function, it is possible to restore the original target by assisting the player.

**Example Usage:**
```lua
-- Example of using AssistUnit to target the same target as the party leader
local partyLeader = "party1"
AssistUnit(partyLeader)
```

**Usage in Addons:**
- **HealBot**: This addon uses `AssistUnit` to allow healers to quickly assist the main tank or other party members, ensuring they can target the same enemy for healing or other actions.
- **Grid**: This raid unit frame addon can use `AssistUnit` to help players quickly switch targets to assist the main assist or tank in a raid environment.