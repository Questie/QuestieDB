## Title: GetQuestLogItemLink

**Content:**
Returns item link for selected quest reward/choice/required item from quest log.
`itemLink = GetQuestLogItemLink(type, index)`

**Parameters:**
- `type`
  - *string* - "required", "reward" or "choice"
- `index`
  - *table* - Integer - Quest reward item index (starts with 1).

**Returns:**
- `itemLink`
  - *string* - The link to the quest item specified
  - or `nil`, if the type and/or index is invalid, there is no active quest at the moment or if the server did not transmit the item information until the timeout (which can happen, if the item is not in the local item cache yet)

**Description:**
The active quest is being set when browsing the quest log. The quest log must not be open for this function to work, but a quest must be active.
The different types refer to the different item lists, a quest can contain.
- "reward" is the list of items which will be granted upon finishing the quest.
- "choice" is the list of items the player can choose from, once the quest is finished.
- "required" should be the list of items which have to be handed in for the quest to be finished (this has not been verified).