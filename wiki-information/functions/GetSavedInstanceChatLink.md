## Title: GetSavedInstanceChatLink

**Content:**
Retrieves the SavedInstanceChatLink to a specific instance.
`link = GetSavedInstanceChatLink(index)`

**Parameters:**
- `index`
  - The index of the instance you want to query.

**Returns:**
- `link`
  - If instance at index is linkable.
- `nil`
  - If instance is not linkable (none at index).

**Usage:**
```lua
local link = GetSavedInstanceChatLink(1)
if link then
    print(link)
else
    print("Linking is not available for this instance!")
end
```

**Miscellaneous:**
Result:

Displays a link to the first instance in your Raid Information tab in the chat window, unless there is none available.

**Description:**
Added in 4.0.1
See also `GetSpellLink()`, `SavedInstanceChatLink`