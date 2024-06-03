## Title: GetNumCrafts

**Content:**
Returns the number of crafts in the currently opened crafting window. Usually used to loop through all available crafts to perform API `GetCraftInfo` on them.
`numberOfCrafts = GetNumCrafts()`

**Example Usage:**
```lua
local numberOfCrafts = GetNumCrafts()
for i = 1, numberOfCrafts do
    local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(i)
    print("Craft Name: " .. craftName)
end
```

**Additional Information:**
- This function is often used in crafting-related addons to iterate through all available crafts and gather information about them.
- Addons like "TradeSkillMaster" use this function to manage and optimize crafting operations by retrieving detailed information about each craft available in the crafting window.