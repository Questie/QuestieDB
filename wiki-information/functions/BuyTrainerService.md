## Title: BuyTrainerService

**Content:**
Buys a trainer service (e.g. class skills and profession recipes).
`BuyTrainerService(index)`

**Parameters:**
- `index`
  - *number* - The index of the service to train.

**Returns:**
- `nil`

**Example Usage:**
```lua
-- Assuming you are at a trainer and want to buy the first service available
BuyTrainerService(1)
```

**Description:**
This function is used to purchase a service from a trainer, such as learning a new class skill or profession recipe. The `index` parameter corresponds to the position of the service in the trainer's list.

**Usage in Addons:**
Many addons that automate or enhance the training process, such as profession leveling addons, use this function to programmatically purchase skills or recipes from trainers. For example, an addon like "TradeSkillMaster" might use this function to help users quickly buy all available profession recipes.