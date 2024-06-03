## Title: GetInboxHeaderInfo

**Content:**
Returns info for a message in the mailbox.
`packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(index)`

**Parameters:**
- `index`
  - *number* - the index of the message (ascending from 1).

**Returns:**
- `packageIcon`
  - *string* - texture path for package icon if it contains a package (nil otherwise).
- `stationeryIcon`
  - *string* - texture path for mail message icon.
- `sender`
  - *string* - name of the player who sent the message.
- `subject`
  - *string* - the message subject.
- `money`
  - *number* - The amount of money attached.
- `CODAmount`
  - *number* - The amount of COD payment required to receive the package.
- `daysLeft`
  - *number* - The number of days (fractional) before the message expires.
- `hasItem`
  - *number* - Either the number of attachments or nil if no items are present. Note that items that have been taken from the mailbox continue to occupy empty slots, but hasItem is the total number of items remaining in the mailbox. Use `ATTACHMENTS_MAX_RECEIVE` for the total number of attachments rather than this.
- `wasRead`
  - *boolean* - 1 if the mail has been read, nil otherwise. Using `GetInboxText()` marks an item as read.
- `wasReturned`
  - *boolean* - 1 if the mail was returned, nil otherwise.
- `textCreated`
  - *boolean* - 1 if a letter object has been created from this mail, nil otherwise.
- `canReply`
  - *boolean* - 1 if this letter can be replied to, nil otherwise.
- `isGM`
  - *boolean* - 1 if this letter was sent by a GameMaster.

**Description:**
This function may be called from anywhere in the world, but will only be current as of the last time `CheckInbox` was called.
Details of an Auction House message can be extracted with `GetInboxInvoiceInfo`.