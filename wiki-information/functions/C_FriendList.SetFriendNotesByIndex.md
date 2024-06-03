## Title: C_FriendList.SetFriendNotesByIndex

**Content:**
Sets the note text for a friend.
`C_FriendList.SetFriendNotesByIndex(index, notes)`

**Parameters:**
- `index`
  - *number* - index of the friend, up to `C_FriendList.GetNumFriends` (max 100). Note that status changes can re-order the friend list, indices are not guaranteed to remain stable across events.
- `notes`
  - *string* - the text that the friend's note will be set to, up to 48 characters, anything longer will be truncated.