## Title: GetFirstBagBankSlotIndex

**Content:**
Returns the index of the first bag slot within the bank container.
`index = GetFirstBagBankSlotIndex()`

**Returns:**
- `index`
  - *number* - The slot index of the first bank bag.

**Description:**
This function was added to resolve an inconsistency with the value of the `NUM_BANKGENERIC_SLOTS` constant and the actual slot index assigned to the first bank bag. On Classic Era, this constant is defined as 24 matching the number of displayed item slots in the bank frame, however, bag slots start at index 28 as they do on Burning Crusade Classic.