## Title: TakeInboxItem

**Content:**
Takes the attached item from the mailbox message.
`TakeInboxItem(index, itemIndex)`

**Parameters:**
- `index`
  - the index of the mailbox message you want to take the item attachment from.
- `itemIndex`
  - The index of the item to take (1-ATTACHMENTS_MAX_RECEIVE(16))

**Returns:**
Always returns nil. (note: please confirm) As the request is done to the server asynchronously and might fail, then if knowing whether the action was successful is important, you will need to check afterward that it was.

**Usage:**
`TakeInboxItem(1, 1)`

**Description:**
Sends a request to the server to take an item attachment from a mail message. Note that this is only a request to the server, and the action might fail. Possible reasons for failure include that the user's bags are full, that they already have the maximum number of the item they are allowed to have (e.g., a unique item), or that a prior `TakeInboxItem()` request is still being processed by the server. There may be other reasons for failure. Would attempt to take the attachment from the first message in the Inbox and place it in the next available container slot.