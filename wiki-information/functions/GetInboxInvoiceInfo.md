## Title: GetInboxInvoiceInfo

**Content:**
Returns info for an auction house invoice.
`invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the message, starting from 1.

**Returns:**
- `invoiceType`
  - *string?* - One of "buyer", "seller" or "seller_temp_invoice"; or nil if there is no invoice.
- `itemName`
  - *string?* - The name of the item sold/bought, or nil if there is no invoice.
- `playerName`
  - *string?* - The player that sold/bought the item, or nil if there were multiple buyers/sellers involved. Will also return nil if there is no invoice.
- `bid`
  - *number* - The amount of money bid on the item.
- `buyout`
  - *number* - The amount of money set as buyout for the auction.
- `deposit`
  - *number* - The amount paid as deposit for the auction.
- `consignment`
  - *number* - The fee charged by the auction house for selling your consignment.

**Description:**
During the 1 hour delay on auction house payments, the message "Sale Pending: " may be queried with `GetInboxInvoiceInfo()` to determine the bid, buyout, deposit, and consignment fee amounts. This is useful, since `GetInboxHeaderInfo()` for that message (correctly) reports 0 money attached.