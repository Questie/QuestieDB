## Title: GetGlyphSocketInfo

**Content:**
Returns information on a glyph socket.
`enabled, glyphType, glyphSpellID, iconFile = GetGlyphSocketInfo(socketID)`

**Parameters:**
- `socketID`
  - *number* - The socket index to query, ranging from 1 through NUM_GLYPH_SLOTS.
- `talentGroup`
  - *number?* - The talent specialization group to query. Defaults to 1.

**Returns:**
- `enabled`
  - *boolean* - True if the socket has a glyph inserted.
- `glyphType`
  - *number* - The type of glyph accepted by this socket. Either 1 Major, 2 Minor, or 3 Prime.
- `glyphIndex`
  - *number* - The socket's index for the glyph type. Either 0, 1, 2.
- `glyphSpellID`
  - *number?* - The spell ID of the socketed glyph.
- `iconFile`
  - *number?* - FileID - The file ID of the sigil icon associated with the socketed glyph.