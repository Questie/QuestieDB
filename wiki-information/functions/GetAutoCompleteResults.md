## Title: GetAutoCompleteResults

**Content:**
Returns possible player names matching a given prefix string and specified requirements.
`results = GetAutoCompleteResults(text, numResults, cursorPosition, allowFullMatch, includeBitField, excludeBitField)`

**Parameters:**
- `text`
  - *string* - First characters of the possible names to be autocompleted
- `numResults`
  - *number* - Number of results desired.
- `cursorPosition`
  - *number* - Position of the cursor within the editbox (i.e. how much of the text string should be matching).
- `allowFullMatch`
  - *boolean*
- `includeBitField`
  - *number* - Bit mask of filters that the results must match at least one of.
- `excludeBitField`
  - *number* - Bit mask of filters that the results must not match any of.

**Filter values:**
The `includeBitField` and `excludeBitField` bit mask parameters can be composed from the following components:

| AutocompleteFlag              | Global            | Value        | Description                                                                 |
|-------------------------------|-------------------|--------------|-----------------------------------------------------------------------------|
| AUTOCOMPLETE_FLAG_NONE        | 0x00000000        | Mask usable for including or excluding no results.                          |
| AUTOCOMPLETE_FLAG_IN_GROUP    | 0x00000001        | Matches characters in your current party or raid.                           |
| AUTOCOMPLETE_FLAG_IN_GUILD    | 0x00000002        | Matches characters in your current guild.                                   |
| AUTOCOMPLETE_FLAG_FRIEND      | 0x00000004        | Matches characters on your character-specific friends list.                 |
| AUTOCOMPLETE_FLAG_BNET        | 0x00000008        | Matches characters on your Battle.net friends list.                         |
| AUTOCOMPLETE_FLAG_INTERACTED_WITH | 0x00000010    | Matches characters that the player has interacted with directly, such as exchanging whispers. |
| AUTOCOMPLETE_FLAG_ONLINE      | 0x00000020        | Matches characters that are currently online.                               |
| AUTO_COMPLETE_IN_AOI          | 0x00000040        | Matches characters in the local area of interest.                           |
| AUTO_COMPLETE_ACCOUNT_CHARACTER | 0x00000080      | Matches characters on any of the current players' Battle.net game accounts. |
| AUTOCOMPLETE_FLAG_ALL         | 0xFFFFFFFF        | Mask usable for including or excluding all results.                         |

**Returns:**
- `results`
  - *table* - Auto-completed names of players that satisfy the requirements.
    - `Field`
    - `Type`
    - `Description`
    - `bnetID`
      - *number*
    - `name`
      - *string* - The realm part can possibly be omitted for players on the same realm. This format might be inconsistent (on Classic), e.g. Foo-Nethergarde Keep and Foo-MirageRaceway
    - `priority`
      - *number*