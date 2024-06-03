## Title: GetInboxItemLink

**Content:**
Returns the item link of an item attached to a message in the mailbox.
`itemLink = GetInboxItemLink(message, attachment)`

**Parameters:**
- `message`
  - *number* - The index of the message to query, in the range of 
- `attachment`
  - *number* - The index of the attachment to query, in the range of

**Returns:**
- `itemLink`
  - *itemLink* - The itemLink for the specified item

**Description:**
`ATTACHMENTS_MAX_RECEIVE` is defined in Constants.lua, and currently (Jan 2014) has a value of 16. Using this variable instead of a hardcoded 16 is recommended in case Blizzard changes the maximum number of items that may be attached to a received message.

**Usage:**
To determine which messages are currently displayed in the mailbox frame, check the `pageNum` property set on the InboxFrame and do the math:
```lua
local maxIndex = GetInboxNumItems()
if maxIndex > 0 then
  local firstIndex = ((InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY) + 1
  local lastIndex = math.min(maxIndex, firstIndex + (INBOXITEMS_TO_DISPLAY - 1))
  print("Currently displaying messages", firstIndex, "though", lastIndex)
else
  print("No messages to display")
end
```

**Reference:**
- `GetInboxItem`
- `GetSendMailItem`
- `GetSendMailItemLink`