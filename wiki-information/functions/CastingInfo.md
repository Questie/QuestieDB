## Title: CastingInfo

**Content:**
Returns the player's currently casting spell.
`name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = CastingInfo()`

**Returns:**
- `name`
  - *string* - The name of the spell.
- `text`
  - *string* - The name to be displayed.
- `texture`
  - *number* : FileID
- `startTime`
  - *number* - Specifies when casting began in milliseconds (corresponds to GetTime()*1000).
- `endTime`
  - *number* - Specifies when casting will end in milliseconds (corresponds to GetTime()*1000).
- `isTradeSkill`
  - *boolean*
- `castID`
  - *string* - e.g. "Cast-3-4479-0-1318-2053-000014AD63"
- `notInterruptible`
  - *boolean* - This is always nil.
- `spellID`
  - *number*

**Description:**
In Classic, only casting information for the player is available. This API is essentially the same as `UnitCastingInfo("player")`.

**Example Usage:**
This function can be used in addons to track the player's current casting spell. For instance, an addon that displays a custom casting bar would use `CastingInfo()` to get the details of the spell being cast and update the bar accordingly.

**Addons Using This API:**
Many popular addons like Quartz and Gnosis use this API to provide enhanced casting bar functionalities, showing detailed information about the spell being cast, including start and end times, and whether the spell is interruptible.