## Title: C_Mail.HasInboxMoney

**Content:**
Returns true if a mail has money attached.
`inboxItemHasMoneyAttached = C_Mail.HasInboxMoney(inboxIndex)`

**Parameters:**
- `inboxIndex`
  - *number*

**Returns:**
- `inboxItemHasMoneyAttached`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific mail in the player's inbox contains money. This is useful for addons that manage mail, such as those that automate the collection of auction house sales or other financial transactions.

**Addon Usage:**
Large addons like Postal use this function to help manage and display mail contents efficiently. Postal, for example, can use this function to highlight mails that contain money, making it easier for players to quickly identify and collect their earnings.