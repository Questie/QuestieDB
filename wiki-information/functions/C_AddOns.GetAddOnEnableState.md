## Title: C_AddOns.GetAddOnEnableState

**Content:**
Queries the enabled state of an addon, optionally for a specific character.
`state = C_AddOns.GetAddOnEnableState(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to `C_AddOns.GetNumAddOns`. The state of Blizzard addons can only be queried by name.
- `character`
  - *string?* - The name of the character to check against, or omitted/nil for all characters.

**Returns:**
- `state`
  - *Enum.AddOnEnableState* - The enabled state of the addon.
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - `None` - Disabled
    - `1`
      - `Some` - Enabled for some characters; this is only possible if character is nil.
    - `2`
      - `All` - Enabled

**Example Usage:**
```lua
local state = C_AddOns.GetAddOnEnableState("MyAddon")
if state == Enum.AddOnEnableState.All then
    print("MyAddon is enabled for all characters.")
elseif state == Enum.AddOnEnableState.Some then
    print("MyAddon is enabled for some characters.")
else
    print("MyAddon is disabled.")
end
```

**Additional Information:**
This function is useful for addon developers who need to check if their addon is enabled for specific characters or globally. It can be particularly helpful in scenarios where different settings or behaviors are required based on the addon's enabled state.