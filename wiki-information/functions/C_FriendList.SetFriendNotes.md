## Title: C_FriendList.SetFriendNotes

**Content:**
Sets the note text for a friend.
`found = C_FriendList.SetFriendNotes(name, notes)`

**Parameters:**
- `name`
  - *string* - name of friend in the friend list.
- `notes`
  - *string* - the text that the friend's note will be set to, up to 48 characters, anything longer will be truncated.

**Returns:**
- `found`
  - *boolean* - Whether the friend's note was successfully set.