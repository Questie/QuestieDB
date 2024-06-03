## Title: C_AddOns.DisableAllAddOns

**Content:**
Disables all addons on the addon list.
`C_AddOns.DisableAllAddOns()`

**Parameters:**
- `character`
  - *string?* - The name of the character, excluding the realm name. If omitted, disables all addons for all characters.

**Example Usage:**
```lua
-- Disable all addons for the current character
C_AddOns.DisableAllAddOns()

-- Disable all addons for a specific character
C_AddOns.DisableAllAddOns("CharacterName")
```

**Description:**
This function is useful for quickly disabling all addons, either globally or for a specific character. This can be particularly helpful when troubleshooting issues caused by addon conflicts or when preparing for a clean testing environment.

**Addons Using This Function:**
While specific large addons using this function are not commonly documented, it is often used in custom scripts and addon management tools to provide users with the ability to quickly disable all addons for troubleshooting purposes.