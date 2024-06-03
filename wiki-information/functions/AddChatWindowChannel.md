## Title: AddChatWindowChannel

**Content:**
Enables messages from a chat channel index for a chat window.
`AddChatWindowChannel(windowId, channelName)`

**Parameters:**
- `windowId`
  - *number* - index of the chat window/frame (ascending from 1) to add the channel to.
- `channelName`
  - *string* - name of the chat channel to add to the frame.

**Description:**
A single channel may be configured to display in multiple chat windows/frames.
Chat output architecture has changed since release; calling this function alone is no longer sufficient to add a channel to a particular frame in the default UI. Use `ChatFrame_AddChannel(chatFrame, "channelName")` instead, like so:
```lua
ChatFrame_AddChannel(ChatWindow1, "Trade"); -- DEFAULT_CHAT_FRAME works well, too
```

**Reference:**
- `RemoveChatWindowChannel`