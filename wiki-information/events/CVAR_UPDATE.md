## Event: CVAR_UPDATE

**Title:** CVAR UPDATE

**Content:**
Fires when changing console variables with an optional argument to C_CVar.SetCVar().
`CVAR_UPDATE: eventName, value`

**Payload:**
- `eventName`
  - *string* - The optional argument used with C_CVar.SetCVar().
- `value`
  - *string* - The new value of the console variable.