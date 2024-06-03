## Title: C_Timer.NewTimer

**Content:**
Schedules a (repeating) timer that can be canceled.
`cbObject = C_Timer.NewTimer(seconds, callback)`
`cbObject = C_Timer.NewTicker(seconds, callback)`

**Parameters:**
- `seconds`
  - *number* - Time in seconds between each iteration.
- `callback`
  - *function|FunctionContainer* - Callback function to run.
- `iterations`
  - *number?* - Number of times to repeat, or indefinite if omitted.

**Returns:**
- `cbObject`
  - *userdata : FunctionContainer* - Timer handle with `:Cancel()` and `:IsCancelled()` methods.

**Description:**
The callback function will be supplied a view of the timer handle (`cbObject`) when invoked.
The handle returned from the function and the one supplied to the callback are distinct objects that both reference a shared state. See the examples for more details.
`C_Timer.NewTimer()` has just a single iteration and is essentially the same as `C_Timer.NewTicker(duration, callback, 1)`.
Errors thrown inside a callback function will not halt the ticker.

**Usage:**
- Schedules a repeating timer which runs 4 times.
  ```lua
  /run C_Timer.NewTicker(2.5, function() print(GetTime()) end, 4)
  ```
- Schedules a timer but cancels it right away.
  ```lua
  local myTimer = C_Timer.NewTimer(3, function() print("Hello") end)
  print(myTimer:IsCancelled()) -- false
  myTimer:Cancel()
  print(myTimer:IsCancelled()) -- true
  ```
- Schedules a timer that prints a value written to a field stored on the timer handle itself. Timer handles all reference the same shared state internally, so user-defined fields written to handles can be used to supply additional data for use by the callback.
  ```lua
  local myTimer = C_Timer.NewTimer(2.5, function(self) print("self.data is:", self.data) end)
  myTimer.data = GetTime()
  ```
- Schedules a repeating timer which runs 4 times and prints the timer handle returned from the function and supplied to the callback. Note that each print will result in a different object address being displayed, indicating the timer handles have a distinct identity.
  ```lua
  /run print(C_Timer.NewTicker(0.25, function(self) print(self) end, 4))
  ```

**Reference:**
- AceTimer-3.0
- OnUpdate