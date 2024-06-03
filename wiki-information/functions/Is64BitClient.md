## Title: Is64BitClient

**Content:**
Needs summary.
`is64Bit = Is64BitClient()`

**Returns:**
- `is64Bit`
  - *boolean*

**Example Usage:**
This function can be used to determine if the World of Warcraft client is running in a 64-bit environment. This can be useful for addons that need to optimize performance or compatibility based on the architecture of the client.

**Example:**
```lua
if Is64BitClient() then
    print("Running on a 64-bit client.")
else
    print("Running on a 32-bit client.")
end
```

**Addons:**
Many performance-intensive addons, such as WeakAuras, might use this function to adjust their behavior based on the client's architecture to ensure optimal performance.