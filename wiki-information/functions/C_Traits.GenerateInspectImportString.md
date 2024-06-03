## Title: C_Traits.GenerateInspectImportString

**Content:**
Returns a Talent Build String for an inspected target.
`importString = C_Traits.GenerateInspectImportString(target)`

**Parameters:**
- `target`
  - *string* : UnitId - For example "target"

**Returns:**
- `importString`
  - *string* - the Talent Build String, or an empty string if inspect information is not available

**Description:**
You must first inspect a player before this API returns any data. After inspecting, you should use `C_Traits.HasValidInspectData` to confirm valid inspect data is available to the client.

**Reference:**
`C_Traits.GenerateImportString` to retrieve Talent Build Strings for the current player character.