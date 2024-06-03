## Title: LoggingCombat

**Content:**
Gets or sets whether logging combat to `Logs\WoWCombatLog.txt` is enabled.
`isLogging = LoggingCombat()`

**Parameters:**
- `newState`
  - *boolean* - Toggles combat logging

**Returns:**
- `isLogging`
  - *false* - You are not logging
  - *true* - You are logging
  - When spammed, may return `nil` instead of `true` or `false`.

**Usage:**
```lua
if (LoggingCombat()) then
  DEFAULT_CHAT_FRAME:AddMessage("Combat is already being logged");
else
  DEFAULT_CHAT_FRAME:AddMessage("Combat is not being logged - starting it!");
  LoggingCombat(1);
end

if (LoggingCombat()) then
  DEFAULT_CHAT_FRAME:AddMessage("Combat is already being logged");
else
  DEFAULT_CHAT_FRAME:AddMessage("Combat is not being logged - starting it!");
  LoggingCombat(1);
end
```

**Example #2:**
Create a new macro and paste the following (one-line):
```lua
/script local a=LoggingCombat(LoggingCombat()==nil); UIErrorsFrame:AddMessage("CombatLogging is now "..tostring(a and "ON" or "OFF"),1,0,0);
```
Drag the macro-button to an action bar or key bind it and you have a one-click/keypress toggle.

**Description:**
If no parameter is passed in, `LoggingCombat` only returns the current state.