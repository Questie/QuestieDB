## Title: C_Console.GetAllCommands

**Content:**
Returns all console variables and commands.
`commands = C_Console.GetAllCommands()`

**Returns:**
- `commands`
  - *ConsoleCommandInfo*
    - `Field`
    - `Type`
    - `Description`
    - `command`
      - *string*
    - `help`
      - *string*
    - `category`
      - *Enum.ConsoleCategory*
    - `commandType`
      - *Enum.ConsoleCommandType*
    - `scriptContents`
      - *string*
    - `scriptParameters`
      - *string*

- `Enum.ConsoleCategory`
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - Debug
  - `1`
    - Graphics
  - `2`
    - Console
  - `3`
    - Combat
  - `4`
    - Game
  - `5`
    - Default
  - `6`
    - Net
  - `7`
    - Sound
  - `8`
    - Gm
  - `9`
    - Reveal
  - `10`
    - None

- `Enum.ConsoleCommandType`
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - Cvar
  - `1`
    - Command
  - `2`
    - Macro
  - `3`
    - Script

**Description:**
Not all cvars are returned yet on initial login until VARIABLES_LOADED, e.g. AutoPushSpellToActionBar.

**Usage:**
Prints all cvars and commands.
```lua
/run for k, v in pairs(C_Console.GetAllCommands()) do print(k, v.command) end
```

**Reference:**
[AdvancedInterfaceOptions Issue #38](https://github.com/Stanzilla/AdvancedInterfaceOptions/issues/38)