## Title: C_FriendList.GetSelectedFriend

**Content:**
Returns the index of the currently selected friend.
`index = C_FriendList.GetSelectedFriend()`

**Returns:**
- `index`
  - *number?* - The index of the friend which is currently selected on the friend list. Returns nil if you have no friends.

**Description:**
This function is necessary because indices can change in response to friend status updates.