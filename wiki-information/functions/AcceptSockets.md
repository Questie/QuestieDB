## Title: AcceptSockets

**Content:**
Confirms pending gems for socketing.
`AcceptSockets()`

**Description:**
The socketing API designates a single item (SocketInventoryItem, SocketContainerItem) to be considered for socketing at a time. While an item is being considered for socketing, players may drop new gems into its sockets (ClickSocketButton). If the user wishes to actually perform the socketing, `AcceptSockets()` must be called to confirm.

There is no dedicated API call to reject a tentative socketing, although you may use `CloseSocketInfo()` to exit socketing without making any changes to the item. You can then select the item for socketing again.

Replaces existing gems if necessary.

**Reference:**
- `SocketInventoryItem`
- `SocketContainerItem`
- `ClickSocketButton`
- `CloseSocketInfo`