## Title: GetClickFrame

**Content:**
Returns the frame registered with the given object name.
`frame = GetClickFrame(name)`

**Parameters:**
- `name`
  - *string* - The name of the frame to obtain.

**Returns:**
- `frame`
  - *table?* - The table handle to the named frame if it exists, else nil.

**Description:**
This function acts as a secure cache for frame name to object lookups. The first call to this function will cache the frame object registered assigned to name in the global namespace, and all subsequent calls thereafter will return the same frame even if the global is later replaced.
This function will not cache frame objects if the queried name does not match their actual object name as returned by `UIObject:GetName()`.
If called securely, this function returns the frame to the caller untainted.