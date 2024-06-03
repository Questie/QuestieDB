## Title: GetNumGlyphSockets

**Content:**
Returns the number of glyph sockets the player will have access to at max level.
`numGlyphSockets = GetNumGlyphSockets();`

**Returns:**
- `numGlyphSockets`
  - *Number* - Number of glyph sockets the player will have access to at max level.

**Notes and Caveats:**
Sockets have individual level requirements; not every socket may be usable at the character's particular level.
Returns the same value as `NUM_GLYPH_SLOTS`.