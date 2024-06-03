## Title: GetBindingAction

**Content:**
Returns the binding name for a key (combination).
`action = GetBindingAction(binding)`

**Parameters:**
- `binding`
  - *string* - The name of the key (e.g., "BUTTON1", "1", "CTRL-G")
- `checkOverride`
  - *boolean?* - if true, override bindings will be checked, otherwise, only default (bindings.xml/SetBinding) bindings are consulted.

**Returns:**
- `action`
  - *string* - action command performed by the binding. If no action is bound to the key, an empty string is returned.

**Reference:**
- `GetBindingByKey`

**Example Usage:**
```lua
local action = GetBindingAction("CTRL-G")
print(action) -- This will print the action bound to "CTRL-G" if any, otherwise an empty string.
```

**Additional Information:**
This function is commonly used in addons that manage or display key bindings, such as Bartender4 or ElvUI. These addons use `GetBindingAction` to retrieve and display the current key bindings for various actions, allowing users to customize their gameplay experience.