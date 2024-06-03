## Title: GetQuestBackgroundMaterial

**Content:**
Returns the background texture for the displayed quest.
`material = GetQuestBackgroundMaterial()`

**Returns:**
- `material`
  - *string?* - The material string for this quest, or nil if the default, "Parchment", is to be used.

**Description:**
This texture is used to paint the background of the Blizzard Quest Frame. It does not appear in the Quest Log, but only when initially reading, accepting, or handing in the quest.