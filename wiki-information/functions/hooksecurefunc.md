## Title: hooksecurefunc

**Content:**
Securely posthooks the specified function. The hook will be called with the same arguments after the original call is performed.
`hooksecurefunc(functionName, hookfunc)`

**Parameters:**
- `table`
  - *Optional Table* - Table to hook the `functionName` key in; if omitted, defaults to the global table (`_G`).
- `functionName`
  - *string* - name of the function being hooked.
- `hookfunc`
  - *function* - your hook function.

**Usage:**
The following calls hook `CastSpellByName` and `GameTooltip:SetUnitBuff` without compromising their secure status. When those functions are called, the hook prints their argument list into the default chat frame.
```lua
hooksecurefunc("CastSpellByName", print); -- Hooks the global CastSpellByName
hooksecurefunc(GameTooltip, "SetUnitBuff", print); -- Hooks GameTooltip.SetUnitBuff
```

**Description:**
This is the only safe way to hook functions that execute protected functionality.
`hookfunc` is invoked after the original function, and receives the same parameters; return values from `hookfunc` are discarded.
After this function is used on a function, `setfenv()` throws an error when attempted on that function.
You cannot "unhook" a function that is hooked with this function except by a UI reload. Calling `hooksecurefunc()` multiple times only adds more hooks to be called.
Also note that using `hooksecurefunc()` may not always produce the expected result. Keep in mind that it actually replaces the original function with a new one (the function reference changes). For example, if you try to hook the global function `MacroFrame_OnHide` (after the macro frame has been displayed), your function will not be called when the macro frame is closed. It's simply because in `Blizzard_MacroUI.xml` the `OnHide` function call is registered like this:
```xml
<OnHide function="MacroFrame_OnHide"/>
```
The function ID called when the frame is hidden is the former one, before you hooked `MacroFrame_OnHide`. The workaround is to hook a function called by `MacroFrame_OnHide`:
```lua
hooksecurefunc(MacroPopupFrame, "Hide", MyFunction)
```
If you want to securely hook a frame's script handler, use `Frame:HookScript`:
```lua
MacroPopupFrame:HookScript("OnHide", MyFunction)
```