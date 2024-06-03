## Title: FrameXML_Debug

**Content:**
Queries or sets the FrameXML debug logging flag.
`enabled = FrameXML_Debug()`

**Parameters:**
- `enabled`
  - *number?* - 0 to disable debug logging, or 1 to enable it. If not specified, the logging flag will not be modified.

**Returns:**
- `enabled`
  - *number* - The applied logging flag value.

**Description:**
When FrameXML debugging is enabled, extensive information about the load process is written to `World of Warcraft/.../Logs/FrameXML.log` and `GlueXML.log`. This information includes addon and file load order, as well as the names of all created frames and templates.