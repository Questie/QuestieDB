## Title: GetInboxNumItems

**Content:**
Returns the number of messages in the mailbox.
`numItems, totalItems = GetInboxNumItems()`

**Returns:**
- `numItems`
  - *number* - The number of items in the mailbox.
- `totalItems`
  - *number* - The total number of items in the mailbox, including those that are not visible due to pagination.

**Example Usage:**
This function can be used to check the number of messages in a player's mailbox, which can be useful for addons that manage mail or notify players of new mail.

**Addons Using This Function:**
- **Postal**: A popular mailbox management addon that uses this function to display the number of messages and manage mail efficiently.