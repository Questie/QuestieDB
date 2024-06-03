## Title: GetLootThreshold

**Content:**
Returns the loot threshold quality for e.g. master loot.
`threshold = GetLootThreshold()`

**Returns:**
- `threshold`
  - *number* - The minimum quality of item which will be rolled for or assigned by the master looter. The value is 0 to 7, which represents Poor to Heirloom.

**Example Usage:**
This function can be used to determine the current loot threshold in a group or raid setting. For instance, if you are developing an addon that needs to display or adjust loot settings, you can use `GetLootThreshold` to fetch the current threshold and make decisions based on it.

**Addons Using This Function:**
Many raid management addons, such as "Deadly Boss Mods" (DBM) and "BigWigs", use this function to ensure that loot distribution settings are appropriate for the encounter difficulty and group composition.