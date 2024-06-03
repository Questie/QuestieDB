## Title: GetRaidDifficultyID

**Content:**
Returns the player's currently selected raid difficulty.
`difficultyID = GetRaidDifficultyID()`

**Returns:**
- `difficultyID`
  - *number* - The player's (or group leader's) current raid difficulty ID preference. See `GetDifficultyInfo` for a list of possible difficultyIDs.

**Description:**
You may use `GetDifficultyInfo` to retrieve information about the returned ID value.

**Reference:**
- `SetRaidDifficultyID`
- `GetDungeonDifficultyID`