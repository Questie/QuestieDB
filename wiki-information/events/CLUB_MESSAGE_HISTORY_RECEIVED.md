## Event: CLUB_MESSAGE_HISTORY_RECEIVED

**Title:** CLUB MESSAGE HISTORY RECEIVED

**Content:**
Needs summary.
`CLUB_MESSAGE_HISTORY_RECEIVED: clubId, streamId, downloadedRange, contiguousRange`

**Payload:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `downloadedRange`
  - ClubMessageRange - Range of history messages received.
- `contiguousRange`
  - ClubMessageRange - Range of contiguous messages that the received messages are in.
- Field
  - Type
  - Description
  - oldestMessageId
    - ClubMessageIdentifier
  - newestMessageId
    - ClubMessageIdentifier
  - ClubMessageIdentifier
    - Field
      - Type
      - Description
      - epoch
        - number
        - number of microseconds since the UNIX epoch
      - position
        - number
        - sort order for messages at the same time