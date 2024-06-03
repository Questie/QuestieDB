## Event: AZERITE_ITEM_EXPERIENCE_CHANGED

**Title:** AZERITE ITEM EXPERIENCE CHANGED

**Content:**
Sent to the add on each time the Azerite progress bar moves, in other words, every time the player gains Azerite.
`AZERITE_ITEM_EXPERIENCE_CHANGED: azeriteItemLocation, oldExperienceAmount, newExperienceAmount`

**Payload:**
- `azeriteItemLocation`
  - *ItemLocationMixin*🔗
- `oldExperienceAmount`
  - *number*
- `newExperienceAmount`
  - *number*