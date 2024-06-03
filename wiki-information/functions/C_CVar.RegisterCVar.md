## Title: C_CVar.RegisterCVar

**Content:**
Temporarily registers a custom console variable.
`C_CVar.RegisterCVar(name)`

**Parameters:**
- `name`
  - *string* - Name of the custom CVar to set.
- `value`
  - *string|number?* = "0" - Initial value of the CVar.

**Description:**
You can register your own CVars. They are set game-wide and will persist after relogging/reloading but not after closing the game.