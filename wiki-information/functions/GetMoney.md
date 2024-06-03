## Title: GetMoney

**Content:**
Returns the amount of money the player character owns.
`money = GetMoney()`

**Returns:**
- `money`
  - *number* - The amount of money the player's character has, in copper.

**Description:**
Related Events:
- `PLAYER_MONEY`

Available after:
- `PLAYER_ENTERING_WORLD` (on login)

**Usage:**
```lua
GetMoney()
local money = GetMoney()
local gold = floor(money / 1e4)
local silver = floor(money / 100 % 100)
local copper = money % 100
print(("You have %dg %ds %dc"):format(gold, silver, copper))
-- You have 10851g 62s 40c

GetCoinText(amount)
print(GetCoinText(GetMoney())) -- "10851 Gold, 62 Silver, 40 Copper"
print(GetCoinText(12345678, " ")) -- "1234 Gold 23 Silver 45 Copper"
print(GetCoinText(12345678, "X")) -- "1234 GoldX23 SilverX45 Copper"

GetMoneyString(amount)
print(GetMoneyString(12345678))
print(GetMoneyString(12345678, true))
-- 1234 56 78
-- 1,234 56 78

GetCoinTextureString(amount)
print(GetCoinTextureString(1234578))
print(GetCoinTextureString(1234578, 24))
-- 1234 56 78
-- 1234 56 78
```

**Example Use Case:**
The `GetMoney` function can be used in addons to display the player's current money in various formats. For instance, an addon that tracks and displays the player's wealth over time would use this function to get the current amount of money and then store or display it.

**Addons Using This Function:**
Many popular addons, such as "Titan Panel" and "Bagnon," use the `GetMoney` function to display the player's current money on the screen or in the inventory interface. These addons provide a convenient way to keep track of your gold, silver, and copper without having to open the character's inventory.