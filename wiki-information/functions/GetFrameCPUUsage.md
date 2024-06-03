## Title: GetFrameCPUUsage

**Content:**
Returns the total time used by and number of calls of a frame's event handlers.
`time, count = GetFrameCPUUsage(frame)`

**Parameters:**
- `frame`
  - *Frame* - Specifies the frame.
- `includeChildren`
  - *boolean* - If false, only event handlers of the specified frame are considered. If true or omitted, the values returned will include the handlers for all of the frame's children as well.

**Returns:**
- `time`
  - *number* - The total time used by the specified event handlers, in milliseconds.
- `count`
  - *number* - The total number of times the event handlers were called.

**Description:**
The values returned are just the sum of the values returned by `GetFunctionCPUUsage(handler)` for all current handlers. This means that it's not per-frame values, but per-function values. The difference is that if, for example, an `OnEvent` handler is used by two frames A and B, and, say, `B:OnEvent()` is called, both A and B get blamed for it.

It also means that if a frame's handlers change, the CPU used by the previous handlers is ignored, because only the current handlers are considered.

Note that `OnUpdate` CPU usage is NOT included at all (tested at 6.0.3).