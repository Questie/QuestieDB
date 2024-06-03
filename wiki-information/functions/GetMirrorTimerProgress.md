## Title: GetMirrorTimerProgress

**Content:**
Returns the current value of the mirror timer.
`value = GetMirrorTimerProgress(timer)`

**Parameters:**
- `timer`
  - *string* - the first return value from `GetMirrorTimerInfo`, identifying the timer queried. Valid values include "EXHAUSTION", "BREATH" and "FEIGNDEATH".

**Returns:**
- `value`
  - *number* - current value of the timer. If the timer is not active, 0 is returned.

**Reference:**
- `GetMirrorTimerInfo`