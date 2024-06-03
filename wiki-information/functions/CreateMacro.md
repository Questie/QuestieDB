## Title: CreateMacro

**Content:**
Creates a macro.
`macroId = CreateMacro(name, iconFileID)`

**Parameters:**
- `name`
  - *string* - The name of the macro to be displayed in the UI. The current UI imposes a 16-character limit.
- `iconFileID`
  - *number|string* - A FileID or string identifying the icon texture to use. The available icons can be retrieved by calling `GetMacroIcons()` and `GetMacroItemIcons()`; other textures inside `Interface\\ICONS` may also be used.
- `body`
  - *string?* - The macro commands to be executed. If this string is longer than 255 characters, only the first 255 will be saved.
- `perCharacter`
  - *boolean?* - true to create a per-character macro, nil to create a general macro available to all characters.

**Returns:**
- `macroId`
  - *number* - The 1-based index of the newly-created macro, as displayed in the "Create Macros" UI.

**Usage:**
Creates an empty macro with the respective FileID for "trade_engineering":
```lua
/run CreateMacro("test", 136243)
```
Creates a character-specific macro. The question mark icon will dynamically display the Hearthstone icon:
```lua
/run CreateMacro("to home", "INV_Misc_QuestionMark", "/cast Hearthstone", true)
```

**Description:**
This function will generate an error if the maximum macros of the specified kind already exist (120 for per account and 18 for per character).
It is possible to create macros with duplicate names. You should enumerate the current macros using `GetNumMacros()` and `GetMacroInfo(macroId)` to ensure that your new macro name doesn't already exist. Macros with duplicate names can be used in most situations, but the behavior of macro functions that retrieve a macro by name is undefined when multiple macros of that name exist.

**Reference:**
- `EditMacro`