## Event: VOID_DEPOSIT_WARNING

**Title:** VOID DEPOSIT WARNING

**Content:**
Fired when attempting to deposit an item with enchants/gems/reforges/etc into the Void Storage.
`VOID_DEPOSIT_WARNING: slot, link`

**Payload:**
- `slot`
  - *number* - Slot Index for `GetVoidTransferDepositInfo`
- `link`
  - *string* - Item Link