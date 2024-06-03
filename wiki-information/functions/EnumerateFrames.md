## Title: EnumerateFrames

**Content:**
Returns the frame which follows the current frame.
`nextFrame = EnumerateFrames()`

**Parameters:**
- `currentFrame`
  - *Frame* - The current frame. If omitted, returns the first frame.

**Returns:**
- `nextFrame`
  - *Frame* - The frame following `currentFrame`. Returns `nil` if there are no more frames.

**Usage:**
The following snippet prints the names of all visible frames under the mouse cursor.
```lua
local f = EnumerateFrames()
while f do
    if f:IsVisible() and f:IsMouseOver() then
        print(f:GetDebugName())
    end
    f = EnumerateFrames(f)
end
```

**Description:**
This API enumerates every single non-forbidden frame whether named, unnamed, or anonymous script handlers. This includes all descendants of other frames.
- If you're using this to search for a frame, make sure you return or break out of the while loop early so you don't continue looping after you get what you need. Not only will you save CPU time, you will also have access to the frame sooner and are less likely to cause lockups.
- If you know the name of the frame you're looking for, don't use this function, just use the frame's name directly or get it from the `_G` table.
- If you're looking for frame(s) that have specific events registered, don't use this function, just use `GetFramesRegisteredForEvent`.
- Don't make new frames inside the while loop.
- The order of iteration follows the order that the frames were created in.