## Title: C_FriendList.SetWhoToUi

**Content:**
Sets how the result of a /who request will be delivered.
`C_FriendList.SetWhoToUi(whoToUi)`

**Parameters:**
- `whoToUi`
  - *boolean* - If true the results will always be delivered as a WHO_LIST_UPDATE event and displayed in the FriendsFrame. If false the results may be returned as a sequence of CHAT_MSG_SYSTEM events (up to 3 results) or a WHO_LIST_UPDATE event (4+ results).

**Description:**
The /who query is subject to a server-side throttle; throttled requests are silently dropped.
This setting does not persist between relog/reload.
The FriendsFrame will automatically display open to display the results when the WHO_LIST_UPDATE event is triggered. You may hide the frame using `HideUIPanel(FriendsFrame)` (protected during combat lockdown), or temporarily unregister it from WHO_LIST_UPDATE to prevent this behavior if your addon relies on performing /who queries in the background.