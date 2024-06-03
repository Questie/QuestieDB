## Event: MIRROR_TIMER_START

**Title:** MIRROR TIMER START

**Content:**
Fired when some sort of timer starts.
`MIRROR_TIMER_START: timerName, value, maxValue, scale, paused, timerLabel`

**Payload:**
- `timerName`
  - *string* - e.g. "BREATH"
- `value`
  - *number* - start-time in ms, e.g. 180000
- `maxValue`
  - *number* - max-time in ms, e.g. 180000
- `scale`
  - *number* - time added per second in seconds, for e.g. -1
- `paused`
  - *number*
- `timerLabel`
  - *string* - e.g. "Breath"