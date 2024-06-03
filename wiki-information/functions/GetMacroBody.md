## Title: GetMacroBody

**Content:**
Returns the body (macro text) of a macro.
`body = GetMacroBody(macro)`

**Parameters:**
- `macro`
  - *number|string* - Macro index or name.

**Returns:**
- `body`
  - *string?* - The macro body or nothing if the macro doesn't exist.

**Usage:**
```lua
/dump GetMacroBody("Flash Heal")
-- Output: "#showtooltip\n/cast Flash Heal\n"
```

**Example Use Case:**
This function can be used to retrieve the text of a macro for inspection or modification. For instance, an addon could use this to check if a specific macro exists and then update its content based on certain conditions.

**Addons Using This Function:**
Many macro management addons, such as "GSE: Gnome Sequencer Enhanced", use this function to read and manipulate macro texts programmatically. This allows users to create complex sequences and automate their gameplay more effectively.