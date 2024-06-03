## Title: SearchLFGJoin

**Content:**
Allows a player to join Raid Browser list.
`SearchLFGJoin(typeID, lfgID)`

**Parameters:**
- `typeID`
  - *number* - LFG typeid
- `lfgID`
  - *number* - ID of LFG dungeon

**Reference:**
- `SearchLFGGetResults()`
- `SearchLFGGetPartyResults()`

**Example Usage:**
This function can be used to programmatically add a player to the Raid Browser list for a specific dungeon or raid. For instance, an addon could use this function to automate the process of joining the LFG queue for a specific raid.

**Addons:**
Large addons like **DBM (Deadly Boss Mods)** and **ElvUI** might use this function to enhance their LFG functionalities, such as automatically joining specific raid queues based on user preferences or raid schedules.