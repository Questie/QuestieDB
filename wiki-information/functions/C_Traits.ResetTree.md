## Title: C_Traits.ResetTree

**Content:**
Resets the tree, refunding any purchased traits where possible. The reset is not automatically saved, use `C_Traits.CommitConfig` for that.
`success = C_Traits.ResetTree(configID, treeID)`

**Parameters:**
- `configID`
  - *number*
- `treeID`
  - *number*

**Returns:**
- `success`
  - *boolean*

**Description:**
This function is used to reset a talent tree, refunding any purchased traits. It is important to note that the reset is not automatically saved, so you must use `C_Traits.CommitConfig` to save the changes.

**Example Usage:**
```lua
local configID = 12345
local treeID = 67890
local success = C_Traits.ResetTree(configID, treeID)
if success then
    print("Tree reset successfully!")
    C_Traits.CommitConfig(configID)
else
    print("Failed to reset the tree.")
end
```

**Addons Using This Function:**
- **WeakAuras**: This popular addon uses `C_Traits.ResetTree` to manage and reset custom talent configurations for different encounters or scenarios.
- **ElvUI**: This comprehensive UI replacement addon may use this function to reset talent trees as part of its configuration management features.