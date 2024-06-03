## Title: SetOverrideBindingSpell

**Content:**
Creates an override binding that casts a spell.
`SetOverrideBindingSpell(owner, isPriority, key, spell)`

**Parameters:**
- `owner`
  - *Frame* - The frame this binding "belongs" to; this can later be used to clear all override bindings belonging to a particular frame.
- `isPriority`
  - *boolean* - true if this is a priority binding, false otherwise. Both types of override bindings take precedence over normal bindings.
- `key`
  - *string* - Binding to bind the command to. For example, "Q", "ALT-Q", "ALT-CTRL-SHIFT-Q", "BUTTON5".
- `spell`
  - *string* - Name of the spell you want to cast when this binding is triggered.

**Description:**
Override bindings take precedence over the normal SetBinding bindings. Priority override bindings take precedence over non-priority override bindings.
Override bindings are never saved, and will be wiped by an interface reload.
You cannot use this function to clear an override binding; use SetOverrideBinding instead.

**Reference:**
- `SetOverrideBinding`
- `SetOverrideBindingClick`
- `SetOverrideBindingItem`
- `SetOverrideBindingMacro`
- `ClearOverrideBindings`