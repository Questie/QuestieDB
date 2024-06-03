## Title: GetInboxItem

**Content:**
Returns info for an item attached to a message in the mailbox.
`name, itemID, texture, count, quality, canUse = GetInboxItem(index, itemIndex)`

**Parameters:**
- `index`
  - *number* - The index of the message to query, in the range
- `itemIndex`
  - *number* - The index of the item to query, in the range

**Returns:**
- `name`
  - *string* - The localized name of the item
- `itemID`
  - *number* - Numeric ID of the item.
- `texture`
  - *string* - The path to the icon texture for the item
- `count`
  - *number* - The number of items in the stack
- `quality`
  - *number* - The quality index of the item
- `canUse`
  - *boolean* - 1 if the player can use the item, or nil otherwise

**Usage:**
Loop over all messages currently in the player's mailbox, get information about the items attached to them, and print it to the chat frame:
```lua
for i = 1, GetInboxNumItems() do
  -- An underscore is commonly used to name variables you aren't going to use in your code:
  local _, _, sender, subject, _, _, _, hasItem = GetInboxHeaderInfo(i)
  if hasItem then
    print("Message", subject, "from", sender, "has attachments:")
    for j = 1, ATTACHMENTS_MAX_RECEIVE do
      local name, itemID, texture, count, quality, canUse = GetInboxItem(i, j)
      if name then
        -- Construct an icon string:
        print("\128T"..texture..":0\128t", name, "x", count)
      end
    end
  else
    print("Message", subject, "from", sender, "has no attachments.")
  end
end
```

**Description:**
As of 2.3.3 this function is bugged and the quality is always returned as -1. If you need to know the item's quality, get a link for the item using `GetInboxItemLink`, and pass the link to `GetItemInfo`.

**Reference:**
- `GetInboxItemLink`
- `GetSendMailItem`
- `GetSendMailItemLink`