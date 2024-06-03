## Event: ENCOUNTER_END

**Title:** ENCOUNTER END

**Content:**
Fires at the end of an instanced encounter. 
`ENCOUNTER_END: encounterID, encounterName, difficultyID, groupSize, success`

**Payload:**
- `encounterID`
  - *number* - ID for the specific encounter that ended. (Does not match the encounterIDs used in the Encounter Journal)
- `encounterName`
  - *string* - Name of the encounter that ended
- `difficultyID`
  - *number* - ID representing the difficulty of the encounter
- `groupSize`
  - *number* - Group size for the encounter. For example, 5 for a Dungeon encounter, 20 for a Mythic raid. The number of raiders participating is reflected in "flex" raids.
- `success`
  - *number* - 1 for a successful kill. 0 for a wipe