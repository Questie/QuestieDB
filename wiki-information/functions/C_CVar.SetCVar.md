## Title: C_CVar.SetCVar

**Content:**
Sets a console variable.
`success = C_CVar.SetCVar(name)`

**Parameters:**
- `name`
  - *string* : CVar - Name of the CVar.
- `value`
  - *string|number?* = "0" - The new value of the CVar.

**Returns:**
- `success`
  - *boolean* - Whether the CVar was successfully set. Returns nil if attempting to set a secure cvar in combat.

**Description:**
Some settings require a reload/relog before they take effect.
CVars are not saved to Config.wtf until properly logging out or reloading the game.
Secure CVars cannot be set in combat and only with SetCVar instead of /console.
Character and Account specific variables are stored server-side depending on CVar synchronizeConfig.