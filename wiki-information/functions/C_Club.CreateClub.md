## Title: C_Club.CreateClub

**Content:**
Needs summary.
`C_Club.CreateClub(name, shortName, description, clubType, avatarId, isCrossFaction)`

**Parameters:**
- `name`
  - *string* - The name of the club.
- `shortName`
  - *string?* - An optional short name for the club.
- `description`
  - *string* - A description of the club.
- `clubType`
  - *Enum.ClubType* - Valid types are BattleNet or Character.
    - **Value**
    - **Field**
    - **Description**
    - `0`
      - *BattleNet*
    - `1`
      - *Character*
    - `2`
      - *Guild*
    - `3`
      - *Other*
- `avatarId`
  - *number* - The ID of the avatar for the club.
- `isCrossFaction`
  - *boolean?* - An optional boolean indicating if the club is cross-faction.