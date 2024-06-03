## Title: GetContainerItemCooldown

**Content:**
Returns cooldown information for an item in your inventory.
`startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slot)`

**Parameters:**
- `(bagID, slot)`
  - `bagID`
    - *number* - number of the bag the item is in, 0 is your backpack, 1-4 are the four additional bags
  - `slot`
    - *number* - slot number of the bag item you want the info for.

**Returns:**
- `startTime, duration, isEnabled`
  - `startTime`
    - the time the cooldown period began
  - `duration`
    - the duration of the cooldown period
  - `isEnabled`
    - 1 if the item has a cooldown, 0 otherwise