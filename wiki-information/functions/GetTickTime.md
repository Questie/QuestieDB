## Title: GetTickTime

**Content:**
Returns the time in seconds since the end of the previous frame and the start of the current frame.
`elapsed = GetTickTime()`

**Returns:**
- `elapsed`
  - *number* - The time in seconds since the last frame.

**Description:**
Multiple calls to this function within the same frame will all return the same value.
The value returned from this function appears to be identical to the value passed to OnUpdate scripts executed at the end of the current frame as the elapsed parameter.