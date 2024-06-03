## Title: BNSetCustomMessage

**Content:**
Sends a broadcast message to your Real ID friends.
`BNSetCustomMessage(text)`

**Parameters:**
- `text`
  - *string* - message to be broadcasted (max 127 chars)

**Description:**
Triggers `CHAT_MSG_BN_INLINE_TOAST_BROADCAST` (receiver)
Triggers `CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM` (sender) "Your broadcast has been sent."
See `BNGetInfo()` for the current broadcast message.

**Usage:**
Sets your broadcast message.
```lua
BNSetCustomMessage("Hello friends!")
```
Clears your broadcast message.
```lua
BNSetCustomMessage("")
```