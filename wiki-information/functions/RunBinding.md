## Title: RunBinding

**Content:**
Executes a key binding.
`RunBinding(command)`

**Parameters:**
- `command`
  - *string* - Name of the key binding to be executed
- `up`
  - *string?* - If "up", the binding is run as if the key was released.

**Usage:**
The call below toggles the display of the FPS counter, as if CTRL+R was pressed.
```lua
RunBinding("TOGGLEFPS");
```

**Description:**
The `command` argument must match one of the (usually capitalized) binding names in a Bindings.xml file. This can be a name that appears in the Blizzard FrameXML Bindings.xml, or one that is specified in an AddOn.
`RunBinding` cannot be used to call a Protected Function from insecure execution paths.
By default, the key binding is executed as if the key was pressed down, in other words, the `keystate` variable will have value "down" during the binding's execution. By specifying the optional second argument (the actual string "up"), the binding is instead executed as if the key was released, in other words, the `keystate` variable will have value "up" during the binding's execution.