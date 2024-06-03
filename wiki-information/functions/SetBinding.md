## Title: SetBinding

**Content:**
Sets a key binding to an action.
`ok = SetBinding(key)`

**Parameters:**
- `key`
  - *string* - Any binding string accepted by World of Warcraft. For example: `"ALT-CTRL-F"`, `"SHIFT-T"`, `"W"`, `"BUTTON4"`.
- `command`
  - *string?* - Any name attribute value of a Bindings.xml-defined binding, or an action command string, or nil to unbind all bindings from key. For example:
    - `"SITORSTAND"`: a Bindings.xml-defined binding to toggle between sitting and standing
    - `"CLICK PlayerFrame:LeftButton"`: Fire a left-click on the PlayerFrame.
    - `"SPELL Bloodrage"`: Cast Bloodrage.
    - `"ITEM Hearthstone"`: Use Hearthstone.
    - `"MACRO Foo"`: Run a macro called "Foo".
    - `"MACRO 1"`: Run a macro with index 1.
- `mode`
  - *number?* - 1 if the binding should be saved to the currently loaded binding set (default), or 2 if to the alternative.

**Returns:**
- `ok`
  - *boolean* - 1 if the binding has been changed successfully, nil otherwise.

**Usage:**
```lua
-- Remove all bindings from the right mouse button.
SetBinding("BUTTON2");

-- Restore the default binding for the right mouse button.
SetBinding("BUTTON2", "TURNORACTION");
```

**Description:**
There are two binding sets: per-account and per-character bindings; of which one may be presently loaded (LoadBindings). You may look up which one is currently loaded using `GetCurrentBindingSet()`.
A single binding can only be bound to a single command at a time, although multiple bindings may be bound to the same command. The Key Bindings UI will only show the first two bindings, but there is no limit to the number of keys that can be used for the same command.
The Key Bindings UI will update immediately should this function succeed. However, bindings are not saved without an explicit `SaveBindings()` call. Unless saved, bindings will reset on next log-in / bindings load.
A list of default FrameXML bindings.xml-defined actions is available: `BindingID`.
The Addon API doesn't know what the default binding is for any single action. You can set them all to their defaults by calling `LoadBindings(DEFAULT_BINDINGS)`; this is an all-or-nothing action.
If you set bindings using this API, they will be permanently saved to the current set. If you want more control of what bindings are loaded, you may want to use `SetOverrideBindingClick` to enable them for each login session.

**Reference:**
- `API SetBindingSpell`
- `API SetBindingItem`
- `API SetBindingMacro`
- `API SetBindingClick`