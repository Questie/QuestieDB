## Title: GetCoinTextureString

**Content:**
Breaks up an amount of money into gold/silver/copper with icons.
`formattedAmount = GetCoinTextureString(amount)`

**Parameters:**
- `amount`
  - *number* - the amount of money in copper (for example, the return value from GetMoney)
- `fontHeight`
  - *number?* - the height of the coin icon; if not specified, defaults to 14.

**Returns:**
- `formattedAmount`
  - *string* - a string suitable for printing or displaying.

**Usage:**
```lua
-- Example usage of GetMoney and GetCoinTextureString
GetMoney()
local money = GetMoney()
local gold = floor(money / 1e4)
local silver = floor(money / 100 % 100)
local copper = money % 100
print(("You have %dg %ds %dc"):format(gold, silver, copper))
-- You have 10851g 62s 40c

-- Using GetCoinText
print(GetCoinText(GetMoney())) -- "10851 Gold, 62 Silver, 40 Copper"
print(GetCoinText(12345678, " ")) -- "1234 Gold 23 Silver 45 Copper"
print(GetCoinText(12345678, "X")) -- "1234 GoldX23 SilverX45 Copper"

-- Using GetMoneyString
print(GetMoneyString(12345678))
print(GetMoneyString(12345678, true))
-- 1234 56 78
-- 1,234 56 78

-- Using GetCoinTextureString
print(GetCoinTextureString(1234578))
print(GetCoinTextureString(1234578, 24))
-- 1234 56 78
-- 1234 56 78
```

**Example Use Case:**
This function is particularly useful in addons that display the player's current money in a more visually appealing way, such as in tooltips, UI elements, or chat messages. For instance, an addon like "Titan Panel" might use this function to show the player's gold, silver, and copper with appropriate icons on the panel.

**Addons Using This Function:**
- **Titan Panel:** This popular addon uses `GetCoinTextureString` to display the player's current money on the panel with icons, making it easier to read at a glance.
- **Bagnon:** Another widely used addon, Bagnon, might use this function to show the total money across all characters in a unified and visually appealing format.