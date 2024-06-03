## Title: CombatLogGetCurrentEntry

**Content:**
Returns the combat log entry that is currently selected by `CombatLogSetCurrentEntry()`.
```lua
local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEntry();
```

**Returns:**
This function's returns are identical to those of `CombatLogGetCurrentEventInfo()`. For more details see `COMBAT_LOG_EVENT`.