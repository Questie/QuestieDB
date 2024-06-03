## Title: GetNumSockets

**Content:**
Returns the number of sockets for an item in the socketing window.

**Parameters:**
- None

**Returns:**
- `Sockets`
  - *Number* - The number of sockets in the item currently in the item socketing window. If the item socketing window is closed, 0.

**Usage:**
```lua
local SocketCount = GetNumSockets()
for i = 1, SocketCount do
  print(GetSocketInfo(i))
end
```

**Description:**
This function is only useful if the item socketing window is currently visible.