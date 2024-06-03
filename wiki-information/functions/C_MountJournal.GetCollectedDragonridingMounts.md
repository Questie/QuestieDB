## Title: C_MountJournal.GetCollectedDragonridingMounts

**Content:**
Needs summary.
`mountIDs = C_MountJournal.GetCollectedDragonridingMounts()`

**Returns:**
- `mountIDs`
  - *number*

**Description:**
This function retrieves the IDs of the dragonriding mounts that the player has collected. The returned `mountIDs` can be used to display or manage the player's collection of dragonriding mounts.

**Example Usage:**
```lua
local mountIDs = C_MountJournal.GetCollectedDragonridingMounts()
for _, mountID in ipairs(mountIDs) do
    print("Collected Dragonriding Mount ID:", mountID)
end
```

**Change Log:**
Patch 10.0.0 (2022-11-15): Added.