## Event: CLUB_MESSAGE_ADDED

**Title:** CLUB MESSAGE ADDED

**Content:**
Needs summary.
`CLUB_MESSAGE_ADDED: clubId, streamId, messageId`

**Payload:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `messageId`
  - *structure* - ClubMessageIdentifier
    - ClubMessageIdentifier
      - Field
        - Type
          - Description
      - epoch
        - *number* - number of microseconds since the UNIX epoch
      - position
        - *number* - sort order for messages at the same time