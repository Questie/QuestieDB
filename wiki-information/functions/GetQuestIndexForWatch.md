## Title: GetQuestIndexForWatch

**Content:**
Gets the quest log index of a watched quest.
`questIndex = GetQuestIndexForWatch(watchIndex)`

**Parameters:**
- `watchIndex`
  - *number* - The index of a quest watch; an integer between 1 and `GetNumQuestWatches()`.

**Returns:**
- `questIndex`
  - *number* - The quest log's index of the watched quest.

**Notes and Caveats:**
This function can return nil for valid `watchIndex` values if the watched quest isn't yet in the client cache. This can happen when logging in after clearing the cache.