## Title: CaseAccentInsensitiveParse

**Content:**
Converts a string with accented letters to lowercase.
`lower = CaseAccentInsensitiveParse(name)`

**Parameters:**
- `name`
  - *string* - The string to be converted to lowercase.

**Returns:**
- `lower`
  - *string* - A lowercased equivalent of the input string.

**Description:**
This API only supports a limited set of codepoints for conversion and is not suitable as a general-purpose Unicode-aware case conversion function.
The table below documents support for uppercase characters within defined Unicode codepoint blocks. A block is considered "supported" only if all uppercase class characters within the block will be converted to their lowercase equivalents by this function.

| Block Name         | Supported | Notes                                                                 |
|--------------------|-----------|-----------------------------------------------------------------------|
| Basic Latin        | ✔️        |                                                                       |
| Latin-1 Supplement | ✔️        |                                                                       |
| Latin Extended-A   | ❌        | Limited support for Œ (U+0152) and Ÿ (U+0178) only.                   |

**Usage:**
This example demonstrates the support for the Basic and Supplemental Latin codepoint ranges, outputting a lowercased pair of strings.
```lua
local basic = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local supplemental = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ"
print(CaseAccentInsensitiveParse(basic))
print(CaseAccentInsensitiveParse(supplemental))
-- Prints:
-- abcdefghijklmnopqrstuvwxyz
-- àáâãäåæçèéêëìíîïðñòóôõöøùúûüýþ
```