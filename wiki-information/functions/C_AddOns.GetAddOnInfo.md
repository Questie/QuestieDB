## Title: C_AddOns.GetAddOnInfo

**Content:**
Needs summary.
`name, title, notes, loadable, reason, security, updateAvailable = C_AddOns.GetAddOnInfo(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to C_AddOns.GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `name`
  - *string* - The name of the AddOn (the folder name).
- `title`
  - *string* - The localized title of the AddOn as listed in the .toc file.
- `notes`
  - *string* - The localized notes about the AddOn from its .toc file.
- `loadable`
  - *boolean* - Indicates if the AddOn is loaded or eligible to be loaded, true if it is, false if it is not.
- `reason`
  - *string* - The reason why the AddOn cannot be loaded. This is nil if the addon is loadable, otherwise it contains a string token indicating the reason that can be localized by prepending "ADDON_".
- `security`
  - *string* - Indicates the security status of the AddOn. This is currently "INSECURE" for all user-provided addons, "SECURE_PROTECTED" for guarded Blizzard addons, and "SECURE" for all other Blizzard AddOns.
- `updateAvailable`
  - *boolean* - Not currently used.

**Description:**
A full list of all reason codes can be found below.

**Reason Codes:**
- `CORRUPT` - Corrupt
- `DEMAND_LOADED` - Only loadable on demand
- `DEP_BANNED` - Dependency banned
- `DEP_CORRUPT` - Dependency corrupt
- `DEP_DEMAND_LOADED` - Dependency only loadable on demand
- `DEP_DISABLED` - Dependency disabled
- `DEP_EXCLUDED_FROM_BUILD` - Dependency excluded from build
- `DEP_INSECURE` - Dependency incompatible
- `DEP_INTERFACE_VERSION` - Dependency insecure
- `DEP_LOADABLE` - Dependency out of date
- `DEP_MISSING` - Dependency missing
- `DEP_NO_ACTIVE_INTERFACE` - Dependency has no active UI
- `DEP_NOT_AVAILABLE` - Dependency not available
- `DEP_USER_ADDONS_DISABLED` - Dependency user addons disabled
- `DEP_WRONG_ACTIVE_INTERFACE` - Dependency has wrong active UI
- `DEP_WRONG_GAME_TYPE` - Dependency has wrong game type
- `DEP_WRONG_LOAD_PHASE` - Dependency has wrong load phase
- `EXCLUDED_FROM_BUILD` - Excluded from build
- `INSECURE` - Insecure
- `INTERFACE_VERSION` - Out of date
- `MISSING` - Missing
- `NO_ACTIVE_INTERFACE` - No active UI
- `NOT_AVAILABLE` - Not available
- `USER_ADDONS_DISABLED` - User addons disabled
- `WRONG_ACTIVE_INTERFACE` - Wrong active UI
- `WRONG_GAME_TYPE` - Wrong game type
- `WRONG_LOAD_PHASE` - Wrong load phase