## Title: C_AddOns.EnableAddOn

**Content:**
Enables an addon on the next session.
`C_AddOns.EnableAddOn(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be enabled, or an index from 1 to `C_AddOns.GetNumAddOns`. Blizzard addons can only be enabled by name.
- `character`
  - *string?* - The name of the character, excluding the realm name. If omitted, enables the addon for all characters.

**Usage:**
- Enables an addon for all characters on the current realm.
  ```lua
  C_AddOns.EnableAddOn("HelloWorld")
  ```
- Enables an addon only for the current character.
  ```lua
  C_AddOns.EnableAddOn("HelloWorld", UnitName("player"))
  ```

**Description:**
Related API:
- `C_AddOns.DisableAddOn`