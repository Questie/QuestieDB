## Event: SECURE_TRANSFER_CONFIRM_SEND_MAIL

**Title:** SECURE TRANSFER CONFIRM SEND MAIL

**Content:**
Fires when mailing money or items to a stranger.
`SECURE_TRANSFER_CONFIRM_SEND_MAIL`

**Payload:**
- `None`

**Content Details:**
Does not fire if the recipient is:
- In the same guild
- On the friends list as a character (ie, not counting BattleTag or Real ID friends)
- An alt of the sender
While an addon could respond to this event, the most important utility is for SecureTransferDialog to securely confirm the user's intention without addon interference.

**Related Information:**
SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT
SECURE_TRANSFER_CANCEL