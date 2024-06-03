## Title: C_Club.GetCommunityNameResultText

**Content:**
Needs summary.
`errorCode = C_Club.GetCommunityNameResultText(result)`

**Parameters:**
- `result`
  - *Enum.ValidateNameResult*
    - **Value**
    - **Field**
    - **Description**
    - `0`
      - Success
    - `1`
      - Failure
    - `2`
      - NoName
    - `3`
      - TooShort
    - `4`
      - TooLong
    - `5`
      - InvalidCharacter
    - `6`
      - MixedLanguages
    - `7`
      - Profane
    - `8`
      - Reserved
    - `9`
      - InvalidApostrophe
    - `10`
      - MultipleApostrophes
    - `11`
      - ThreeConsecutive
    - `12`
      - InvalidSpace
    - `13`
      - ConsecutiveSpaces
    - `14`
      - RussianConsecutiveSilentCharacters
    - `15`
      - RussianSilentCharacterAtBeginningOrEnd
    - `16`
      - DeclensionDoesntMatchBaseName
    - `17`
      - SpacesDisallowed

**Returns:**
- `errorCode`
  - *string?*

**Change Log:**
- Added in 8.2.5