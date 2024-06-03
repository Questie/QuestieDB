## Title: C_Texture.GetFilenameFromFileDataID

**Content:**
Returns a string representing a file ID.
`filename = C_Texture.GetFilenameFromFileDataID(fileDataID)`

**Parameters:**
- `fileDataID`
  - *number* - The file ID to query.

**Returns:**
- `filename`
  - *string* - A string of the form "FileData ID {fileDataID}".

**Description:**
This appears to mirror the return value of `TextureBase:GetTextureFilePath`.