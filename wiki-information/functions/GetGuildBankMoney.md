## Title: GetGuildBankMoney

**Content:**
Returns the amount of money in the guild bank.
`retVal1 = GetGuildBankMoney()`

**Returns:**
- `retVal1`
  - *number* - money in copper

**Usage:**
```lua
/script DEFAULT_CHAT_FRAME:AddMessage(GetGuildBankMoney());
```
**Result:**
```
8900000
```

**Description:**
Will return 0 (zero) if the guild bank frame was not opened, or a cached value from the last time the guild bank frame was opened on any character since the game client was started.