## Title: UnitCastingInfo

**Content:**
Returns information about the spell currently being cast by the specified unit.
`name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `name`
  - *string* - The name of the spell, or nil if no spell is being cast.
- `text`
  - *string* - The name to be displayed.
- `texture`
  - *string* - The texture path associated with the spell icon.
- `startTimeMS`
  - *number* - Specifies when casting began in milliseconds (corresponds to GetTime()*1000).
- `endTimeMS`
  - *number* - Specifies when casting will end in milliseconds (corresponds to GetTime()*1000).
- `isTradeSkill`
  - *boolean* - Specifies if the cast is a tradeskill.
- `castID`
  - *string* : GUID - The unique identifier for this spell cast, for example Cast-3-3890-1159-21205-8936-00014B7E7F.
- `notInterruptible`
  - *boolean* - if true, indicates that this cast cannot be interrupted with abilities like or . In default UI those spells have shield frame around their icons on enemy cast bars. Always returns nil in Classic.
- `spellId`
  - *number* - The spell's unique identifier. (Added in 7.2.5)

**Description:**
For channeled spells, `displayName` is "Channeling". So far `displayName` is observed to be the same as `name` in any other contexts.
This function may not return anything when the target is channeling spell post its warm-up period, you should use `UnitChannelInfo` in that case. It takes the same arguments and returns similar values specific to channeling spells.
In Classic, the alternative `CastingInfo()` is similar to `UnitCastingInfo("player")`.

**Related Events:**
- `UNIT_SPELLCAST_START`
- `UNIT_SPELLCAST_STOP`

**Related API:**
- `CastingInfo (Classic)`

**Usage:**
The following snippet prints the amount of time remaining before the player's current spell finishes casting.
```lua
local spell, _, _, _, endTime = UnitCastingInfo("player")
if spell then 
  local finish = endTimeMS/1000 - GetTime()
  print(spell .. " will be finished casting in " .. finish .. " seconds.")
end
```