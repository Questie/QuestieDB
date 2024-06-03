## Title: debugprofilestart

**Content:**
Starts a timer for profiling during debugging.
`debugprofilestart()`

Note that the timer does not actually need to be started. This is more of a global "reset" of the timer.
Since it is global, it is probably best to never call this function. Rather just call `debugprofilestop()` 2 times and compare the difference.

**Reference:**
- `debugprofilestop`