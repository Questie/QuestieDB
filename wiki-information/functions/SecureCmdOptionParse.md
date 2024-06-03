## Title: SecureCmdOptionParse

**Content:**
Evaluates macro conditionals without the need of a macro.
`result, target = SecureCmdOptionParse(options)`

**Parameters:**
- `options`
  - *string* - a secure command options string to be parsed, e.g. "ALT is held down; CTRL is held down, but ALT is not; neither ALT nor CTRL is held down".

**Returns:**
- `result`
  - *string* - value of the first satisfied clause in options, or no return (nil) if none of the conditions in options are satisfied.
- `target`
  - *string* - the target of the first satisfied clause in options (using either the target=... or @... conditional), nil if the clause does not explicitly specify a target, or no return (nil) if none of the conditions in options are satisfied.

**Description:**
Note that item links cannot be part of options string as they contain square brackets, which get interpreted by the parser as conditions.
This function is available in the RestrictedEnvironment, and is used to evaluate the options for secure macro commands.

**Reference:**
- Secure command options
- SecureStateDriver