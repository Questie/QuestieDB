## Title: CopyToClipboard

**Content:**
Copies text to the clipboard.
`length = CopyToClipboard(text)`

**Parameters:**
- `text`
  - *string*
- `removeMarkup`
  - *boolean?* = false

**Returns:**
- `length`
  - *number*

**Example Usage:**
```lua
local textToCopy = "Hello, World!"
local length = CopyToClipboard(textToCopy)
print("Copied text length: " .. length)
```

**Description:**
The `CopyToClipboard` function is useful for copying text programmatically within the game. This can be particularly handy for addons that need to allow users to easily copy information, such as coordinates, item links, or other data, to their clipboard for use outside the game.

**Addons Using This Function:**
Many UI enhancement addons, such as ElvUI and WeakAuras, use this function to provide users with the ability to copy text directly from the game interface to their system clipboard. This enhances user experience by allowing easy sharing of information.