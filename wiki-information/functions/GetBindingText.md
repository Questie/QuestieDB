## Title: GetBindingText

**Content:**
Returns the string for the given key and prefix. Essentially a specialized `getglobal()` for bindings.
`text = GetBindingText()`

**Parameters:**
- `key`
  - *string?* - The name of the key (e.g. "UP", "SHIFT-PAGEDOWN")
- `prefix`
  - *string?* - The prefix of the variable name you're looking for. Usually "KEY_" or "BINDING_NAME_".
- `abbreviate`
  - *boolean?* - Whether to return an abbreviated version of the modifier keys

**Returns:**
- `text`
  - *string* - The value of the global variable derived from the prefix and key name you specified. For example, "UP" and "KEY_" would return the value of the global variable `KEY_UP` which is "Up Arrow" in the English locale. If the global variable doesn't exist for the combination specified, it appears to just return the key name you specified. Modifier key prefixes are stripped from the input and added back into the output. The third parameter, if true, causes the function to simply substitute the abbreviations 'c', 'a', 's', and 'st' for the strings CTRL, ALT, SHIFT, and STRG (German client only) in the result.

**Usage:**
```lua
/dump GetBindingText("UP", "KEY_")
-- "Up Arrow"
```