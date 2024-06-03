## Title: C_Traits.GetLoadoutSerializationVersion

**Content:**
Returns the version of the Talent Build String format.
`serializationVersion = C_Traits.GetLoadoutSerializationVersion()`

**Returns:**
- `serializationVersion`
  - *number*

**Description:**
The Talent Build String is encoded with a header, this header contains the version of the format. If the build string's version doesn't match the return from this API, the game will not attempt to parse the string any further.
Currently, this is simply 1, it is assumed that Blizzard will increase the version number to 2 if they make any changes to the format of their Talent Build Strings.