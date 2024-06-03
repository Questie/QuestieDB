## Title: C_PetJournal.GetPetSummonInfo

**Content:**
Needs summary.
`isSummonable, error, errorText = C_PetJournal.GetPetSummonInfo(battlePetGUID)`

**Parameters:**
- `battlePetGUID`
  - *string*

**Returns:**
- `isSummonable`
  - *boolean*
- `error`
  - *Enum.PetJournalError*
    - `Value`
    - `Field`
    - `Description`
      - `0` - None
      - `1` - PetIsDead
      - `2` - JournalIsLocked
      - `3` - InvalidFaction
      - `4` - NoFavoritesToSummon
      - `5` - NoValidRandomSummon
      - `6` - InvalidCovenant
- `errorText`
  - *string*