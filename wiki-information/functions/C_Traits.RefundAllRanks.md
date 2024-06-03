## Title: C_Traits.RefundAllRanks

**Content:**
Needs summary.
`success = C_Traits.RefundAllRanks(configID, nodeID)`

**Parameters:**
- `configID`
  - *number*
- `nodeID`
  - *number*

**Returns:**
- `success`
  - *boolean*

**Description:**
This function is used to refund all ranks for a specific node in a given configuration. It can be useful in scenarios where a player wants to reset their trait points and reallocate them differently.

**Example Usage:**
```lua
local configID = 12345
local nodeID = 67890
local success = C_Traits.RefundAllRanks(configID, nodeID)
if success then
    print("All ranks have been successfully refunded.")
else
    print("Failed to refund ranks.")
end
```

**Addons Using This Function:**
- **WeakAuras**: This popular addon might use this function to allow players to reset their trait points and reconfigure their abilities based on different scenarios or encounters.
- **ElvUI**: Another widely used addon that could leverage this function to provide users with an easy way to reset and reallocate their trait points within the UI.