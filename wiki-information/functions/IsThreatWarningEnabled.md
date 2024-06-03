## Title: IsThreatWarningEnabled

**Content:**
Returns true if threat warnings are currently enabled.
`enabled = IsThreatWarningEnabled()`

**Returns:**
- `enabled`
  - *boolean flag* - 1 if the warnings are enabled, nil if they are not.

**Description:**
The warnings are controlled by the `threatWarning` CVar, which allows the player to specify in which situations the warnings should be active. This function takes into account the current situation.

**Reference:**
ShowNumericThreat