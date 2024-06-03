## Title: StripHyperlinks

**Content:**
Strips text of UI escape sequence markup.
`stripped = StripHyperlinks(text)`

**Parameters:**
- `text`
  - *string* - The text to be stripped of markup.
- `maintainColor`
  - *boolean?* - If true, preserve color escape sequences.
- `maintainBrackets`
  - *boolean?*
- `stripNewlines`
  - *boolean?* - If true, strip all line break sequences.
- `maintainAtlases`
  - *boolean?* - If true, preserve atlas texture escape sequences.

**Returns:**
- `stripped`
  - *string* - The stripped text.

**Description:**
This function is used by the Addon compartment to strip markup from addon titles prior to sorting.