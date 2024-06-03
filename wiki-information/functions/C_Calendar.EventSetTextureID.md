## Title: C_Calendar.EventSetTextureID

**Content:**
Needs summary.
`C_Calendar.EventSetTextureID(textureIndex)`

**Parameters:**
- `textureIndex`
  - *number* - NOT a FileDataID, but an index relating to the returned table of `API_C_Calendar.EventGetTextures`. You cannot set a custom texture, or even one outside the chosen event type. Therefore, this function currently only has an effect when using the types Raid and Dungeon.