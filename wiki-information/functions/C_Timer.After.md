## Title: C_Timer.After

**Content:**
Schedules a timer.
`C_Timer.After(seconds, callback)`

**Parameters:**
- `seconds`
  - *number* - Time in seconds before the timer finishes.
- `callback`
  - *function|FunctionContainer* - Callback function to run.

**Usage:**
Prints "Hello" after 2.5 seconds.
```lua
/run C_Timer.After(2.5, function() print("Hello") end)
```
RunNextFrame is a utility function with zero seconds delay.
```lua
-- prints "hello" and then "world"
RunNextFrame(function() print("world") end)
print("hello")
```

**Description:**
With a duration of 0 ms, the earliest the callback will be called is on the next frame.
Timing accuracy is limited to the frame rate.
C_Timer.After() is generally more efficient than using an Animation or OnUpdate script.

In most cases, initiating a second C_Timer is still going to be cheaper than using an Animation or OnUpdate. The issue here is that both Animation and OnUpdate calls have overhead that applies every frame while they are active. For OnUpdate, the overhead lies in the extra function call to Lua. For Animations, we’re doing work C-side that allows us to support smoothing, parallel animations, and animation propagation. In contrast, the new C_Timer system uses a standard heap implementation. It’s only doing work when the timer is created or destroyed (and even then, that work is fairly minimal).

The one case where you’re better off not using the new C_Timer system is when you have a ticker with a very short period – something that’s going to fire every couple frames. For example, you have a ticker you want to fire every 0.05 seconds; you’re going to be best served by using an OnUpdate function (where about half the function calls will do something useful and half will just decrement the timer).