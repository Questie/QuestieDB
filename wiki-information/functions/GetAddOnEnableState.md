## Title: GetAddOnEnableState

**Content:**
Get the enabled state of an addon for a character.
`enabledState = GetAddOnEnableState(character, name)`

**Parameters:**
- `character`
  - *string?* - The name of the character to check against or nil.
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `enabledState`
  - *number* - The enabled state of the addon.
    - `0` - disabled
    - `1` - enabled for some
    - `2` - enabled

**Description:**
This is primarily used by the default UI to set the checkbox state in the AddOnList. A return of 1 is only possible if `character` is nil.