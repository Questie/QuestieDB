## Title: GetFunctionCPUUsage

**Content:**
Returns information about CPU usage by a function.
`usage, calls = GetFunctionCPUUsage(func, includeSubroutines)`

**Parameters:**
- `func`
  - *function* - The function to query CPU usage for.
- `includeSubroutines`
  - *boolean* - Whether to include subroutine calls in the CPU usage calculation.

**Returns:**
- `usage`
  - *number* - The amount of CPU time used by the function.
- `calls`
  - *number* - The number of times the function has been called.

**Description:**
Only returns valid data if the `scriptProfile` CVar is set to 1; returns 0 otherwise.