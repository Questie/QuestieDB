## Title: GetFileIDFromPath

**Content:**
Returns the FileID for an Interface file path.
`fileID = GetFileIDFromPath(filePath)`

**Parameters:**
- `filePath`
  - *string* - The path to a game file. For example `Interface/Icons/Temp.blp`

**Returns:**
- `fileID`
  - *number* : FileID - The internal ID corresponding to the file path. Negative integers are temporary IDs; these are not specified in the CASC root file and may change when the client is restarted.

**Usage:**
- Interface/ path
  ```lua
  /dump GetFileIDFromPath("Interface/Icons/Temp") -- 136235
  ```
- Custom file path
  ```lua
  /dump GetFileIDFromPath("Interface/testimg.jpg") -- -1163
  /dump GetFileIDFromPath("hello/test.jpg") -- -2
  ```

**Reference:**
- [#wowuidev 2019-04-23](https://infobot.rikers.org/%23wowuidev/20190423.html.gz)