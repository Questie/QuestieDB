## Title: SetDungeonDifficultyID

**Content:**
Sets the player's dungeon difficulty.
`SetDungeonDifficultyID(difficultyIndex)`

**Parameters:**
- `difficultyIndex`
  - *number*
    - `1` → 5 Player
    - `2` → 5 Player (Heroic)
    - `8` → Challenge Mode

**Description:**
When the change occurs, a message will be displayed in the default chat frame.
The above arguments are also returned from `GetDungeonDifficultyID()`.

**Reference:**
- `GetDungeonDifficultyID`
  - `difficultyIndex`