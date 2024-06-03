## Title: C_ChatBubbles.GetAllChatBubbles

**Content:**
Returns all active chat bubbles.
`chatBubbles = C_ChatBubbles.GetAllChatBubbles()`

**Parameters:**
- `includeForbidden`
  - *boolean?* = false

**Returns:**
- `chatBubbles`
  - *Widget_API*

**Description:**
Previously it was required to iterate over the WorldFrame children to access the chat bubbles.