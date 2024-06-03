## Title: ChannelInfo

**Content:**
Returns the player's currently channeling spell.
`name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = ChannelInfo()`

**Returns:**
- `name`
  - *string* - The name of the spell, or nil if no spell is being channeled.
- `text`
  - *string* - The name to be displayed.
- `texture`
  - *number* : FileID
- `startTime`
  - *number* - Specifies when channeling began in milliseconds (corresponds to GetTime()*1000).
- `endTime`
  - *number* - Specifies when channeling will end in milliseconds (corresponds to GetTime()*1000).
- `isTradeSkill`
  - *boolean*
- `notInterruptible`
  - *boolean* - This is always nil.
- `spellID`
  - *number*

**Description:**
In Classic, only channeling information for the player is available. This API is essentially the same as `UnitChannelInfo("player")`.