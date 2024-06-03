## Title: issecurevariable

**Content:**
Returns true if the specified variable is secure.
`isSecure, taint = issecurevariable(variable)`

**Parameters:**
- `table`
  - *table?* - table to check the key in; if omitted, defaults to the globals table (_G).
- `variable`
  - *string* - string key to check the taint of. Numbers will be converted to a string; other types will throw an error.

**Returns:**
- `isSecure`
  - *boolean* - true if the table key is secure, false if it is tainted.
- `taint`
  - *string?* - name of the addon that tainted the table field; an empty string if tainted by a macro; nil if secure.

**Description:**
Also returns true, nil for keys that have never been used/defined, because nothing has tainted them yet.
If `table == nil`, and table has a metatable with `__index`, this function will return whether the metatable's `__index` is tainted. You must remove the metatable to check whether the table itself is tainted.
Cannot be used to check the taint of local variables, or non-string table keys.