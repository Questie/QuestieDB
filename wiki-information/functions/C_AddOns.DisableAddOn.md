## Title: C_AddOns.DisableAddOn

**Content:**
Disables an addon on the next session.
`C_AddOns.DisableAddOn(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be disabled, or an index from 1 to `C_AddOns.GetNumAddOns`. Blizzard addons cannot be disabled.
- `character`
  - *string?* - The name of the character, excluding the realm name. If omitted, disables the addon for all characters.

**Usage:**
Disables an addon for all characters on the current realm.
```lua
C_AddOns.DisableAddOn("HelloWorld")
```
Disables an addon only for the current character.
```lua
C_AddOns.DisableAddOn("HelloWorld", UnitName("player"))
```

**Description:**
Related API:
- `C_AddOns.EnableAddOn`