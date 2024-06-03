## Title: C_PetJournal.GetPetInfoByPetID

**Content:**
Returns information about a battle pet.
`speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petID)`

**Parameters:**
- `petID`
  - *string* : GUID

**Returns:**
| Index | Value       | Type    | Details                                                                                       |
|-------|-------------|---------|-----------------------------------------------------------------------------------------------|
| 1     | speciesID   | Number  | Identifier for the pet species                                                                 |
| 2     | customName  | String  | Name assigned by the player or nil if unnamed                                                  |
| 3     | level       | Number  | The pet's current battle level                                                                 |
| 4     | xp          | Number  | The pet's current xp                                                                           |
| 5     | maxXp       | Number  | The pet's maximum xp                                                                           |
| 6     | displayID   | Number  | The display ID of the pet                                                                      |
| 7     | isFavorite  | Boolean | Whether the pet is marked as a favorite                                                        |
| 8     | name        | String  | Name of the pet species ("Albino Snake", "Blue Mini Jouster", etc.)                            |
| 9     | icon        | String  | Full path for the species' icon                                                                |
| 10    | petType     | Number  | Index of the species' pet type                                                                 |
| 11    | creatureID  | Number  | NPC ID for the summoned companion pet                                                          |
| 12    | sourceText  | String  | Section of the tooltip that provides location information                                      |
| 13    | description | String  | Section of the tooltip that provides pet description ("flavor text")                           |
| 14    | isWild      | Boolean | For pets in the player's possession, true if the pet was caught in the wild. For pets not in the player's possession, true if the pet can be caught in the wild. |
| 15    | canBattle   | Boolean | True if this pet can be used in battles, false otherwise.                                      |
| 16    | tradable    | Boolean | True if this pet can be traded, false otherwise.                                               |
| 17    | unique      | Boolean | True if this pet is unique, false otherwise.                                                   |
| 18    | obtainable  | Boolean | True if this pet can be obtained, false otherwise (only false for tamer pets and developer/test pets). |

**Description:**
Information about the player's battle pets is available after `UPDATE_SUMMONPETS_ACTION` has fired.

**Reference:**
- `C_PetJournal.GetPetStats`
- `C_PetJournal.GetPetInfoBySpeciesID`