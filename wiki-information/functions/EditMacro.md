## Title: EditMacro

**Content:**
Modifies an existing macro.
`macroID = EditMacro(macroInfo, name)`

**Parameters:**
- `macroInfo`
  - *number|string* - The index or name of the macro to be edited. Index ranges from 1 to 120 for account-wide macros and 121 to 138 for character-specific.
- `name`
  - *string* - The name to assign to the macro. The current UI imposes a 16-character limit. The existing name remains unchanged if this argument is nil.
- `icon`
  - *number|string : FileID* - The path to the icon texture to assign to the macro. The existing icon remains unchanged if this argument is nil.
- `body`
  - *string?* - The macro commands to be executed. If this string is longer than 255 characters, only the first 255 will be saved.

**Returns:**
- `macroID`
  - *number* - The new index of the macro, as displayed in the "Create Macros" UI. Same as argument "index" unless the macro name is changed, as they are sorted alphabetically.

**Description:**
If this function is called from within the macro that is edited, the rest of the macro (from the final character's position of the `/run` command onward) will run the new version.

**Usage:**
```lua
local macroID = EditMacro(1, "GoHome", 134414, "/use Hearthstone")
```

**Example Use Case:**
This function can be used to dynamically update a macro based on certain conditions or events in the game. For instance, an addon could use `EditMacro` to change the behavior of a macro depending on the player's current location or status.

**Addon Usage:**
Many large addons, such as GSE (Gnome Sequencer Enhanced), use `EditMacro` to manage and update macros for users. GSE allows players to create complex sequences of abilities and spells, and it uses `EditMacro` to update these sequences dynamically based on user input or game events.