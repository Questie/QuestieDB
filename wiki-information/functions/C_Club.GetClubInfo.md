## Title: C_Club.GetClubInfo

**Content:**
Needs summary.
`info = C_Club.GetClubInfo(clubId)`

**Parameters:**
- `clubId`
  - *string*

**Returns:**
- `info`
  - *ClubInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `clubId`
      - *string*
    - `name`
      - *string*
    - `shortName`
      - *string?*
    - `description`
      - *string*
    - `broadcast`
      - *string*
    - `clubType`
      - *Enum.ClubType*
    - `avatarId`
      - *number*
    - `memberCount`
      - *number?*
    - `favoriteTimeStamp`
      - *number?*
    - `joinTime`
      - *number?*
        - UNIX timestamp measured in microsecond precision.
    - `socialQueueingEnabled`
      - *boolean?*
    - `crossFaction`
      - *boolean?*
        - Added in 9.2.5

**Enum.ClubType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - BattleNet
  - `1`
    - Character
  - `2`
    - Guild
  - `3`
    - Other