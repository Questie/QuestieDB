## Title: C_PetJournal.GetPetInfoBySpeciesID

**Content:**
Returns information about a pet species.
`speciesName, speciesIcon, petType, companionID, tooltipSource, tooltipDescription, isWild, canBattle, isTradeable, isUnique, obtainable, creatureDisplayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID)`

**Parameters:**
- `speciesID`
  - *number* - identifier for the pet species

**Returns:**
| Index | Value               | Type    | Details                                                                                                      |
|-------|---------------------|---------|--------------------------------------------------------------------------------------------------------------|
| 1     | speciesName         | String  | Name of the pet species ("Albino Snake", "Blue Mini Jouster", etc.)                                           |
| 2     | speciesIcon         | String  | Full path for the species' icon                                                                              |
| 3     | petType             | Number  | Index of the species' pet type.                                                                              |
| 4     | companionID         | Number  | NPC ID for the summoned companion pet.                                                                       |
| 5     | tooltipSource       | String  | Section of the species tooltip that provides location information                                            |
| 6     | tooltipDescription  | String  | Section of the species tooltip that provides pet description ("flavor text")                                 |
| 7     | isWild              | Boolean | For pets in the player's possession, true if the pet was caught in the wild. For pets not in the player's possession, true if the pet can be caught in the wild. |
| 8     | canBattle           | Boolean | True if this pet can be used in battles, false otherwise.                                                    |
| 9     | isTradeable         | Boolean | True if this pet can be traded, false otherwise.                                                             |
| 10    | isUnique            | Boolean | True if this pet is unique, false otherwise.                                                                 |
| 11    | obtainable          | Boolean | True if this pet can be obtained, false otherwise (only false for tamer pets and developer/test pets).       |
| 12    | creatureDisplayID   | Number  | Creature display ID of the species.                                                                          |

**Reference:**
`C_PetJournal.GetPetInfoByPetID`