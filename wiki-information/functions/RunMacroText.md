## Title: RunMacroText

**Content:**
Executes a string as if it was a macro.
`RunMacroText(macro)`

**Parameters:**
- `macro`
  - *string* - the string is interpreted as a macro and then executed

**Usage:**
This creates an invisible button in the middle of the screen, that prints Hello World! every time it is clicked with the left button.
```lua
-- Create the macro to use
local myMacro = [=[
/run print("Hello")
/run print("World!")
]=]
-- Create the secure frame to activate the macro
local frame = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate");
frame:SetPoint("CENTER")
frame:SetSize(100, 100);
frame:SetAttribute("type", "macro") 
frame:SetAttribute("macrotext", myMacro);
frame:RegisterForClicks("LeftButtonUp");
```

**Description:**
Macros are executed via the client repeatedly firing the EXECUTE_CHAT_LINE event.
The maximum macro length via this method is 1023 characters.