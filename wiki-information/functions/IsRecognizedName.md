## Title: IsRecognizedName

**Content:**
Returns true if a given character name is recognized by the client.
`isRecognized = IsRecognizedName(text, includeBitfield, excludeBitfield)`

**Parameters:**
- `text`
  - *string* - Name of the character to test.
- `includeBitfield`
  - *number* - Bitfield of filters that the name must match at least one of.
- `excludeBitfield`
  - *number* - Bitfield of filters that the name must not match any of.

**Returns:**
- `isRecognized`
  - *boolean* - true if the character name is recognized by the client and passes the requested filters.

**Miscellaneous:**
The filters used by this function are the same as the autocompletion flags used by `GetAutoCompleteResults()`.
- **AutocompleteFlag**
  - **Global**
  - **Value**
  - **Description**
  - `AUTOCOMPLETE_FLAG_NONE`
    - `0x00000000` - Mask usable for including or excluding no results.
  - `AUTOCOMPLETE_FLAG_IN_GROUP`
    - `0x00000001` - Matches characters in your current party or raid.
  - `AUTOCOMPLETE_FLAG_IN_GUILD`
    - `0x00000002` - Matches characters in your current guild.
  - `AUTOCOMPLETE_FLAG_FRIEND`
    - `0x00000004` - Matches characters on your character-specific friends list.
  - `AUTOCOMPLETE_FLAG_BNET`
    - `0x00000008` - Matches characters on your Battle.net friends list.
  - `AUTOCOMPLETE_FLAG_INTERACTED_WITH`
    - `0x00000010` - Matches characters that the player has interacted with directly, such as exchanging whispers.
  - `AUTOCOMPLETE_FLAG_ONLINE`
    - `0x00000020` - Matches characters that are currently online.
  - `AUTO_COMPLETE_IN_AOI`
    - `0x00000040` - Matches characters in the local area of interest.
  - `AUTO_COMPLETE_ACCOUNT_CHARACTER`
    - `0x00000080` - Matches characters on any of the current players' Battle.net game accounts.
  - `AUTOCOMPLETE_FLAG_ALL`
    - `0xFFFFFFFF` - Mask usable for including or excluding all results.

**Description:**
This function may return false for some filters if the player enters, exits, and re-enters the local area of interest of the tested character name.
When testing character names that are on the same Battle.net account, the character name must not include any realm identifier if the currently logged in character is on the same realm.

**Reference:**
`GetAutoCompleteResults()`