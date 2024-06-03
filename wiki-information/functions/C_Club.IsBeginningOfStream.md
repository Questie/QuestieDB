## Title: C_Club.IsBeginningOfStream

**Content:**
Needs summary.
`isBeginningOfStream = C_Club.IsBeginningOfStream(clubId, streamId, messageId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `messageId`
  - *structure* - ClubMessageIdentifier
    - `ClubMessageIdentifier`
      - `Field`
      - `Type`
      - `Description`
      - `epoch`
        - *number* - number of microseconds since the UNIX epoch
      - `position`
        - *number* - sort order for messages at the same time

**Returns:**
- `isBeginningOfStream`
  - *boolean*

**Description:**
Returns whether the given message is the first message in the stream, taking into account ignored messages.