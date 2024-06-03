## Title: geterrorhandler

**Content:**
Returns the currently set error handler.
`handler = geterrorhandler()`

**Returns:**
- `handler`
  - *function* - The current error handler. Receives a message as an argument, normally a string that is the second return value from `pcall()`.

**Usage:**
```lua
local myError = "Something went horribly wrong!"
geterrorhandler()(myError)
```

**Example Use Case:**
The `geterrorhandler` function can be used to retrieve the current error handler function, which can then be invoked with a custom error message. This is useful for debugging or logging errors in a controlled manner.

**Addons Using This Function:**
Many large addons, such as WeakAuras and ElvUI, use custom error handlers to manage and log errors gracefully without disrupting the user experience. They might use `geterrorhandler` to ensure that their custom error handling logic is in place or to temporarily replace the default error handler during critical operations.