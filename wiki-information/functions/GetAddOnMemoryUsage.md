## Title: GetAddOnMemoryUsage

**Content:**
Returns the memory used for an addon.
`mem = GetAddOnMemoryUsage(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `mem`
  - *number* - Memory usage of the addon in kilobytes.

**Description:**
This function returns a cached value calculated by `UpdateAddOnMemoryUsage()`. This function will raise an error if a secure Blizzard addon is queried.

**Usage:**
Prints the memory usage for all addons.
```lua
UpdateAddOnMemoryUsage()
for i = 1, GetNumAddOns() do
    local name = GetAddOnInfo(i)
    print(GetAddOnMemoryUsage(i), name)
end
```

**Example Use Case:**
This function can be used by addon developers to monitor and optimize the memory usage of their addons. For instance, developers can periodically check the memory usage to ensure their addon is not consuming excessive resources, which can help in maintaining the performance of the game.

**Addons Using This Function:**
Many performance monitoring addons, such as "Addon Control Panel" and "Details! Damage Meter," use this function to display memory usage statistics to the user. This helps players identify which addons are using the most memory and manage their addon load accordingly.