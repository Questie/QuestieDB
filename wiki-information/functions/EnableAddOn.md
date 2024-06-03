## Title: EnableAddOn

**Content:**
Enables an addon for subsequent sessions.
`EnableAddOn(addon)`

**Parameters:**
- `addon`
  - *number* - addonIndex from 1 to `GetNumAddOns()`
  - *or string* - addonName (as in toc/folder filename) of the addon, case insensitive.
- `character`
  - *string?* - playerName of the character (without realm)
  - *or boolean?* - enableAll True if the addon should be enabled/disabled for all characters on the realm.
  - Defaults to the current character. This param is currently bugged when attempting to use it (Issue #156).

**Description:**
Takes effect only after reloading the UI.

**Usage:**
Enables the addon at index 1 for the current character.
```lua
function PrintAddonInfo(idx)
    local name = GetAddOnInfo(idx)
    local enabledState = GetAddOnEnableState(nil, idx)
    print(name, enabledState)
end

PrintAddonInfo(1) -- "HelloWorld", 0
EnableAddOn(1)
PrintAddonInfo(1) -- "HelloWorld", 2
```

This should enable an addon for all characters, provided it isn't bugged.
```lua
EnableAddOn("HelloWorld", true)
```

Blizzard addons can be only accessed by name instead of index.
```lua
DisableAddOn("Blizzard_CombatLog")
```