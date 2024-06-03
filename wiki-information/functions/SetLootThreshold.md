## Title: SetLootThreshold

**Content:**
Sets the loot quality threshold for group/master loot.
`SetLootThreshold(threshold)`

**Parameters:**
- `threshold`
  - *number* - The loot quality to start using the current loot method with.
    - **Value**
    - **Description**
    - `2`
      - Uncommon
    - `3`
      - Rare
    - `4`
      - Epic
    - `5`
      - Legendary
    - `6`
      - Artifact

**Description:**
This function throws an error with Poor (0) or Common (1) qualities, but it is possible to set these lower thresholds using `SetLootMethod()` with "master" as the first argument and 0 or 1 as the third. e.g. `SetLootMethod("master","player",1)`
Calling this while the loot method is changing will revert to the original loot method. To account for this, use `C_Timer.After()` to delay setting the threshold until a moment later. e.g. `C_Timer.After(1, function() SetLootMethod(2) end)`

**Usage:**
If you are the party/raid leader, this script sets the loot threshold to Uncommon items or better and causes everyone to see a chat notice to this effect.
```lua
/run SetLootThreshold(2)
```

**Reference:**
`PARTY_LOOT_METHOD_CHANGED`