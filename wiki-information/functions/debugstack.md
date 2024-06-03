## Title: debugstack

**Content:**
Returns a string representation of the current calling stack.
`description = debugstack( ]])`

**Parameters:**
- `coroutine`
  - *Thread* - The thread with the stack to examine (default - the calling thread)
- `start`
  - *number* - the stack depth at which to start the stack trace (default 1 - the function calling debugstack, or the top of coroutine's stack)
- `count1`
  - *number* - the number of functions to output at the top of the stack (default 12)
- `count2`
  - *number* - the number of functions to output at the bottom of the stack (default 10)

**Returns:**
- `description`
  - *string* - a multi-line string showing what the current call stack looks like
    - If there are more than count1+count2 calls in the stack, they are separated by a "..." line.
    - Long lines may become truncated.
    - The string ends with an extra newline character.

**Usage:**
Assume the following example file, "file.lua":
```lua
1: function a()
2: error("Boom!"); 
3: end
4:
5: function b() a(); end
6:
7: function c() b(); end
8:
9: function d() c(); end
10:
11: function e() d(); end
12:
13: function f() e(); end
14:
15: function errhandler(msg)
16: print (msg .. "\nCall stack: \n" .. debugstack(2, 3, 2));
17: end
18:
19: xpcall(f, errhandler);
```
This would output something along the following:
```
file.lua:2: Boom!
Call stack:
file.lua:2: in function a
file.lua:5: in function b
file.lua:7: in function c
...
file.lua:13: in function f
file.lua:19
```

Example 2:
Combining debugstack with a strmatch can enable you to get the current line of a function call.
```lua
1: function debugprint(msg)
2: local line = strmatch(debugstack(2),":(%d):");
3: print("Debug Print on Line "..line.." with message: "..msg);
4: end
5:
6: function doSomething()
7: debugprint("We tried to do something.");
8: end
```
This would return the following output from print:
```
Debug Print on Line 7 with message: We tried to do something.
```

This is a WoW API modified version of Lua's `debug.traceback()` function.