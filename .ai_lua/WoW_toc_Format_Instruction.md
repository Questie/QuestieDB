# World of Warcraft AddOn .toc Files

## Overview

A `.toc` file is mandatory for any World of Warcraft AddOn. It provides essential information about the AddOn, such as its name, description, saved variables, and, most importantly, the list of `.lua` and `.xml` files to be loaded and their loading order. The filename of the `.toc` file must match the name of the directory containing the AddOn.

## Key Features and Structure

*   **File Naming:** The `.toc` file's name must match its containing folder's name (e.g., `MyAddon/MyAddon.toc`).
*   **Metadata:** AddOn metadata is defined using `## Directive: Value` format.
*   **Comments:** Comments are indicated by a leading `#`.
*   **File List:** Specifies the `.lua` and `.xml` files to be loaded by the AddOn, listed one file per line.  The order of files listed determines the loading order.

## Elements

The `.toc` file can contain the following elements:

*   **Metadata Directives:**
    *   `## Title: AddOn Name` - The name of the AddOn.
    *   `## Notes: AddOn Description` - A description of the AddOn.
    *   `## Author: Author's Name` - The author of the AddOn.
    *   `## Version: Version Number` - The AddOn's version number.
    *   `## Interface: Interface Version` - The WoW client interface version the AddOn is designed for.
    *   `## SavedVariables: Variable1, Variable2` - A comma-separated list of global variables to be saved.
    *   `## SavedVariablesPerCharacter: Variable3, Variable4` - A comma-separated list of character-specific variables to be saved.
    *   `## LoadOnDemand: 1` - Specifies that the AddOn should only be loaded when it's needed.
    *   `## Dependencies: AddOn1, AddOn2` - A comma-separated list of AddOns that this AddOn depends on.
    *   `## OptionalDeps: AddOn3, AddOn4` - A comma-separated list of AddOns that this AddOn optionally depends on.
    *   `## LoadWith: UIELEMENT` - Loads the addon when the specified UI element is loaded.
    *   `## LoadManagers: MANAGER` - Loads the addon when the specified load manager is loaded.
    *   `## AllowLoadGameType: Environment` -  Defines the environment in which the addon can load ("Game", "Glue", or "Both").
    *   `## OnlyBetaAndPTR: 1` - Only load the addon in Beta and PTR environments.
    *   `## DefaultState: Enabled` - Specifies whether the addon is enabled by default.
    *   `## Group: GroupName` - Specifies the group the addon belongs to in the addon list.
    *   `## IconTexture: Path\To\Texture` - Path to a texture file for the addon icon.
    *   `## IconAtlas: AtlasName` - Name of a texture atlas for the addon icon.
    *   `## AllowAddOnTableAccess: 1` - Allows retrieval of the addon's namespace table via `C_AddOns.GetLocalAddOnTable()`.
    *   `## SavedVariablesPerCharacter: MyAddOnNameAnotherVariable` - Variables saved on a per-character basis.
    *   `## X-CustomMetadata: Value` - Custom metadata (e.g., `X-Date`, `X-Website`).
*   **File Loading Order:**
    *   The order in which `.lua` and `.xml` files are listed in the `.toc` file determines their loading order.

## Client-Specific TOC Files

AddOns can have multiple `.toc` files with suffixes for specific clients:

*   `AddonName_Mainline.toc` - For the retail client.
*   `AddonName_Classic.toc` - For all Classic clients.
*   `AddonName_Vanilla.toc` - For Classic Era.
*   `AddonName_TBC.toc` - For Burning Crusade Classic.
*   `AddonName_Wrath.toc` - For Wrath of the Lich King Classic.
*   `AddonName_Cata.toc` - For Cataclysm Classic.
*   `AddonName_WoWLabs.toc` - For Plunderstorm.

The client searches for these specific files first before defaulting to `AddonName.toc`.

## Examples

```toc
## Title: My Cool Addon
## Notes: This is a description of my cool addon.
## Author: Your Name
## Version: 1.0
## Interface: 110000
## SavedVariables: MyAddonVariable

MyAddon.lua
MyAddon.xml
```