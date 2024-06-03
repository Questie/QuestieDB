## Title: GetModifiedClick

**Content:**
Returns the modifier key assigned to the given action.
`key = GetModifiedClick(action)`

**Parameters:**
- `action`
  - *string* - The action to query. Actions defined by Blizzard:
    - `AUTOLOOTTOGGLE`
    - `CHATLINK`
    - `COMPAREITEMS`
    - `DRESSUP`
    - `FOCUSCAST`
    - `OPENALLBAGS`
    - `PICKUPACTION`
    - `QUESTWATCHTOGGLE`
    - `SELFCAST`
    - `SHOWITEMFLYOUT`
    - `SOCKETITEM`
    - `SPLITSTACK`
    - `STICKYCAMERA`
    - `TOKENWATCHTOGGLE`

**Returns:**
- `key`
  - *string* - The modifier key assigned to this action. May be one of:
    - `ALT`
    - `CTRL`
    - `SHIFT`
    - `NONE`

**Reference:**
- `IsModifiedClick`
- `SetModifiedClick`