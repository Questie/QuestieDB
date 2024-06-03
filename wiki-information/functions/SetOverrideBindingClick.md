## Title: SetOverrideBindingClick

**Content:**
Sets an override binding that performs a button click.
`SetOverrideBindingClick(owner, isPriority, key, buttonName)`

**Parameters:**
- `owner`
  - *Frame* - The frame this binding "belongs" to; this can later be used to clear all override bindings belonging to a particular frame.
- `isPriority`
  - *boolean* - true if this is a priority binding, false otherwise. Both types of override bindings take precedence over normal bindings.
- `key`
  - *string* - Binding to bind the command to. For example, "Q", "ALT-Q", "ALT-CTRL-SHIFT-Q", "BUTTON5"
- `buttonName`
  - *string* - Name of the button widget this binding should fire a click event for.
- `mouseClick`
  - *string* - Mouse button name argument passed to the OnClick handlers.

**Description:**
Override bindings take precedence over the normal `SetBinding` bindings. Priority override bindings take precedence over non-priority override bindings.
Override bindings are never saved, and will be wiped by an interface reload.
You cannot use this function to clear an override binding; use `SetOverrideBinding` instead.

**Reference:**
- `SetOverrideBinding`
- `SetOverrideBindingSpell`
- `SetOverrideBindingItem`
- `SetOverrideBindingMacro`
- `ClearOverrideBindings`

**Example Usage:**
```lua
-- Example of setting an override binding to click a button named "MyButton" when the "Q" key is pressed
SetOverrideBindingClick(MyFrame, true, "Q", "MyButton")
```

**Addons Using This Function:**
Many large addons, such as Bartender4 and ElvUI, use this function to provide custom key bindings for their action bars and other interactive elements. This allows users to have more flexible and dynamic control over their UI interactions.