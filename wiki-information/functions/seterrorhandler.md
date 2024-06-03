## Title: seterrorhandler

**Content:**
Sets the error handler to the given function.
`seterrorhandler(errFunc)`

**Parameters:**
- `errFunc`
  - *function* - The function to call when an error occurs. The function is passed a single argument containing the error message.

**Usage:**
If you wanted to print all errors to your chat frame, you could do:
```lua
seterrorhandler(print);
```
Alternatively, the following would also perform the same task:
```lua
seterrorhandler(function(msg)
  print(msg);
end);
```