## Title: GetGuildBankWithdrawMoney

**Content:**
Returns the amount of money the player is allowed to withdraw from the guild bank.
`withdrawLimit = GetGuildBankWithdrawMoney()`

**Returns:**
- `withdrawLimit`
  - Amount of money the player is allowed to withdraw from the guild bank (in copper), or 2^64 if the player has unlimited withdrawal privileges (is Guild Master).

**Description:**
Returns the amount remaining for the day; that is (Daily amount) - (amount already spent).