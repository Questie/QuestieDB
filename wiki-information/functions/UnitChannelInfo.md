## Title: UnitChannelInfo

**Content:**
Returns information about the spell currently being channeled by the specified unit.
`name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, notInterruptible, spellID, isEmpowered, numEmpowerStages = UnitChannelInfo(unitToken)`

**Parameters:**
- `unitToken`
  - *string* : UnitId

**Returns:**
- `name`
  - *string* - The name of the spell, or nil if no spell is being channeled.
- `displayName`
  - *string* - The name to be displayed.
- `textureID`
  - *string* - The texture path associated with the spell icon.
- `startTimeMs`
  - *number* - Specifies when channeling began, in milliseconds (corresponds to GetTime()*1000).
- `endTimeMs`
  - *number* - Specifies when channeling will end, in milliseconds (corresponds to GetTime()*1000).
- `isTradeskill`
  - *boolean* - Specifies if the cast is a tradeskill.
- `notInterruptible`
  - *boolean* - if true, indicates that this channeling cannot be interrupted with abilities like or . In default UI those spells have shield frame around their icons on enemy channeling bars. Always returns nil in Classic.
- `spellID`
  - *number* - The spell's unique identifier.
- `isEmpowered`
  - *boolean*
- `numEmpowerStages`
  - *number*

**Description:**
Related Events:
- `UNIT_SPELLCAST_CHANNEL_START`
- `UNIT_SPELLCAST_CHANNEL_STOP`

Related API:
- `ChannelInfo` (Classic)

**Usage:**
The following snippet prints the amount of time remaining before the player's current spell finishes channeling.
```lua
local spell, _, _, _, endTimeMS = UnitChannelInfo("player")
if spell then 
  local finish = endTimeMS/1000 - GetTime()
  print(spell .. ' will be finished channeling in ' .. finish .. ' seconds.')
end
```

**Reference:**
- slouken 2006-10-06. Re: Expansion Changes - Concise List. Archived from the original