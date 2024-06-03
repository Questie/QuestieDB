## Title: PartialPlayTime

**Content:**
Returns true if the account is considered "tired" for players on Chinese realms.
`isTired = NoPlayTime()`

**Returns:**
- `isTired`
  - *boolean?* - 1 if the account is "tired", nil if not. See details below for clarification. Returns nil for EU and US accounts.

**Usage:**
Based on the official function, changed a bit to output the text in the chat rather than the tooltip on your avatar:
```lua
if PartialPlayTime() then
  print(string.format(PLAYTIME_TIRED, REQUIRED_REST_HOURS - math.floor(GetBillingTimeRested()/60)))
elseif NoPlayTime() then
  print(string.format(PLAYTIME_UNHEALTHY, REQUIRED_REST_HOURS - math.floor(GetBillingTimeRested()/60)))
else
  print("You are not limited by PartialPlayTime nor NoPlayTime.")
end
```

**Description:**
Only relevant on Chinese realms.
When you reach 3 hours remaining you will get "tired", reducing both the amount of money and experience that you receive by 50%.
If you play for 5 hours you will get "unhealthy", and won't be able to turn in quests, receive experience or loot.
The time left is stored on your account, and will display the same amount on every character.
The time will decay as you stay logged out.

**Reference:**
- `GetBillingTimeRested`
- `NoPlayTime`