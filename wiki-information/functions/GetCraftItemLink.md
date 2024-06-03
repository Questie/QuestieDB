## Title: GetCraftItemLink

**Content:**
Returns an itemLink for the specified trade skill item in the current active trade skill.
`itemLink = GetCraftItemLink(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the current active trade skill.

**Returns:**
- `itemLink`
  - *itemLink* - the corresponding item link for that item or
  - *nil* - if the index is invalid or there is no active trade skill.

**Description:**
This function works with the trade skill which is currently active. Initially, there is no active trade skill. A trade skill becomes active when a trade skill window is opened, for instance.
Note that not all trade skills will change the active trade skill for this function. Only those which can generate chat links for a single trade skill will change the active setting (not to be mixed up with item links for crafted items). At the moment, this is only the enchanting trade skill window.