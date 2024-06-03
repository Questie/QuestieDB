## Title: ConsoleGetAllCommands

**Content:**
Needs summary.
`commands = ConsoleGetAllCommands()`

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

**Enum.ConsoleCategory:**
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

**Enum.ConsoleCommandType:**
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