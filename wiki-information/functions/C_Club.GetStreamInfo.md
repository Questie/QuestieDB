## Title: C_Club.GetStreamInfo

**Content:**
Needs summary.
`streamInfo = C_Club.GetStreamInfo(clubId, streamId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*

**Returns:**
- `streamInfo`
  - *structure* - ClubStreamInfo (nilable)
    - `ClubStreamInfo`
      - `Field`
      - `Type`
      - `Description`
      - `streamId`
        - *string*
      - `name`
        - *string*
      - `subject`
        - *string*
      - `leadersAndModeratorsOnly`
        - *boolean*
      - `streamType`
        - *Enum.ClubStreamType*
      - `creationTime`
        - *number*

**Enum.ClubStreamType:**
- `Value`
- `Field`
- `Description`
- `0`
  - General
- `1`
  - Guild
- `2`
  - Officer
- `3`
  - Other