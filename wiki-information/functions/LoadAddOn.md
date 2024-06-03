## Title: LoadAddOn

**Content:**
Loads the specified LoadOnDemand addon.
`loaded, reason = LoadAddOn(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loaded`
  - *boolean* - If the AddOn is successfully loaded or was already loaded.
- `reason`
  - *string?* - Locale-independent reason why the AddOn could not be loaded e.g. "DISABLED", otherwise returns nil if the addon was loaded.

**Description:**
Requires the addon to have the LoadOnDemand TOC field specified.
```
## LoadOnDemand: 1
```
LoadOnDemand addons are useful for reducing loading screen times by loading only when necessary, like with the different DeadlyBossMods addons/submodules.

**Related Events:**
- `ADDON_LOADED`

**Reasons:**
These have corresponding global strings when prefixed with "ADDON_":
- `ADDON_BANNED` = "Banned" -- Addon is banned by the client
- `ADDON_CORRUPT` = "Corrupt" -- The addon's file(s) are corrupt
- `ADDON_DEMAND_LOADED` = "Only loadable on demand"
- `ADDON_DISABLED` = "Disabled" -- Addon is disabled on the character select screen
- `ADDON_INCOMPATIBLE` = "Incompatible" -- The addon is not compatible with the current TOC version
- `ADDON_INSECURE` = "Insecure"
- `ADDON_INTERFACE_VERSION` = "Out of date"
- `ADDON_MISSING` = "Missing" -- The addon is physically not there
- `ADDON_NOT_AVAILABLE` = "Not Available"
- `ADDON_UNKNOWN_ERROR` = "Unknown load problem"
- `ADDON_DEP_BANNED` = "Dependency banned" -- Addon's dependency is banned by the client
- `ADDON_DEP_CORRUPT` = "Dependency corrupt" -- The addon's dependency cannot load because its file(s) are corrupt
- `ADDON_DEP_DEMAND_LOADED` = "Dependency only loadable on demand"
- `ADDON_DEP_DISABLED` = "Dependency disabled" -- The addon cannot load without its dependency enabled
- `ADDON_DEP_INCOMPATIBLE` = "Dependency incompatible" -- The addon cannot load if its dependency cannot load
- `ADDON_DEP_INSECURE` = "Dependency insecure"
- `ADDON_DEP_INTERFACE_VERSION` = "Dependency out of date"
- `ADDON_DEP_MISSING` = "Dependency missing" -- The addon's dependency is physically not there

**Usage:**
Attempts to load a LoadOnDemand addon. If the addon is disabled, it will try to enable it first.
```lua
local function TryLoadAddOn(name)
    local loaded, reason = LoadAddOn(name)
    if not loaded then
        if reason == "DISABLED" then
            EnableAddOn(name, true) -- enable for all characters on the realm
            LoadAddOn(name)
        else
            local failed_msg = format("%s - %s", reason, _G)
            error(ADDON_LOAD_FAILED:format(name, failed_msg))
        end
    end
end
TryLoadAddOn("SomeAddOn")
-- Couldn't load SomeAddOn: MISSING - Missing
```

Manually loads and shows the Blizzard Achievement UI addon.
```lua
/run LoadAddOn("Blizzard_AchievementUI"); AchievementFrame_ToggleAchievementFrame();
```

**Reference:**
- `IsAddOnLoaded()`
- `UIParentLoadAddOn()`

**Example Use Case:**
This function can be used to dynamically load addons that are not required at the start of the game, thereby reducing initial load times. For example, DeadlyBossMods (DBM) uses LoadOnDemand to load specific boss modules only when the player enters the relevant dungeon or raid.

**Large Addons Using This Function:**
- **DeadlyBossMods (DBM):** Uses LoadOnDemand to load specific boss encounter modules only when needed, reducing the overall memory footprint and load times.
- **Auctioneer:** Loads additional modules for advanced auction house functionalities only when the auction house interface is opened.