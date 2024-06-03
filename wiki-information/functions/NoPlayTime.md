## Title: NoPlayTime

**Content:**
Returns true if the account is considered "unhealthy" for players on Chinese realms.
`isUnhealthy = NoPlayTime()`

**Returns:**
- `isUnhealthy`
  - *boolean?* - 1 if the account is "unhealthy", nil if not.

**Usage:**
```lua
if NoPlayTime() then
  print(string.format(PLAYTIME_UNHEALTHY, REQUIRED_REST_HOURS - math.floor(GetBillingTimeRested()/60)))
else
  print("You are not limited by NoPlayTime.")
end
```

**Description:**
Only relevant on Chinese realms.
The time left is stored on your account, and will display the same amount on every character.

**Reference:**
- `GetBillingTimeRested` - The remaining time until this restriction comes into effect
- `PartialPlayTime` - A form of limited restriction (-50% to xp and currency) that is presumably removed from the game