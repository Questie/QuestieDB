## Title: SetBindingItem

**Content:**
Sets a binding to use a specified item.
`ok = SetBindingItem(key, item)`

**Parameters:**
- `key`
  - *string* - Any binding string accepted by World of Warcraft. For example: `"ALT-CTRL-F"`, `"SHIFT-T"`, `"W"`, `"BUTTON4"`.
- `item`
  - *string* - Item name (or item string) you want the binding to use. For example: `"Hearthstone"`, `"item:6948"`

**Returns:**
- `ok`
  - *boolean* - 1 if the binding has been changed successfully, nil otherwise.

**Description:**
This function is functionally equivalent to the following statement.
`ok = SetBinding("key", "ITEM " .. item);`
A single binding can only be bound to a single command at a time, although multiple bindings may be bound to the same command. The Key Bindings UI will only show the first two bindings, but there is no limit to the number of keys that can be used for the same command.
You must use SetBinding to unbind a key.

**Reference:**
[SetBinding](SetBinding)