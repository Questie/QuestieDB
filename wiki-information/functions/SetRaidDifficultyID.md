## Title: SetRaidDifficultyID

**Content:**
Sets the raid difficulty.
`SetRaidDifficultyID(difficultyIndex)`

**Parameters:**
- `difficultyIndex`
  - *number*
    - 3 → 10 Player
    - 4 → 25 Player
    - 5 → 10 Player (Heroic)
    - 6 → 25 Player (Heroic)
    - 14 → Normal
    - 15 → Heroic
    - 16 → Mythic

**Description:**
When the change occurs, a message will be displayed in the default chat frame.
Example: `/script SetRaidDifficultyID(16);` sets the raid difficulty to Mythic

**Reference:**
- `GetRaidDifficultyID`
- `difficultyIndex`