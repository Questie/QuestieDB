## Title: debugprofilestop

**Content:**
Returns the time in milliseconds since the last call to `debugprofilestart()`.
`elapsedMilliseconds = debugprofilestop()`

**Returns:**
- `elapsedMilliseconds`
  - *number* - Time since profiling was started in milliseconds.

**Description:**
Debug profiling provides a high-precision timer that can be used to profile code.
Calling this function, despite its name, does NOT stop the timer. It simply returns the time since the previous `debugprofilestart()` call!

Note that if you are simply using this to profile your own code, it is preferable to NOT keep re-starting the timer since it will interfere with other addons doing the same. Instead, do this:
```lua
local beginTime = debugprofilestop()
-- do lots of stuff
-- that takes lots of time

local timeUsed = debugprofilestop() - beginTime
print("I used " .. timeUsed .. " milliseconds!")
```

**Reference:**
- `debugprofilestart`

**Example Use Case:**
This function is particularly useful for addon developers who need to measure the performance of their code. For instance, if you are developing an addon that processes a large amount of data, you can use `debugprofilestop()` to measure how long the processing takes and optimize accordingly.

**Addons Using This Function:**
Many performance monitoring addons, such as "Details! Damage Meter" and "WeakAuras," use `debugprofilestop()` to measure the execution time of various functions and scripts to ensure they run efficiently.