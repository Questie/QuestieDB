## Title: GetCoinText

**Content:**
Breaks up an amount of money into gold/silver/copper.
`formattedAmount = GetCoinText(amount)`

**Parameters:**
- `amount`
  - *number* - the amount of money in copper (for example, the return value from GetMoney)
- `separator`
  - *string?* - a string to insert between the formatted amounts of currency, if there is more than one type

**Returns:**
- `formattedAmount`
  - *string* - a (presumably localized) string suitable for printing or displaying

**Usage:**
```lua
-- Example usage of GetMoney and GetCoinText
GetMoney()
local money = GetMoney()
local gold = floor(money / 1e4)
local silver = floor(money / 100 % 100)
local copper = money % 100
print(("You have %dg %ds %dc"):format(gold, silver, copper))
-- Output: You have 10851g 62s 40c

-- Using GetCoinText
print(GetCoinText(GetMoney())) -- "10851 Gold, 62 Silver, 40 Copper"
print(GetCoinText(12345678, " ")) -- "1234 Gold 23 Silver 45 Copper"
print(GetCoinText(12345678, "X")) -- "1234 GoldX23 SilverX45 Copper"

-- Using GetMoneyString
print(GetMoneyString(12345678))
print(GetMoneyString(12345678, true))
-- Output: 1234 56 78
-- Output: 1,234 56 78

-- Using GetCoinTextureString
print(GetCoinTextureString(1234578))
print(GetCoinTextureString(1234578, 24))
-- Output: 1234 56 78
-- Output: 1234 56 78
```

**Example Use Case:**
This function is particularly useful for addons that need to display the player's current amount of money in a user-friendly format. For instance, an auction house addon might use `GetCoinText` to show the total amount of money a player has after selling items.

**Addons Using This Function:**
- **Auctioneer**: This addon uses `GetCoinText` to display the player's current gold, silver, and copper in various parts of its interface, such as when listing items for sale or showing the total earnings from auctions.
- **Bagnon**: This inventory management addon uses `GetCoinText` to show the total amount of money a player has across all their characters and banks.