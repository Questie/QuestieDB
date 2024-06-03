## Title: GetPetFoodTypes

**Content:**
Returns the food types the pet can eat.
`petFoodList = { GetPetFoodTypes() }`

**Returns:**
- multiple Strings (not a table)
  - Possible strings:
    - Meat
    - Fish
    - Fruit
    - Fungus
    - Bread
    - Cheese

**Usage:**
To print every string from the list into the default chatframe.
```lua
local petFoodList = { GetPetFoodTypes() };
if #petFoodList > 0 then
  local index, foodType;
  for index, foodType in pairs(petFoodList) do
    DEFAULT_CHAT_FRAME:AddMessage(foodType);
  end
else
  DEFAULT_CHAT_FRAME:AddMessage("No pet food types available.");
end
```