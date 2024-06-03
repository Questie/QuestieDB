## Title: GetShieldBlock

**Content:**
Returns the percentage of damage blocked by your shield.
`shieldBlock = GetShieldBlock()`

**Returns:**
- `shieldBlock`
  - *number* - the percentage of damage reduced by your shield

**Usage:**
```lua
/dump GetShieldBlock() -- 31
```
This means that your shield blocks 31% of damage. This matches the in-game tooltip: "Your block stops 31% of incoming damage."

**Description:**
All blocked attacks are reduced by 30%. It can be increased to 31% by a +1% Shield Block Value meta-gem.

**Reference:**
- `GetBlockChance`