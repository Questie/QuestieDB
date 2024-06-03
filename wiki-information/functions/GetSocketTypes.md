## Title: GetSocketTypes

**Content:**
Returns the type (color) of a socket in the item.

**Parameters:**
- `Index`
  - *Number* - The 1-based index of the socket for which to get information.

**Returns:**
- `SocketType`
  - *String* - The type of the socket at position Index. The value could be any of these (apparently unlocalized) strings:
    - `"Red"` - Red socket
    - `"Yellow"` - Yellow socket
    - `"Blue"` - Blue socket
    - `"Meta"` - Meta socket
    - `"Socket"` - Prismatic socket

**Usage:**
```lua
local SocketCount = GetNumSockets()
for i = 1, SocketCount do
  print(GetSocketInfo(i))
end
```

**Description:**
This function is only useful if the item socketing window is currently visible.