## Event: ENCOUNTER_START

**Title:** ENCOUNTER START

**Content:**
Fires at the start of an instanced encounter.
`ENCOUNTER_START: encounterID, encounterName, difficultyID, groupSize`

**Payload:**
- `encounterID`
  - *number* - ID for the specific encounter started.
- `encounterName`
  - *string* - Name of the encounter started
- `difficultyID`
  - *number* - ID representing the difficulty of the encounter
- `groupSize`
  - *number* - Group size for the encounter. For example, 5 for a Dungeon encounter, 20 for a Mythic raid. The number of raiders participating is reflected in "flex" raids.