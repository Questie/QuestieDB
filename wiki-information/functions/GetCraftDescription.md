## Title: GetCraftDescription

**Content:**
This command returns a string description of what the current craft does. 
`craftDescription = GetCraftDescription(index)`

**Parameters:**
- `index`
  - *number* - Number from 1 to X number of total crafts, where 1 is the top-most craft listed.

**Returns:**
- `craftDescription`
  - *string* - Returns, for example, "Permanently enchant a two handed melee weapon to grant +25 Agility."

**Example Usage:**
```lua
local index = 1
local description = GetCraftDescription(index)
print(description)  -- Output: "Permanently enchant a two handed melee weapon to grant +25 Agility."
```

**Additional Information:**
This function is often used in crafting-related addons to display detailed information about what each craft does. For example, an addon that helps players manage their professions might use this function to show descriptions of all available crafts in a user-friendly interface.