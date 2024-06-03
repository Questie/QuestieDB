## Title: PickupMacro

**Content:**
Places a macro onto the cursor.
`PickupMacro(index or name)`

**Parameters:**
- `index`
  - *number* - The position of the macro in the macro window, from left to right and top to bottom. Slots 1-120 are used for general macros, and 121-138 for character-specific macros.
- `name`
  - *string* - The name of the macro, case insensitive.

**Usage:**
- Picks up the first character macro.
  ```lua
  PickupMacro(121)
  ```
- The macro named "Reload" is placed on the cursor. If there is no such named macro then nothing happens.
  ```lua
  PickupMacro("Reload")
  ```