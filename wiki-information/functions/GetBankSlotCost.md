## Title: GetBankSlotCost

**Content:**
Returns the cost of the next bank bag slot.
`cost = GetBankSlotCost(numSlots)`

**Parameters:**
- `numSlots`
  - *number* - Number of slots already purchased.

**Returns:**
- `cost`
  - *number* - Price of the next bank slot in copper.

**Usage:**
The following example outputs the amount of money you'll have to pay for the next bank slot:
```lua
local numSlots, full = GetNumBankSlots();
if full then
  print("You may not buy any more bank slots");
else
  local c = GetBankSlotCost(numSlots);
  print(("Your next bank slot costs %d g %d s %d c"):format(c / 10000, c / 100 % 100, c % 100));
end
```