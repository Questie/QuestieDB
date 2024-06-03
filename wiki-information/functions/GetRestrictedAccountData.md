## Title: GetRestrictedAccountData

**Content:**
Returns the cap on trial character level, money, and profession skill.
`rLevel, rMoney, profCap = GetRestrictedAccountData()`

**Returns:**
- `rLevel`
  - *number* - character level cap, currently 20
- `rMoney`
  - *number* - max amount of money in copper, currently 10000000
- `profCap`
  - *number* - profession level cap, currently 0

**Description:**
Only returns proper values while on a Starter Edition or inactive account.