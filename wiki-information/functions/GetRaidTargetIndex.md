## Title: GetRaidTargetIndex

**Content:**
Returns the raid target of a unit.
`index = GetRaidTargetIndex(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `index`
  - *number?*
    - **Value** - **Icon**
    - 1 - Yellow 4-point Star
    - 2 - Orange Circle
    - 3 - Purple Diamond
    - 4 - Green Triangle
    - 5 - White Crescent Moon
    - 6 - Blue Square
    - 7 - Red "X" Cross
    - 8 - White Skull

**Description:**
Raid target icons are typically displayed by unit frames, as well as above the marked entities in the 3D world. The targets can be assigned by raid leaders and assistants, party members, and the player while soloing, and are only visible to other players within the same group.
This function can return arbitrary values if the queried unit does not exist. Use `UnitExists()` to check whether a unit is valid.
For example: `"raid2target"` when `"raid2"` is offline and not targeting anything at all misbehaves.

**Related API:**
- `SetRaidTarget`

**Related Events:**
- `RAID_TARGET_UPDATE`

**Usage:**
Prints the raid target index for your target.
```lua
/dump GetRaidTargetIndex("target")
```

**Reference:**
- `RaidFlag`