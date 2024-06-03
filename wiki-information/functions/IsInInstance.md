## Title: IsInInstance

**Content:**
Returns true if the player is in an instance, and the type of instance.
`inInstance, instanceType = IsInInstance()`

**Returns:**
- `inInstance`
  - *boolean* - Whether the player is in an instance; nil otherwise.
- `instanceType`
  - *string* - The instance type:
    - `"none"` when outside an instance
    - `"pvp"` when in a battleground
    - `"arena"` when in an arena
    - `"party"` when in a 5-man instance
    - `"raid"` when in a raid instance
    - `"scenario"` when in a scenario

**Description:**
This function returns correct results immediately upon `PLAYER_ENTERING_WORLD`.