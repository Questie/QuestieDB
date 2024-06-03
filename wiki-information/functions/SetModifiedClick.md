## Title: SetModifiedClick

**Content:**
Assigns the given modifier key to the given action.
`SetModifiedClick(action, key)`

**Parameters:**
- `action`
  - *string* - The action to set a key for. Actions defined by Blizzard:
    - `AUTOLOOTTOGGLE`, `CHATLINK`, `COMPAREITEMS`, `DRESSUP`, `FOCUSCAST`, `OPENALLBAGS`, `PICKUPACTION`, `QUESTWATCHTOGGLE`, `SELFCAST`, `SHOWITEMFLYOUT`, `SOCKETITEM`, `SPLITSTACK`, `STICKYCAMERA`, `TOKENWATCHTOGGLE`
- `key`
  - *string* - The key to assign. Must be one of:
    - `ALT`, `CTRL`, `SHIFT`, `NONE`

**Description:**
The game only provides user options for changing the `AUTOLOOTTOGGLE`, `FOCUSCAST`, and `SELFCAST` modifiers. All other modifiers are set to "SHIFT" by default, except for `DRESSUP` and `SOCKETITEM`, which are set to "CTRL".
An additional modifier `SHOWMULTICASTFLYOUT` exists, but was only used in the shaman totem UI, which was removed from the game in Patch 4.0.1.

**Reference:**
- `IsModifiedClick`
- `SetModifiedClick`