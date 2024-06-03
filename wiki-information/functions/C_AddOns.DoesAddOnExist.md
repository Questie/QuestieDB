## Title: C_AddOns.DoesAddOnExist

**Content:**
Needs summary.
`exists = C_AddOns.DoesAddOnExist(name)`

**Parameters:**
- `name`
  - *string|number*

**Returns:**
- `exists`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific addon is installed and available in the game. For instance, if you want to verify if the "Deadly Boss Mods" addon is installed, you can use this function as follows:
```lua
local addonName = "Deadly Boss Mods"
local exists = C_AddOns.DoesAddOnExist(addonName)
if exists then
    print(addonName .. " is installed.")
else
    print(addonName .. " is not installed.")
end
```

**Usage in Addons:**
Many large addons, such as ElvUI, use this function to check for the presence of other addons to ensure compatibility or to provide additional functionality if certain addons are detected. For example, ElvUI might check if "WeakAuras" is installed to offer enhanced integration features.