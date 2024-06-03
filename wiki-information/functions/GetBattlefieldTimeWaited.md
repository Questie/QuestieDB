## Title: GetBattlefieldTimeWaited

**Content:**
Returns the time the player has waited in the queue.
`timeInQueue = GetBattlefieldTimeWaited(battlegroundQueuePosition)`

**Parameters:**
- `battlegroundQueuePosition`
  - *number* - The queue position.

**Returns:**
- `timeInQueue`
  - *number* - Milliseconds this player has been waiting in the queue.

**Usage:**
You queue up for Arathi Basin and Alterac Valley.
```lua
x = GetBattlefieldTimeWaited(1); -- Arathi Basin
y = GetBattlefieldTimeWaited(2); -- Alterac Valley
```
As soon as the join message appears, that slot is "empty" (returns 0) but they are not reordered, queuing up again will use the lowest slot available.