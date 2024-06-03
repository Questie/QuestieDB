## Title: securecall

**Content:**
Calls the specified function without propagating taint to the caller.
`... = securecall(func or functionName, ...)`
`... = securecallfunction(func, ...)`

**Parameters:**
- `func`
  - *function|string* - A direct reference of the function to be called, or for securecall a string name of a function to be resolved through a global lookup.
- `...`
  - Additional arguments to supply to the function.

**Returns:**
- `...`
  - The return values of the called function.

**Description:**
If `securecall` is called from a secure execution path, the execution path will remain secure when `securecall` returns, even if the called function is tainted, or accesses tainted variables.
Errors that occur within the called function are not propagated to the caller; if an error occurs, `securecall` triggers the default error handler, and then returns control to the caller with no return values.
For `securecallfunction`, no attempt is made to perform a global lookup based on the supplied function argument.