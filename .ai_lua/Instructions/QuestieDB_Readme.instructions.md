---
applyTo: '**/*.lua'
---
## QuestieDB Readme

QuestieDB is the database system for the Questie addon, structured as a Lua table keyed by unique game element IDs (`QuestId`, `ItemId`, etc.).

### Source Data Generation

-   Source data originates from running the `createStatic.lua` script (`.generate_database` folder).
-   This script generates `<DATATYPE>Data.lua-table` files into the `Database` folder structure.

### Corrections System

This system modifies or extends the generated data without altering the source files.

-   **Components:**
    -   `Corrections.lua`: Central hub for registering static/dynamic corrections.
    -   `<DATATYPE>Meta.lua` (e.g., `ItemMeta.lua`): Defines data structure, keys, types, and `dump` functions for each data type.
    -   `<EXP><DATATYPE>Fixes.lua` (e.g., `classicItemFixes.lua`): Contains the actual correction data (overrides/additions) for a specific game era.
    -   `DumpFunctions.lua`: Provides functions (`dump`, `dumpAsArray`, `dumpAsArraySorted`, `combine`) used by `Meta` files to format data during correction application.
-   **Process:** Corrections are registered and merged with generated data during database initialization.
-   **Running Generation:** Can be done via Docker (recommended: run `docker-compose.yml` in `.generate_database`) or potentially natively (execute Lua script from the root folder).

### Lua Data Structure (`<DATATYPE>Data.lua-table`)

-   A large Lua table mapping unique IDs to arrays of data.
    ```lua
    {
      [uniqueID] = {data1, data2, ..., dataN},
      [31] = {'Old Lion Statue',{248,249},{94},{[44]={{84.49,46.83}}},44,},
      -- etc.
    }
    ```
-   **Index Order is Critical:** Each index position corresponds to a specific data type defined in the `Meta` file. `nil` values are used as placeholders to maintain order if data is missing.
-   **Data Representation:** Primarily strings. Pattern values use semicolon (`;`) delimiters. The addon converts these strings to appropriate Lua types later.

### Data Usage & SimpleHTML Integration

-   QuestieDB serves as a static database. A Python script processes the Lua source into a SimpleHTML format for on-demand loading within the addon.
-   **SimpleHTML for Data:** Uses hidden SimpleHTML frames (`frame:hide()`) to store data. `GetRegions()` extracts data from `<p>` tags, effectively reading lines.
-   **On-Demand Loading:**
    -   Data isn't loaded into memory until requested, improving performance.
    -   Uses an "Index to Id" mapping to handle sparse data and quickly locate entries.
    -   When an ID is accessed, its `GetText()` function handle is cached.
    -   Frames are created on demand (not at startup) to reduce initial load times. Accessing a file caches all IDs within it.
-   **Client Limitations:** WoW limits `<p>` tags (~4000 chars) and HTML files (~45000 chars). Questie self-imposes a limit of ~50 IDs per file to manage load times effectively.

## SimpleHTML Data File Structure

QuestieDB uses three main types of HTML files generated from the Lua source:

### 1. Id File (`<DATANAME>DataIds.html`)

-   **Purpose:** An index listing *all* unique IDs for a specific data type (e.g., `QuestDataIds.html`).
-   **Structure:** HTML body with one or more `<p>` tags containing the same comma-separated list of all IDs (ending with a comma). Splitting across tags handles character limits.
-   **Usage:** Addon concatenates text from all `<p>` tags at runtime to get the full ID list.

### 2. File Names (`ItemdataTemplates.html` - Example)

-   **Purpose:** Maps data types and ID ranges to the actual data filenames, as the addon cannot list disk files directly.
-   **Structure:** A single `<p>` tag containing a comma-separated list of frame names (e.g., `ItemData25-37,ItemData38-51`). These names correspond to data files.
-   **Usage:** Addon uses binary search on this list to find the correct filename/frame name for a requested ID, then loads it using `CreateFrame`.

### 3. Data Files (`<START_ID>-<END_ID>.html`)

-   **Purpose:** Stores the actual data for specific IDs within a defined range (handles sparse data).
-   **Structure:**
    1.  **Index `<p>`:** The first `<p>` tag lists the specific IDs actually present in *this* file (comma-separated).
    2.  **Data Chunks:** For each ID listed in the index `<p>`:
        -   A `<p>` tag listing the data indexes present for that ID (comma-separated).
        -   Subsequent `<p>` tags, each containing one piece of data corresponding to the listed indexes, in order.
-   **Example (`25-37.html`):**
    ```html
    <html><body>
    <!-- Index to Id table -->
    <p>25,35,36,37</p> <!-- IDs present in this file -->
    <!-- Data for ID 25 -->
    <p>1,7</p> <!-- Data indexes for ID 25 -->
    <p>Worn Shortsword</p> <!-- Data for index 1 -->
    <p>0;0;2;1;0;2;7</p> <!-- Data for index 7 -->
    <!-- Data for ID 35 -->
    <p>1,7</p>
    <p>Bent Staff</p>
    <p>0;0;2;1;0;2;10</p>
    <!-- ... etc. for IDs 36, 37 -->
    </body></html>
    ```
-   **Data Type Conversion (Runtime):**
    -   **Tables:** String representation loaded via `loadstring()`.
    -   **Numbers:** String converted via `tonumber()`.
    -   **Pattern-Values:** Semicolon-delimited string split using Lua patterns.
    -   **Strings:** Used directly.
