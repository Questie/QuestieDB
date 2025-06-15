---
applyTo: '**/*.toc'
---

# World of Warcraft Addon `.toc` File Specification (Definitive Guide)

## 1. Core Concepts & Structure

A `.toc` (Table of Contents) file is the mandatory entry point for any World of Warcraft addon. It acts as a manifest, defining the addon's identity and instructing the game client on which files to load.

#### Key Structural Rules:
-   **File Naming:** The `.toc` filename **must** be identical to its parent folder's name (e.g., `..\Interface\AddOns\MyAddon\MyAddon.toc`).
-   **Metadata:** Lines starting with `##` define addon properties (e.g., `## Title: My Addon`). The format is `## Directive: Value`.
-   **Comments:** Lines starting with `#` are comments and are ignored. **Crucially, any whitespace before the `#` will cause the line to be treated as a filename.**
-   **File List:** All other lines are treated as file paths to be loaded in the order they appear.
-   **Path Separators:** Backslashes (`\`) are the recommended separator for file paths.

---

## 2. Metadata Directives Explained

### 2.1. Interface Version

`## Interface: <version>`

This is the most critical directive. It declares the WoW client version the addon was built for. If this number is lower than the client's, the addon is marked "out of date."

-   **Format:** The game version with periods removed (e.g., `11.0.2` -> `110002`).
-   **Multi-Version Support (Cata Classic+):** A comma-separated list allows a single `.toc` to target multiple game clients, which is the modern standard.
    -   `## Interface: 110105, 50500, 40402`

#### Current Interface Versions (as of late 2024)

| Client Flavor | Interface Version |
| :--- | :--- |
| Mainline (The War Within) | `110105` |
| Classic (Mists of Pandaria) | `50500` |
| Classic (Cataclysm) | `40402` |
| Classic (Wrath of the Lich King) | `30403` |
| Classic (Vanilla/Era) | `11507` |

### 2.2. Addon Display Information

These control how the addon appears in the in-game AddOns list. Most support localization (e.g., `Title-deDE`) and UI color codes (e.g., `|cFFFF0000Red|r`).

-   `## Title: MyAddonName`
    -   The name displayed in the AddOns list.
-   `## Notes: A description of my addon.`
    -   The tooltip text shown when hovering over the addon.
-   `## Author: YourName`
-   `## Version: 1.2.3`
-   `## Category: Action Bars` **(Cata Classic+)**
    -   Groups the addon under a standard, collapsible category header.
-   `## Group: MyMainAddon` **(Cata Classic+)**
    -   Groups this addon as an indented sub-item of another addon. The value must be the folder name of the main addon.
-   `## IconTexture: Interface\Icons\INV_Misc_Bag_10` **(Retail Only)**
    -   Path to a `.tga` or `.blp` file for the addon's icon.
-   `## IconAtlas: TaskPOI-Icon` **(Retail Only)**
    -   Name of a texture atlas for the icon. `IconTexture` has higher priority.

### 2.3. Saved Variables

Declares global Lua variables that the game automatically saves between sessions.

-   `## SavedVariables: MyAddonDB, MyAddonSettings`
    -   Saves variables to an account-wide file (`WTF/Account/.../SavedVariables/`).
-   `## SavedVariablesPerCharacter: MyCharacterDB`
    -   Saves variables to a character-specific file (`WTF/Account/.../Server/Character/SavedVariables/`).
-   `## LoadSavedVariablesFirst: 1` **(MoP Classic+)**
    -   If set to `1`, saved variables are loaded *before* any addon scripts. By default, they are loaded after.

### 2.4. Dependency and Load Management

-   `## Dependencies: DBM-Core, WeakAuras`
    -   Comma-separated list of addons that **must** load before this one.
-   `## OptionalDeps: Details, Plater`
    -   Addons that, if present, should load before this one. The addon will still load if they are missing.
-   `## LoadOnDemand: 1`
    -   Prevents the addon from loading at startup. It must be loaded manually with the `LoadAddOn()` API function.
-   `## LoadWith: DBM-Core, BigWigs`
    -   Implies `LoadOnDemand`. The addon will automatically load whenever any of the specified **AddOns** are loaded.
-   `## DefaultState: disabled`
    -   The addon will be disabled by default and must be manually enabled by the user.

---

## 3. Feature Evolution & Version Differences

The `.toc` format has gained significant features over time. Understanding what is available on each client is key to multi-version support.

-   **Classic Era / Wrath / TBC:** These clients use the foundational `.toc` features. They **do not** support modern additions like comma-separated interfaces, categories, or per-file conditions. Multi-version support relies on using separate, client-specific `.toc` files.
-   **Cataclysm Classic:** Represents a middle ground. It introduced support for `## Category`, `## Group`, and comma-separated `## Interface` tags, greatly simplifying multi-version management.
-   **Mists of Pandaria Classic:** This client is based on a much more modern codebase. It inherits all features from Cataclysm and adds support for `## LoadSavedVariablesFirst` and the powerful **per-file conditions and variables**.
-   **Retail (Dragonflight / The War Within):** Includes all features from previous versions and adds Retail-exclusive functionality like `## IconTexture` and Addon Compartment integration.

### Feature Availability Across Modern Clients

| Feature | Retail (TWW) | MoP Classic | Cata Classic | Wrath / TBC / Era |
| :--- | :---: | :---: | :---: | :---: |
| Basic Metadata & Dependencies | ✅ | ✅ | ✅ | ✅ |
| Client-Specific `.toc` Suffixes | ✅ | ✅ | ✅ | ✅ |
| Comma-separated `## Interface` | ✅ | ✅ | ✅ | ❌ |
| `## Category`, `## Group` | ✅ | ✅ | ✅ | ❌ |
| `## IconTexture`, `## IconAtlas` | ✅ | ❌ | ❌ | ❌ |
| Addon Compartment Directives | ✅ | ❌ | ❌ | ❌ |
| `## LoadSavedVariablesFirst` | ✅ | ✅ | ❌ | ❌ |
| Per-File Conditions/Variables | ✅ | ✅ | ❌ | ❌ |

---

## 4. Advanced Loading Techniques

### 4.1. Client-Specific `.toc` Files

While comma-separated interfaces are preferred, you can still provide different `.toc` files for each client using a suffix. The client loads the most specific file available (e.g., `_Cata.toc` is chosen over `_Classic.toc` on a Cata client).

-   `AddonName_Mainline.toc` (Retail)
-   `AddonName_Mists.toc`
-   `AddonName_Cata.toc`
-   `AddonName_Wrath.toc`
-   `AddonName_Vanilla.toc` (Era)
-   `AddonName_Classic.toc` (Fallback for all Classic versions)

### 4.2. Per-File Conditions and Variables **(MoP Classic+)**

This powerful system allows a single `.toc` file to dynamically load different files based on the game client.

-   **Conditions:** Append `[AllowLoadGameType <type>]` to a line.
    `RetailOnly.lua [AllowLoadGameType mainline]`
    `ClassicData.lua [AllowLoadGameType classic]`

-   **Variables:** Use `[Family]` or `[Game]` in the file path.
    -   `[Family]`: Expands to `Mainline` or `Classic`.
    -   `[Game]`: Expands to `Standard`, `Mists`, `Cata`, etc.
    `Libs\[Family]\Lib.lua` -> `Libs\Mainline\Lib.lua` or `Libs\Classic\Lib.lua`

---

## 5. Restricted / Blizzard-Only Directives

The following are reserved for Blizzard's internal UI and are **non-functional** for third-party addons.

-   `## AllowLoad: Game | Glue | Both`
    -   Restricts loading to the login screen (`Glue`) vs. the game world (`Game`). **Do not confuse this with `[AllowLoadGameType]`**.
-   `## LoadFirst: 1`: Ensures core UI loads before any other addon.
-   `## UseSecureEnvironment: 1`: Loads files into a secure environment.

---

## 6. Example File Analysis (`QuestieDB.toc`)

```toc
## Interface: 20504
## Title: QuestieDB
## Author: Logon (...)
## Notes: A standalone QuestieDB
## Version: 0.6.0
## SavedVariables: QuestieDB
## SavedVariablesPerCharacter: QuestieDB_c, QuestieDB_trace

# Load Environment
_dotenv.lua
# ... more files ...
```

-   **File List:** The file list correctly uses comments (`#`) for organization and backslashes for subdirectories, demonstrating proper structure. This example highlights how critical correct syntax is.