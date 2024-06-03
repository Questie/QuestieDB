## Title: SetConsoleKey

**Content:**
Sets the console key (normally ~).
`SetConsoleKey(key)`

**Parameters:**
- `key`
  - *string* - The character to bind to opening the console overlay, or `nil` to disable the console binding.

**Description:**
The console is only accessible when WoW is started with the `-console` parameter. This function does nothing if the parameter wasn't used.
The console key is not saved by the WoW client, and will revert to the default ` (backtick) key when WoW is restarted.
Unlike the `SetBinding` function, you can only provide the values of keys that represent standard ASCII characters; no modifiers are allowed. For instance, `SetConsoleKey("CTRL-F")` won't work, but `SetConsoleKey("F")` will. In addition, non-alphabetic keys that require modifiers to access, such as `!` using ⇧ Shift+1, cannot be used.
The console key overrides all other key bindings in WoW, regardless of context. This means that if you set it to `F`, you'll be unable to type the `F` character in chat until you restart WoW.