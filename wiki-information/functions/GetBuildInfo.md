## Title: GetBuildInfo

**Content:**
Returns info for the current client build.
`version, build, date, tocversion, localizedVersion, buildType = GetBuildInfo()`

**Returns:**
- `version`
  - *string* - Current patch version
- `build`
  - *string* - Build number
- `date`
  - *string* - Build date
- `tocversion`
  - *number* - Interface (.toc) version number
- `localizedVersion`
  - *string* - Localized translation for the string "Version"
- `buildType`
  - *string* - Localized build type and machine architecture

**Description:**
In the initial testing build of Patch 10.1.0 (48480) the `localizedVersion` and `buildType` return values do not function as intended and will return an empty string and a string with just a space character respectively.

**Usage:**
```lua
/dump GetBuildInfo() -- "9.0.2", "36665", "Nov 17 2020", 90002
```

**Miscellaneous:**
- **Flavor**
  - **Patch**
  - **TOC version**
- **The War Within**
  - **11.0.0**
  - **110000**
- **Mainline PTR**
  - **10.2.7**
  - **100207**
- **Mainline**
  - **10.2.6**
  - **100207**
- **Cataclysm Classic**
  - **4.4.0**
  - **40400**
- **Wrath Classic**
  - **3.4.3**
  - **30403**
- **Classic Era**
  - **1.15.2**
  - **11502**

**Reference:**
- [Public client builds - List of documented builds](https://wow.tools/builds/)
- [List of datamined builds](https://www.townlong-yak.com/framexml/builds)