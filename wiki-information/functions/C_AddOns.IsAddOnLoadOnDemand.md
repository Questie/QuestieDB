## Title: C_AddOns.IsAddOnLoadOnDemand

**Content:**
Needs summary.
`loadOnDemand = C_AddOns.IsAddOnLoadOnDemand(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to C_AddOns.GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loadOnDemand`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific addon is set to load on demand. This is useful for addon developers who want to manage dependencies and ensure that certain addons are only loaded when necessary.

**Example:**
```lua
local addonName = "MyAddon"
local isLoadOnDemand = C_AddOns.IsAddOnLoadOnDemand(addonName)
print(addonName .. " is load on demand: " .. tostring(isLoadOnDemand))
```

**Usage in Addons:**
Many large addons, such as WeakAuras, use this function to check the load state of their modules or dependencies to optimize performance and memory usage.