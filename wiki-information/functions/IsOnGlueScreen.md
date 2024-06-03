## Title: IsOnGlueScreen

**Content:**
Returns whether the game is currently showing a GlueXML screen (i.e. no character is logged in).
`isOnGlueScreen = IsOnGlueScreen()`

**Returns:**
- `isOnGlueScreen`
  - *boolean* - false if a character is logged in; true otherwise.

**Description:**
This function will always return false if called by an AddOn -- addons only run when a character is logged in.