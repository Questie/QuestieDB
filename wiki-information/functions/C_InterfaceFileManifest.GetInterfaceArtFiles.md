## Title: C_InterfaceFileManifest.GetInterfaceArtFiles

**Content:**
Obtains a list of all interface art file names.
`images = C_InterfaceFileManifest.GetInterfaceArtFiles()`

**Returns:**
- `images`
  - *string?* - A list of file names.

**Description:**
This function always returns nil inside the FrameXML environment. It only returns a table while on Glue screens such as character selection, where addon code cannot run.