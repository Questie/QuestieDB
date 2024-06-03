## Title: SetOverrideBinding

**Content:**
Sets an override key binding.
`SetOverrideBinding(owner, isPriority, key, command)`

**Parameters:**
- `owner`
  - *Frame* - The frame this binding "belongs" to; this can later be used to clear all override bindings belonging to a particular frame.
- `isPriority`
  - *boolean* - true if this is a priority binding, false otherwise. Both types of override bindings take precedence over normal bindings.
- `key`
  - *string* - Binding to bind the command to. For example, "Q", "ALT-Q", "ALT-CTRL-SHIFT-Q", "BUTTON5"
- `command`
  - *String/nil* - Any name attribute value of a Bindings.xml-defined binding, or an action command string; nil to remove an override binding. For example:
    - `"SITORSTAND"` : a Bindings.xml-defined binding to toggle between sitting and standing
    - `"CLICK PlayerFrame:LeftButton"` : Fire a left-click on the PlayerFrame.
    - `"SPELL Bloodrage"` : Cast Bloodrage.
    - `"ITEM Hearthstone"` : Use Hearthstone.
    - `"MACRO Foo"` : Run a macro called "Foo"
    - `"MACRO 1"` : Run a macro with index 1.
- `mode`
  - *number* - 1 if the binding should be saved to the currently loaded binding set (default), or 2 if to the alternative.

**Description:**
Override bindings take precedence over the normal SetBinding bindings. Priority override bindings take precedence over non-priority override bindings.
Override bindings are never saved, and will be wiped by an interface reload.

**Reference:**
- `SetOverrideBindingSpell`
- `SetOverrideBindingItem`
- `SetOverrideBindingMacro`
- `SetOverrideBindingClick`
- `ClearOverrideBindings`