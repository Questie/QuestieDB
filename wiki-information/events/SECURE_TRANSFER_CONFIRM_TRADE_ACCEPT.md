## Event: SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT

**Title:** SECURE TRANSFER CONFIRM TRADE ACCEPT

**Content:**
Fires when trading money or items to a stranger.
`SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT`

**Payload:**
- `None`

**Content Details:**
Does not fire if the recipient is:
In the same guild
On the friends list
In the same group or raid
While an addon could respond to this event, the most important utility is for SecureTransferDialog to securely confirm the user's intention without addon interference.

**Related Information:**
SECURE_TRANSFER_CONFIRM_SEND_MAIL
SECURE_TRANSFER_CANCEL