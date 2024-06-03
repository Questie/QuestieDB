## Title: C_PlayerInfo.GetSex

**Content:**
Returns the sex of a player.
`sex = C_PlayerInfo.GetSex(playerLocation)`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin*

**Returns:**
- `sex`
  - *Enum.UnitSex?*
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - Male
    - `1`
      - Female
    - `2`
      - None
    - `3`
      - Both
    - `4`
      - Neutral

**Usage:**
Returns the gender of your character.
```lua
/dump C_PlayerInfo.GetSex(PlayerLocation:CreateFromUnit("player")) -- 1 (Female)
```

**Reference:**
- `UnitSex()`