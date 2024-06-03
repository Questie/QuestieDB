## Title: GetFramesRegisteredForEvent

**Content:**
Returns all frames registered for the specified event, in dispatch order.
`frame1, frame2, ... = GetFramesRegisteredForEvent(event)`

**Parameters:**
- `event`
  - *string* - Event for which to return registered frames, e.g. "PLAYER_LOGOUT"

**Returns:**
- `frame1, ...`
  - *Widget* - widget registered for the specified event.

**Description:**
The first frame returned will be the first to receive the given event, and likewise the last returned will receive the event last. A frame can be moved to the end of this event list order by unregistering and then reregistering for the event.
Currently, frames registered via `Frame:RegisterAllEvents` will be returned before all other frames, but they will actually receive events last (as they are used to profile the normal frames' handlers). This suggests that the above ordering is not always reliable. (Last checked 8.3.7)

**Usage:**
The snippet below unregisters the PLAYER_LOGOUT events from every frame listening for it:
```lua
local function unregister(event, widget, ...)
  if widget then
    widget:UnregisterEvent(event)
    return unregister(event, ...)
  end
end
unregister("PLAYER_LOGOUT", GetFramesRegisteredForEvent("PLAYER_LOGOUT"))
```

**Example Use Case:**
This function can be used in debugging or addon development to understand which frames are listening for a specific event and in what order they will receive the event. This can be particularly useful when troubleshooting event handling issues or optimizing event dispatching.

**Addon Usage:**
Large addons like ElvUI or WeakAuras might use this function to manage event handling more efficiently, ensuring that their frames are registered and unregistered for events in the correct order to avoid conflicts and ensure optimal performance.