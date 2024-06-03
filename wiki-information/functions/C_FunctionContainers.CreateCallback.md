## Title: C_FunctionContainers.CreateCallback

**Content:**
Creates a function container that invokes a cancellable callback function.
`container = C_FunctionContainers.CreateCallback(func)`

**Parameters:**
- `func`
  - *function* - A Lua function to be called.

**Returns:**
- `container`
  - *FunctionContainer* - A container object bound to the supplied function.

**Description:**
The supplied callback must be a Lua function. The API will reject C functions and any non-function values.

**Usage:**
The following snippet creates a function container and schedules it to be executed every second, cancelling itself after five calls.
```lua
local container
container = C_FunctionContainers.CreateCallback(function()
  container.timesCalled = container.timesCalled + 1
  if container.timesCalled == 5 then
    container:Cancel()
  end
  print("Called!")
end)
container.timesCalled = 0
C_Timer.NewTicker(1, container)
```

**Example Use Case:**
This function can be used in scenarios where you need to repeatedly execute a function with the ability to cancel it after a certain condition is met. For instance, it can be used in an addon to periodically check for updates or changes in the game state and stop checking after a certain number of iterations.

**Addon Usage:**
Large addons like WeakAuras might use this function to create dynamic and cancellable callbacks for custom animations or periodic checks. This allows for efficient resource management by ensuring that callbacks are only active when needed and can be cancelled when their purpose is fulfilled.