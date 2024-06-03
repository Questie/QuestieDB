## Title: GetBindingKey

**Content:**
Returns the keys bound to the given command.
`key1, key2, ... = GetBindingKey(command)`

**Parameters:**
- `command`
  - The name of the command to get key bindings for (e.g. MOVEFORWARD, TOGGLEFRIENDSTAB)

**Returns:**
- (Variable returns)
  - `key1`
    - *string* - The string representation(s) of all the key(s) bound to this command (e.g. W, CTRL-F)
  - `key2`
    - *string*

**Usage:**
```lua
local command, key1, key2 = GetBinding("MOVEFORWARD")
DEFAULT_CHAT_FRAME:AddMessage(BINDING_NAME_MOVEFORWARD .. " has the following keys bound:")
if key1 then
  DEFAULT_CHAT_FRAME:AddMessage(key1)
end
if key2 then
  DEFAULT_CHAT_FRAME:AddMessage(key2)
end
```

**Description:**
Even though the default Key Binding window only shows up to two bindings for each command, it is actually possible to bind more using SetBinding, and this function will return all of the keys bound to the given command, not just the first two.

**Reference:**
- `GetBinding`
- `GetBindingAction`
- `GetBindingByKey`