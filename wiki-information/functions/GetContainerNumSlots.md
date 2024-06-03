## Title: GetContainerNumSlots

**Content:**
Returns the total number of slots in the bag specified by the index.
`numberOfSlots = GetContainerNumSlots(bagID)`

**Parameters:**
- `bagID`
  - *number* - the slot containing the bag, e.g. 0 for backpack, etc.

**Returns:**
- `numberOfSlots`
  - *number* - the number of slots in the specified bag, or 0 if there is no bag in the given slot.

**Description:**
In 2.0.3, the Key Ring(-2) always returns 32. The size of the bag displayed is determined by the amount of space used in the keyring.
As of 3.0.3, immediately after a PLAYER_ENTERING_WORLD event (initial login or zone change through an instance, i.e., any time you see a loading screen), several events of BAG_UPDATE are fired, one for each bag slot you have purchased. All bag data is available during the PLAYER_ENTERING_WORLD event, but this function returns 0 for bags that have not had the BAG_UPDATE function called. This is most likely due to the UI resetting its internal cache sometime between the PLAYER_ENTERING_WORLD event and the first BAG_UPDATE event.