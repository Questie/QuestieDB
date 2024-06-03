## Title: GetStablePetFoodTypes

**Content:**
Returns the food types the specified stabled pet can eat.
```lua
local PetFoodList = { GetStablePetFoodTypes(index) }
```

**Parameters:**
- `index`
  - *number* - The stable slot index of the pet: 0 for the current pet, 1 for the pet in the left slot, and 2 for the pet in the right slot.

**Returns:**
A list of the pet food type names, see `GetPetFoodTypes()`.

Possible Food Type Names:
- Meat
- Fish
- Fruit
- Fungus
- Bread
- Cheese