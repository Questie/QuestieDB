## Title: C_PetJournal.GetPetInfoByIndex

**Content:**
Returns information about a battle pet.
`petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(index)`

**Parameters:**
- `index`
  - *number* - Numeric index of the pet in the Pet Journal, ascending from 1.

**Returns:**
- `Index`
- `Value`
- `Type`
- `Details`
  - `1`
    - `petID`
      - *String* - GUID for this specific pet
  - `2`
    - `speciesID`
      - *Number* - Identifier for the pet species
  - `3`
    - `owned`
      - *Boolean* - Whether the pet is owned by the player
  - `4`
    - `customName`
      - *String* - Name assigned by the player or nil if unnamed
  - `5`
    - `level`
      - *Number* - The pet's current battle level
  - `6`
    - `favorite`
      - *Boolean* - Whether the pet is marked as a favorite
  - `7`
    - `isRevoked`
      - *Boolean* - True if the pet is revoked; false otherwise.
  - `8`
    - `speciesName`
      - *String* - Name of the pet species ("Albino Snake", "Blue Mini Jouster", etc.)
  - `9`
    - `icon`
      - *String* - Full path for the species' icon
  - `10`
    - `petType`
      - *Number* - Index of the species' petType.
  - `11`
    - `companionID`
      - *Number* - NPC ID for the summoned companion pet.
  - `12`
    - `tooltip`
      - *String* - Section of the tooltip that provides location information
  - `13`
    - `description`
      - *String* - Section of the tooltip that provides pet description ("flavor text")
  - `14`
    - `isWild`
      - *Boolean* - True if the pet was/can be caught in the wild, false otherwise.
  - `15`
    - `canBattle`
      - *Boolean* - True if this pet can be used in battles, false otherwise.
  - `16`
    - `isTradeable`
      - *Boolean* - True if this pet can be traded, false otherwise.
  - `17`
    - `isUnique`
      - *Boolean* - True if this pet is unique, false otherwise.
  - `18`
    - `obtainable`
      - *Boolean* - True if this pet can be obtained, false otherwise (only false for tamer pets and developer/test pets).

**Description:**
`index` is subject to filter and search result, e.g., a search for "Snake" where `index` is 1 will return information about the first snake in the journal, whereas an empty search and filter will return information about the first pet in the journal.