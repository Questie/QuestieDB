## Title: RandomRoll

**Content:**
Performs a random roll between two values.
`RandomRoll(low, high)`

**Parameters:**
- `low`
  - *number* - lowest number (default 1)
- `high`
  - *number* - highest number (default 100)

**Usage:**
```lua
RandomRoll(1, 10)
-- Yield: <Your name> rolls. <number> (1-10)
```

**Description:**
If only `low` is provided, it is taken as the highest number.
Does the same as `/random low high`.