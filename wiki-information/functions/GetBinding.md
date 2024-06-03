## Title: GetBinding

**Content:**
Returns the name and keys for a binding by index.
`command, category, key1, key2, ... = GetBinding(index)`

**Parameters:**
- `index`
  - *number* - index of the binding to query, from 1 to GetNumBindings().
- `alwaysIncludeGamepad`
  - *boolean?* - If gamepad support is disabled, then gamepad bindings are only returned if this is true.

**Returns:**
- `command`
  - *string* - Command this binding will perform (e.g. MOVEFORWARD). For well-behaved bindings, a human-readable description is stored in the `_G` global variable.
- `category`
  - *string* - Category this binding was declared in (e.g. BINDING_HEADER_MOVEMENT). For well-behaved bindings, a human-readable title is stored in the `_G` global variable.
- `key1, key2, ...`
  - *string?* - Key combination this binding is bound to (e.g. W, CTRL-F). `key1` and `key2` can be nil if there is nothing bound to the command.

**Description:**
Even though the default Key Binding window only shows up to two bindings for each command, it is actually possible to bind more using `SetBinding`, and this function will return all of the keys bound to the given command, not just the first two.

**Usage:**
```lua
local function dumpBinding(command, category, ...)
    local cmdName = _G[command]
    local catName = _G[category]
    print(("%s > %s (%s) is bound to:"):format(catName or "?", cmdName or "?", command), strjoin(", ", ...))
end

dumpBinding(GetBinding(5)) -- "Movement Keys > Turn Right (TURNRIGHT) is bound to: D, RIGHT"
```

**Reference:**
- `GetBindingAction`
- `GetBindingKey`
- `GetBindingByKey`
- `Bindings.xml`