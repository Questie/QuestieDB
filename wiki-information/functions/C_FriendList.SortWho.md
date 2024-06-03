## Title: C_FriendList.SortWho

**Content:**
Sorts the last /who reply received by the client.
`C_FriendList.SortWho(sorting)`

**Parameters:**
- `sorting`
  - *string* - The column by which you wish to sort the who list:
    - `"name"` (default)
    - `"level"`
    - `"class"`
    - `"zone"`
    - `"guild"`
    - `"race"`

**Reference:**
`WHO_LIST_UPDATE` is fired when the list is sorted.

**Description:**
This function changes the mapping between `C_FriendList.GetWhoInfo` indices and result rows.
FrameXML will show the who frame on this event, even if it was not visible before.
Calling the same sort twice will reverse the sort.
You may sort by guild, race, or zone even if it is not the currently selected second column on the who frame.