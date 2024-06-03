## Title: GetNumAddOns

**Content:**
Get the number of user-supplied AddOns.
`count = GetNumAddOns()`

**Returns:**
- `count`
  - *number* - The number of user-supplied AddOns installed. This is the maximum valid index to the other AddOn functions. This count does NOT include Blizzard-supplied UI component AddOns.

**Example Usage:**
This function can be used to iterate over all installed user-supplied AddOns. For example, you can use it in combination with `GetAddOnInfo` to list all AddOns:

```lua
local numAddOns = GetNumAddOns()
for i = 1, numAddOns do
    local name, title, notes, loadable, reason, security = GetAddOnInfo(i)
    print(name, title, notes, loadable, reason, security)
end
```

**AddOns Using This Function:**
Many large AddOns and AddOn managers, such as **ElvUI** and **WeakAuras**, use this function to manage and display information about other installed AddOns. For instance, AddOn managers might use it to provide a list of all installed AddOns, allowing users to enable or disable them as needed.