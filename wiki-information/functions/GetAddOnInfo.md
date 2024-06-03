## Title: GetAddOnInfo

**Content:**
Get information about an AddOn.
`name, title, notes, loadable, reason, security, newVersion = GetAddOnInfo(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `name`
  - *string* - The name of the AddOn (the folder name).
- `title`
  - *string* - The title of the AddOn as listed in the .toc file (presumably this is the appropriate localized one).
- `notes`
  - *string* - The notes about the AddOn from its .toc file (presumably this is the appropriate localized one).
- `loadable`
  - *boolean* - Indicates if the AddOn is loaded or eligible to be loaded, true if it is, false if it is not.
- `reason`
  - *string* - The reason why the AddOn cannot be loaded. This is nil if the addon is loadable, otherwise it contains a string token indicating the reason that can be localized by prepending "ADDON_". ("BANNED", "CORRUPT", "DEMAND_LOADED", "DISABLED", "INCOMPATIBLE", "INTERFACE_VERSION", "MISSING")
- `security`
  - *string* - Indicates the security status of the AddOn. This is currently "INSECURE" for all user-provided addons, "SECURE_PROTECTED" for guarded Blizzard addons, and "SECURE" for all other Blizzard AddOns.
- `newVersion`
  - *boolean* - Not currently used.

**Description:**
If the function is passed a string, `name` will always be the value passed, so check if `reason` equals "MISSING" to find out if an addon exists.
If the function is passed a number that is out of range, you will get an error message, specifically: `<line number> AddOn index must be in the range of 1 to <GetNumAddOns()>`.

**Example Usage:**
```lua
local name, title, notes, loadable, reason, security, newVersion = GetAddOnInfo("MyAddon")
if reason == "MISSING" then
    print("Addon does not exist.")
else
    print("Addon exists and is loadable: ", loadable)
end
```

**AddOns Using This Function:**
Many large addons use `GetAddOnInfo` to check the status of other addons or to manage dependencies. For example:
- **WeakAuras**: Uses it to check if certain addons are present and to manage compatibility.
- **ElvUI**: Uses it to ensure that required modules or plugins are available and loaded correctly.