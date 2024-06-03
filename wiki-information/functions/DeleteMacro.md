## Title: DeleteMacro

**Content:**
Deletes a macro.
`DeleteMacro(indexOrName)`

**Parameters:**
The sole argument has two forms to identify which macro to delete.
- `indexOrName`
  - *number|string* - Index ranging from 1 to 120 for account-wide macros and 121 to 138 for character-specific ones or name of the macro to delete.

**Usage:**
Deleting all global macros:
```lua
-- Start at the end, and move backward to first position (1).
for i = 0 + select(1, GetNumMacros()), 1, -1 do
    DeleteMacro(i)
end
```

Deleting all character-specific macros:
```lua
-- Start at the end, and move backward to first position (121).
for i = 120 + select(2, GetNumMacros()), 121, -1 do
    DeleteMacro(i)
end
```

**Reference:**
- `GetMacroInfo()`
- `EditMacro()`
- `PickupMacro()`

**Example Use Case:**
This function can be used in a scenario where a player wants to clear out all their macros, either globally or character-specific, to start fresh or to manage their macro slots more efficiently.

**Addons Using This Function:**
Many macro management addons, such as "GSE: Gnome Sequencer Enhanced", use this function to delete existing macros before creating new ones to ensure there are no conflicts or to reset the macro list.