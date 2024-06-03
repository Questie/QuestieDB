## Title: C_Club.GetMessageRanges

**Content:**
Needs summary.
`ranges = C_Club.GetMessageRanges(clubId, streamId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*

**Returns:**
- `ranges`
  - *structure* - ClubMessageRange
    - `ClubMessageRange`
      - `Field`
      - `Type`
      - `Description`
      - `oldestMessageId`
        - *ClubMessageIdentifier*
      - `newestMessageId`
        - *ClubMessageIdentifier*
    - `ClubMessageIdentifier`
      - `Field`
      - `Type`
      - `Description`
      - `epoch`
        - *number* - number of microseconds since the UNIX epoch
      - `position`
        - *number* - sort order for messages at the same time

**Description:**
Get the ranges of the messages currently downloaded.