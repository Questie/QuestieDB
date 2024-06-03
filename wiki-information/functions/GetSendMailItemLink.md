## Title: GetSendMailItemLink

**Content:**
Returns the item link of an item attached in the outgoing message.
`itemLink = GetSendMailItemLink(attachment)`

**Parameters:**
- `attachment`
  - *number* - The index of the attachment to query, in the range of

**Returns:**
- `itemLink`
  - *itemLink* - The item link for the specified item

**Description:**
`ATTACHMENTS_MAX_SEND` is defined in `Constants.lua`, and currently (Jan 2014) has a value of 12. Using this variable instead of a hardcoded 12 is recommended in case Blizzard changes the maximum number of items that may be attached to a sent message.

There is no API function to get the total number of items attached to a sent message. If your addon needs to know how many attachment slots are filled, you must loop over all the slots and count them yourself:
```lua
local total = 0
for i = 1, ATTACHMENTS_MAX_SEND do
  if GetSendMailItemLink(i) then
    total = total + 1
  end
end
print("Attachment slots used:", total, "of", ATTACHMENTS_MAX_SEND)
```

**Reference:**
- `GetSendMailItem`
- `GetInboxItem`
- `GetInboxItemLink`