## Title: GetItemSpecInfo

**Content:**
Returns which specializations an item is useful for.
`specTable = GetItemSpecInfo(itemLink or itemID or itemName)`

**Parameters:**
- `itemLink` or `itemID` or `itemName`
  - *Mixed* - link, id, or name of the item to query.
- `specTable`
  - *table* - if provided, this table will be populated with the results and returned; otherwise, a new table will be created.

**Returns:**
- `specTable`
  - *table* - if the item is flagged as being for specific specializations, an array containing the SpecializationIDs of specializations of the player's class for which the queried item is suitable; nil if information is unavailable.

**Description:**
The supplied specTable is not wiped; only the array keys necessary to return the result are modified.
Spec information is only available for some items.
The returned specialization IDs are not sorted. You can use `table.sort` to bring them into the same order as the Specialization pane displays.

**Reference:**
- `GetSpecializationInfoByID`