## Title: SetRaidTarget

**Content:**
Assigns a raid target icon to a unit.
`SetRaidTarget(unit, index)`

**Parameters:**
- `unit`
  - *string* : UnitId
- `index`
  - *number* - Raid target index to assign to the specified unit:
    - `Value`
    - `Icon`
    - `1` - Yellow 4-point Star
    - `2` - Orange Circle
    - `3` - Purple Diamond
    - `4` - Green Triangle
    - `5` - White Crescent Moon
    - `6` - Blue Square
    - `7` - Red "X" Cross
    - `8` - White Skull

**Description:**
The icons are only visible to your group. In a 5-man party, all party members may assign raid icons. In a raid, only the raid leader and the assistants may do so.
This API toggles the icon if it's already assigned to the unit.
Units can only be assigned one icon at a time; and each icon can only be assigned to one unit at a time.

**Related API:**
- `GetRaidTargetIndex`

**Related Events:**
- `RAID_TARGET_UPDATE`

**Related FrameXML:**
- `SetRaidTargetIcon`

**Usage:**
To set a skull over your current target:
```lua
/run SetRaidTarget("target", 8)
```
Without toggling behavior:
```lua
/run if GetRaidTargetIndex("target") ~= 8 then SetRaidTarget("target", 8) end
```

**Reference:**
- `RaidFlag`