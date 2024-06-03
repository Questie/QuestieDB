## Title: C_FriendList.GetNumWhoResults

**Content:**
Get the number of entries resulting from your most recent /who query.
`numWhos, totalNumWhos = C_FriendList.GetNumWhoResults()`

**Returns:**
- `numWhos`
  - *number* - Number of results returned
- `totalNumWhos`
  - *number* - Number of results to display

**Description:**
Both return values never seem to go over 50.
If `totalNumWhos` would be bigger than 50, the amount shown will be capped to `MAX_WHOS_FROM_SERVER` (50) in FrameXML.