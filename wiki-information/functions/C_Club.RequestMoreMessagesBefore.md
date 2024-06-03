## Title: C_Club.RequestMoreMessagesBefore

**Content:**
Needs summary.
`alreadyHasMessages = C_Club.RequestMoreMessagesBefore(clubId, streamId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `messageId`
  - *structure* - ClubMessageIdentifier (optional)
    - `ClubMessageIdentifier`
      - `Field`
      - `Type`
      - `Description`
      - `epoch`
        - *number* - number of microseconds since the UNIX epoch
      - `position`
        - *number* - sort order for messages at the same time
      - `count`
        - *number?*

**Returns:**
- `alreadyHasMessages`
  - *boolean*

**Description:**
Call this when the user scrolls near the top of the message view, and more need to be displayed. The history will be downloaded backwards (newest to oldest).