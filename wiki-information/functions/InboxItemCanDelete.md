## Title: InboxItemCanDelete

**Content:**
Returns true if a message can be deleted, false if it can be returned to sender.
`canDelete = InboxItemCanDelete(index)`

**Parameters:**
- `index`
  - *number* - the index of the message (1 is the first message)

**Returns:**
- `canDelete`
  - *Flag* - false if a mailed item or money is returnable, true otherwise.

**Description:**
InboxItemCanDelete() is used by Blizzard's MailFrame.lua to determine whether a mail message is returnable, and thus whether it should put a "Return" button on the message frame or a "Delete" button. This is true when the message has been sent by the Auction House or an NPC, or has been bounced back (returned) from a player character. It will be false when it is an original message from a player character.

This function should not be confused with whether DeleteInboxItem will succeed or not; despite its name, InboxItemCanDelete is not checking for whether you are allowed to delete a message. For safety, assume that DeleteInboxItem will succeed whenever it is passed a valid index, regardless of whether the message contains any item or money. It is Blizzard's MailFrame.lua that provides confirmation boxes for deleting messages that still have an item or money attached.