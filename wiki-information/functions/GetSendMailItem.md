## Title: GetSendMailItem

**Content:**
Returns info for an item attached in the outgoing message.
`name, itemID, texture, count, quality = GetSendMailItem(index)`

**Parameters:**
- `index`
  - *number* - The index of the attachment to query, in the range of

**Returns:**
- `name`
  - *string* - The localized name of the item
- `itemID`
  - *number* - Numeric ID of the item.
- `texture`
  - *string* - The icon texture for the item
- `count`
  - *number* - The number of items in the stack
- `quality`
  - *number* - The quality index of the item (0-6)

**Usage:**
The following code will loop over all the items currently attached to the send mail frame, and print information about them to the chat frame:
```lua
for i = 1, ATTACHMENTS_MAX_SEND do
  local name, itemID, texture, count, quality = GetSendMailItem(i)
  if name then
    -- Construct an inline texture sequence:
    print("You are sending", "|T"..texture..":0|t", name, "x", count)
  end
end
```

**Description:**
Requires that the mailbox window is open.
ATTACHMENTS_MAX_SEND is defined in Constants.lua, and currently (Jan 2014) has a value of 12. Using this variable instead of a hardcoded 12 is recommended in case Blizzard changes the maximum number of items that may be attached to a single message.
As of 2.3.3 this function is bugged and the quality is always returned as -1. If you need to know the item's quality, get a link for the item using `GetSendMailItemLink`, and pass the link to `GetItemInfo`.

**Reference:**
- `GetSendMailItemLink`
- `GetInboxItem`
- `GetInboxItemLink`