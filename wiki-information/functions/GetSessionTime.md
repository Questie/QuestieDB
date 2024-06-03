## Title: GetSessionTime

**Content:**
Returns the time since you opened the game client.
`sessionTime = GetSessionTime()`

**Returns:**
- `sessionTime`
  - *number* - Time in seconds since you started the game client.

**Description:**
Used on the Korean locale to warn against excessive gameplay time.

**Reference:**
- `GetTime()` - local machine uptime.
- References:
  - [GitHub Commit](https://github.com/Gethe/wow-ui-source/commit/3770c879e4a0db9f4f37e835a77d69eb0ec66efb#diff-54f1522769d9602c5cdd7b482d137f70R446)