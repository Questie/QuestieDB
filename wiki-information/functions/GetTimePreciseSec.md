## Title: GetTimePreciseSec

**Content:**
Returns a monotonic timestamp in seconds, with millisecond precision.
`seconds = GetTimePreciseSec()`

**Returns:**
- `seconds`
  - *number* - The number of seconds that have elapsed since this timer was started.

**Description:**
The first call to this function will always return zero. Subsequent calls will return the number of seconds that have elapsed since the first call until the client is restarted.
Unlike `GetTime()`, the value returned by this function is not cached once per frame and may change on each call.

**Usage:**
```lua
print("Start time:", GetTimePreciseSec());
for _ = 1, 2^26 do
  -- Busy loop to make some time pass.
end
print("End time:", GetTimePreciseSec());
-- Output:
-- "Start time:", 0
-- "End time:", 0.3624231
```

**Reference:**
- `GetTime()`