## Title: C_Club.EditStream

**Content:**
Needs summary.
`C_Club.EditStream(clubId, streamId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string*
- `name`
  - *string?*
- `subject`
  - *string?*
- `leadersAndModeratorsOnly`
  - *boolean?*

**Description:**
Check the `canSetStreamName`, `canSetStreamSubject`, `canSetStreamAccess` privileges. `nil` arguments will not change existing stream data.