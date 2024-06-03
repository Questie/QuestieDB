## Title: GetBindingByKey

**Content:**
Returns the binding action performed when the specified key combination is triggered.
`bindingAction = GetBindingByKey(key)`

**Parameters:**
- `key`
  - *string* - binding key to query, e.g. "G", "ALT-G", "ALT-CTRL-SHIFT-F1".

**Returns:**
- `bindingAction`
  - *string* - binding action that will be performed, e.g. "TOGGLEAUTORUN", "CLICK Purrseus:k1", or nil if no action will be performed.

**Description:**
This function takes into account override bindings by default.
This discards modifiers from the key argument until a binding matches; thus, querying for ALT-CTRL-SHIFT-G can return the action performed due to the simple "G" binding.

**Reference:**
`GetBindingAction`