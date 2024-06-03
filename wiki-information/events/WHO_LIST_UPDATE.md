## Event: WHO_LIST_UPDATE

**Title:** WHO LIST UPDATE

**Content:**
Fired when the client receives the result of a C_FriendList.SendWho request from the server.
`WHO_LIST_UPDATE`

**Payload:**
- `None`

**Content Details:**
Use C_FriendList.SetWhoToUi to manipulate this functionality. This event is only triggered if the Who panel was open at the time the Who data was received (this includes the case where the Blizzard UI opens it automatically because the return data was too big to display in the chat frame).