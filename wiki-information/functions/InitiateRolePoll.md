## Title: InitiateRolePoll

**Content:**
Starts a role check.
`result = InitiateRolePoll()`

**Returns:**
- `result`
  - *boolean*

**Example Usage:**
```lua
-- Initiates a role poll in a group or raid
local result = InitiateRolePoll()
if result then
    print("Role poll initiated successfully.")
else
    print("Failed to initiate role poll.")
end
```

**Description:**
The `InitiateRolePoll` function is used to start a role check in a group or raid. This is typically used in dungeons or raids to ensure that all members have selected their roles (tank, healer, or damage dealer) before proceeding. This function returns a boolean value indicating whether the role poll was successfully initiated.