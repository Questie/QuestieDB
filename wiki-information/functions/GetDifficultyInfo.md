## Title: GetDifficultyInfo

**Content:**
Returns information about a difficulty.
`name, groupType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID, isLFR, minPlayers, maxPlayers = GetDifficultyInfo(id)`

**Parameters:**
- `id`
  - *number* - difficulty ID to query, ascending from 1.

**Returns:**
- `name`
  - *string* - Difficulty name, e.g. "10 Player (Heroic)"
- `groupType`
  - *string* - Group type appropriate for this difficulty; "party" or "raid".
- `isHeroic`
  - *boolean* - true if this is a heroic difficulty, false otherwise.
- `isChallengeMode`
  - *boolean* - true if this is challenge mode difficulty, false otherwise.
- `displayHeroic`
  - *boolean* - display the Heroic skull icon on the instance banner of the minimap
- `displayMythic`
  - *boolean* - display the Mythic skull icon on the instance banner of the minimap
- `toggleDifficultyID`
  - *number* - difficulty ID of the corresponding heroic/non-heroic difficulty for 10/25-man raids, if one exists.
- `isLFR`
  - *boolean* - true if this is looking for raid difficulty, false otherwise.
- `minPlayers`
  - *number* - minimum players needed.
- `maxPlayers`
  - *number* - maximum players allowed.

**Reference:**
- `DifficultyID` (a list of possible difficultyIDs)
- `SetDungeonDifficultyID`
- `GetInstanceInfo`
- `GetRaidDifficultyID`