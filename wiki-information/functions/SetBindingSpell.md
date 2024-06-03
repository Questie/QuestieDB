## Title: SetBindingSpell

**Content:**
Sets a binding to cast the specified spell.
`ok = SetBindingSpell(key, spell)`

**Parameters:**
- `key`
  - *string* - Any binding string accepted by World of Warcraft. For example: "ALT-CTRL-F", "SHIFT-T", "W", "BUTTON4".
- `spell`
  - *string* - Name of the spell you wish to cast when the binding is pressed.

**Returns:**
- `ok`
  - *boolean* - 1 if the binding has been changed successfully, nil otherwise.

**Description:**
This function is functionally equivalent to the following statement.
`ok = SetBinding("key", "SPELL " .. spell);`
A single binding can only be bound to a single command at a time, although multiple bindings may be bound to the same command. The Key Bindings UI will only show the first two bindings, but there is no limit to the number of keys that can be used for the same command.
You must use SetBinding to unbind a key.

**Reference:**
- `SetBinding`

**Example Usage:**
```lua
-- Bind the spell "Fireball" to the key "SHIFT-F"
local success = SetBindingSpell("SHIFT-F", "Fireball")
if success then
    print("Binding set successfully!")
else
    print("Failed to set binding.")
end
```

**Addons Using This Function:**
- **Bartender4**: A popular action bar replacement addon that allows users to customize their action bars and key bindings extensively. It uses `SetBindingSpell` to allow users to bind spells directly to keys through its configuration interface.
- **ElvUI**: A comprehensive UI replacement addon that includes features for key binding management. It uses `SetBindingSpell` to facilitate the binding of spells to keys as part of its key binding setup process.