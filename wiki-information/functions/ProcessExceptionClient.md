## Title: ProcessExceptionClient

**Content:**
Generates textual error logs for any current Lua error.
`ProcessExceptionClient(description)`

**Parameters:**
- `description`
  - *string* - The description of the error being processed.

**Description:**
This function is invoked by the default global error handler to trigger the generation of textual error logs when a Lua error occurs in a secure execution path.
The `luaErrorExceptions` console variable must be enabled for this function to have any effect.