## Title: IsModifiedClick

**Content:**
Returns true if the modifier key needed for an action is pressed.
`isHeld = IsModifiedClick()`

**Parameters:**
- `action`
  - *string?* - The action to check for. Actions defined by Blizzard:
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
- `isHeld`
  - *boolean* - true if the modifier is being held, false otherwise

**Description:**
Despite the name, this function does not have anything to do with mouse buttons and can be used at any time to check the state of a modifier key; it is not limited to use in click-related scripts.
This function can be called with no argument to check whether *any* modifier key is pressed; in this case it behaves just like `IsModifierKeyDown`.

**Reference:**
- `GetModifiedClick`
- `SetModifiedClick`
- `IsModifierKeyDown`