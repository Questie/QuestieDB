## Title: debuglocals

**Content:**
Returns a string dump of all local variables and upvalues at a given stack level.
`locals = debuglocals()`

**Parameters:**
- `level`
  - *number* - The stack level to inspect. Defaults to 1 (the calling function).

**Returns:**
- `locals`
  - *string?* - A string dump of all local variables, temporaries, and upvalues.

**Description:**
This function will return no values if called outside of the execution of the global error handler function.

**Usage:**
The following snippet demonstrates example output for a variety of values. Note that this snippet may not work as-is if you have an error handling addon installed, as these typically hijack and replace the ability to change the global error handler.
```lua
local Upvalue = "banana"
seterrorhandler(function()
  local Number = 1.23456
  local String = "foo"
  local NamedFrame = { = ChatFrame1 }
  local Table = {
    1,
    2,
    foo = "bar",
    {
      "debuglocals should only inspect at-most one level of tables; this shouldn't be printed",
    },
  }
  local Thread = coroutine.create(function() end)
  local Boolean = true
  local Nil = nil
  local Temp = Upvalue
  print(debuglocals())
end)
error("")
```
Example output:
```
Number = 1.234560
String = "foo"
NamedFrame = ChatFrame1 {
  0 = <userdata>
}
Table = <table> {
  1 = 1
  2 = 2
  3 = <table> {
  }
  foo = "bar"
}
Thread = <no value>
Boolean = true
Nil = nil
Temp = "banana"
(*temporary) = <function> defined @Interface\FrameXML\UIParent.lua:5234
Upvalue = "banana"
```