## Title: C_Club.ValidateText

**Content:**
Needs summary.
`result = C_Club.ValidateText(clubType, text, clubFieldType)`

**Parameters:**
- `clubType`
  - *Enum.ClubType*
    - **Value**
    - **Field**
    - **Description**
    - `0` - BattleNet
    - `1` - Character
    - `2` - Guild
    - `3` - Other
- `text`
  - *string*
- `clubFieldType`
  - *Enum.ClubFieldType*
    - **Value**
    - **Field**
    - **Description**
    - `0` - ClubName
    - `1` - ClubShortName
    - `2` - ClubDescription
    - `3` - ClubBroadcast
    - `4` - ClubStreamName
    - `5` - ClubStreamSubject
    - `6` - NumTypes

**Returns:**
- `result`
  - *Enum.ValidateNameResult*
    - **Value**
    - **Field**
    - **Description**
    - `0` - Success
    - `1` - Failure
    - `2` - NoName
    - `3` - TooShort
    - `4` - TooLong
    - `5` - InvalidCharacter
    - `6` - MixedLanguages
    - `7` - Profane
    - `8` - Reserved
    - `9` - InvalidApostrophe
    - `10` - MultipleApostrophes
    - `11` - ThreeConsecutive
    - `12` - InvalidSpace
    - `13` - ConsecutiveSpaces
    - `14` - RussianConsecutiveSilentCharacters
    - `15` - RussianSilentCharacterAtBeginningOrEnd
    - `16` - DeclensionDoesn't Match BaseName
    - `17` - SpacesDisallowed

**Change Log:**
Added in 8.2.5