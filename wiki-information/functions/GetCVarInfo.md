## Title: C_CVar.GetCVarInfo

**Content:**
Returns information on a console variable.
`value, defaultValue, isStoredServerAccount, isStoredServerCharacter, isLockedFromUser, isSecure, isReadOnly = C_CVar.GetCVarInfo(name)`

**Parameters:**
- `name`
  - *string* - Name of the CVar to query the value of. Only accepts console variables (i.e. not console commands).

**Returns:**
- `value`
  - *string* - Current value of the CVar.
- `defaultValue`
  - *string* - Default value of the CVar.
- `isStoredServerAccount`
  - *boolean* - If the CVar scope is set WoW account-wide. Stored on the server per CVar synchronizeConfig.
- `isStoredServerCharacter`
  - *boolean* - If the CVar scope is character-specific. Stored on the server per CVar synchronizeConfig.
- `isLockedFromUser`
  - *boolean*
- `isSecure`
  - *boolean* - If the CVar cannot be set with SetCVar while in combat, which would fire ADDON_ACTION_BLOCKED. It's also not possible to set these via /console. Most nameplate CVars are secure.
- `isReadOnly`
  - *boolean* - Returns true for portal, serverAlert, timingTestError. These CVars cannot be changed.