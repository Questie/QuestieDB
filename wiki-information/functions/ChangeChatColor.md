## Title: ChangeChatColor

**Content:**
Updates the color for a type of chat message.
`ChangeChatColor(channelname, red, green, blue)`

**Parameters:**
- `channelname`
  - *string* - Name of the channel as given in chat-cache.txt files.
- `red, green, blue`
  - *number* - RGB values (0-1, floats).

**Usage:**
```lua
ChangeChatColor("CHANNEL1", 255/255, 192/255, 192/255);
ChangeChatColor("CHANNEL1", 255/255, 192/255, 192/255);
```

**Miscellaneous:**
Result:
Reset the General channel to the default (255,192,192, slightly off-white) color.

**Reference:**
`FontString:SetTextColor()`.