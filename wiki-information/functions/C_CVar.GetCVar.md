## Title: C_CVar.GetCVar

**Content:**
Returns the current value of a console variable.
`value = C_CVar.GetCVar(name)`
`= GetCVar`

**Parameters:**
- `name`
  - *string* : CVar - name of the CVar to query the value of.

**Returns:**
- `value`
  - *string?* - current value of the CVar.

**Description:**
Calling this function with an invalid variable name, or a variable that cannot be queried by AddOns (like "accountName"), will return nil.