## Title: RemoveChatWindowChannel

**Content:**
Removes the specified chat channel from a chat window.
`RemoveChatWindowChannel(windowId, channelName)`

**Parameters:**
- `windowId`
  - *number* - index of the chat window/frame (ascending from 1) to remove the channel from.
- `channelName`
  - *string* - name of the chat channel to remove from the frame.

**Description:**
Chat output architecture has changed since release; calling this function alone is no longer sufficient to block a channel from a particular frame in the default UI. Use `ChatFrame_RemoveChannel(chatFrame, "channelName")` instead, like so:
```lua
ChatFrame_RemoveChannel(ChatWindow1, "Trade"); -- DEFAULT_CHAT_FRAME works well, too
```

**Reference:**
- `AddChatWindowChannel`