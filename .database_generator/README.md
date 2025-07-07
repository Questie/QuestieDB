# QuestieDB Database Generator

This system converts raw World of Warcraft database files into the optimized HTML format consumed by the QuestieDB addon. It handles multiple WoW expansions, applies static corrections, merges localization data, and generates chunked HTML files for efficient addon loading.

## Overview

The database generator orchestrates a complex pipeline that processes game data through multiple phases:

1. **Data Loading**: Loads raw database files for Items, NPCs, Objects, and Quests
2. **Correction Application**: Applies static corrections to fix data issues
3. **Localization Merging**: Combines Questie and Mangos translation data
4. **HTML Generation**: Converts data into chunked HTML files for addon consumption
5. **File Organization**: Outputs organized directory structure with metadata files

## Prerequisites

- Lua 5.1+ runtime environment
- Required data sources:
  - Raw database files (`*DB.lua`) from Questie data extraction
  - Static correction files from the `Corrections/` directory
  - Localization lookup files from Questie data
  - Mangos translation XML files (optional but recommended)

## Data Flow Pipeline

```
Raw Database Files (ItemDB.lua, NpcDB.lua, etc.)
                    ↓
            Data Loaders (item.lua, npc.lua, etc.)
                    ↓
            Static Corrections Applied
                    ↓
        Localization Data Loading & Merging
                    ↓
            HTML Generation & Chunking
                    ↓
            File Output (HTML + Metadata)
```

### Phase 1: Data Loading
Each entity type (Item, NPC, Object, Quest) has a dedicated loader:
- `data_loaders/item.lua` - Loads item data and corrections
- `data_loaders/npc.lua` - Loads NPC data and corrections
- `data_loaders/object.lua` - Loads object data and corrections
- `data_loaders/quest.lua` - Loads quest data and corrections

### Phase 2: Localization Processing
- `data_loaders/l10n.lua` - Loads Questie localization data
- Merges Mangos translations to fill gaps
- Applies entity-specific merge strategies
- Filters translations to valid entity IDs only

### Phase 3: HTML Generation
- `dump.lua` - Converts database tables to HTML format
- Handles UTF-8 safe string processing for international text
- Chunks large datasets to prevent memory issues
- Generates auxiliary files for addon loading

## File Structure

### Input Files
```
.database_generator/
├── data_loaders/          # Data loading modules
│   ├── item.lua           # Item data loader
│   ├── npc.lua            # NPC data loader
│   ├── object.lua         # Object data loader
│   ├── quest.lua          # Quest data loader
│   └── l10n.lua           # Localization data loader
├── createStatic.lua       # Main orchestration script
├── dump.lua               # HTML generation engine
└── README.md              # This file
```

### Output Structure
```
Database/
├── Item/
│   └── [Version]/
│       ├── _data/                  # Chunked HTML files (1.html, 2.html, etc.)
│       ├── ItemData.lua-table      # Debug format
│       ├── ItemDataIds.html        # All item IDs
│       ├── ItemDataTemplates.html  # Template references
│       └── ItemDataFiles.xml       # Addon XML definitions
├── Npc/
├── Object/
├── Quest/
└── l10n/
    └── [Version]/
        ├── _data/              # Chunked localization files
        ├── l10nData.lua-table  # Debug format
        └── [metadata files]
```

## Usage

### Basic Usage
```lua
-- Main function call
DumpDatabase("era", "Classic", false)
```

### Parameters
- `questiedb_version`: WoW version ("era", "tbc", "wotlk", "cata", "mop")
- `questie_version`: Questie version ("Classic", "TBC", "Wotlk", "Cata", "MoP")
- `debug`: Optional debug flag for additional output

### Version Mapping
The system uses different naming conventions for different purposes:

| WoW Expansion | QuestieDB Version | Questie Repo Version |
|---------------|-------------------|---------------------|
| Classic Era   | `era`            | `Classic`           |
| Burning Crusade | `tbc`          | `TBC`               |
| Wrath of the Lich King | `wotlk`  | `Wotlk`             |
| Cataclysm     | `cata`           | `Cata`              |
| Mists of Pandaria | `mop`        | `MoP`               |

### Environment Setup
```lua
-- Required globals
Is_CLI = true
Is_Create_Static = true

-- Initialize addon environment
LibQuestieDBTable = AddonInitializeVersion("Era")  -- Capitalized version
```

## Technical Details

### Data Loaders

Each data loader follows a consistent pattern:
1. **File Loading**: Loads raw `*DB.lua` files using `FindFile()`
2. **Data Execution**: Executes loaded strings to get data tables
3. **Correction Loading**: Loads static corrections with `LoadOverrideData(false, true)`
4. **Correction Merging**: Converts field names to indices and merges corrections

```lua
-- Example from item.lua
local itemOverride = loadstring(QuestieDB.itemData)()
LibQuestieDBTable.Item.LoadOverrideData(false, true)  -- static corrections only
-- Merge corrections by converting field names to numeric indices
```

### Localization Merging

The l10n system uses sophisticated merge strategies:
- **Items/Objects**: Replace empty Questie data with Mangos data
- **NPCs/Quests**: Merge missing fields from Mangos into Questie data
- **Filtering**: Only processes entities with valid IDs

### HTML Generation

The HTML generation process handles several complexities:

#### UTF-8 Safe Processing
```lua
-- Custom UTF-8 functions prevent splitting multi-byte characters
local length = #formatted_line > max_p_size and utf8_len(formatted_line) or #formatted_line
local segment = utf8_sub(formatted_line, start, stop)
```

#### String Sanitization (Two-Phase)
1. **Phase 1**: Replace special characters with safe UTF-8 equivalents
2. **Phase 2**: Convert back to proper HTML entities

```lua
-- Phase 1: Safe UTF-8 characters
str = str:gsub('&', "＆")  -- Full-width ampersand
str = str:gsub('<', "＜")  -- Full-width less-than
str = str:gsub('>', "＞")  -- Full-width greater-than

-- Phase 2: Convert to HTML entities
str = str:gsub('＆', "&amp;")
str = str:gsub('＜', "&lt;")
str = str:gsub('＞', "&gt;")
```

#### Chunking Strategy
Files are split based on:
- **IDs per file**: Default 50 entities per HTML file
- **P-tags per file**: Default 65,000 `<p>` tags maximum
- **P-tag size**: Maximum 4,000 characters per `<p>` tag

Large content is segmented:
```html
<!-- Segment markers for large content -->
<p>1</p>        <!-- Normal field -->
<p>2-1</p>      <!-- Large field, segment 1 -->
<p>2-2</p>      <!-- Large field, segment 2 -->
<p>2-e</p>      <!-- Large field, end segment -->
```

### File Organization

Each entity type generates:
- **Data files**: `_data/1.html`, `_data/2.html`, etc.
- **ID file**: `[Type]DataIds.html` - All valid entity IDs
- **Template file**: `[Type]DataTemplates.html` - References to chunk files
- **XML file**: `[Type]DataFiles.xml` - Addon SimpleHTML definitions
- **Debug file**: `[Type]Data.lua-table` - Human-readable debug format

## Error Handling

The system includes comprehensive error handling:
- **File not found**: Returns `nil` and prints error messages
- **Load failures**: Exits with error codes
- **Validation**: Checks all required locales and entity types
- **Assertions**: Validates file operations and data integrity

## Performance Considerations

- **Memory management**: Chunking prevents excessive memory usage
- **UTF-8 handling**: Prevents character corruption in international text
- **Parallel processing**: Each entity type can be processed independently
- **Incremental updates**: Only modified files are updated

## Debugging

### Debug Mode
Enable debug mode for additional output:
```lua
DumpDatabase("era", "Classic", true)  -- Enable debug
```

Debug mode adds:
- Field name comments in HTML files
- Segment markers for large content
- Detailed processing statistics

### Debug Files
`.lua-table` files contain human-readable data:
```lua
-- ItemData.lua-table example
[12345] = {
  [1] = "Item Name",
  [2] = 60,  -- Required level
  [3] = { 1, 2, 3 },  -- Array data
}
```

## Maintenance

### Adding New Entity Types
1. Create data loader in `data_loaders/`
2. Add to `entityTypes` array in `createStatic.lua`
3. Update directory creation logic
4. Add HTML generation call

### Modifying Correction Logic
Corrections are applied in data loaders:
```lua
-- Example correction merge
for key, correction in pairs(corrections) do
  local correctionIndex = meta.itemKeys[key]
  itemOverride[itemId][correctionIndex] = correction
end
```

### Localization Updates
Localization merge strategies are defined in `l10n.lua`:
```lua
local mergeFunctions = {
  ["Item"] = function(base_data, insert_data)
    -- Custom merge logic for items
  end,
}
```

## Common Issues

1. **File not found errors**: Ensure raw database files exist
2. **Memory issues**: Reduce chunk sizes for large datasets
3. **Character encoding**: UTF-8 functions handle international text
4. **Path issues**: Check directory permissions and paths
5. **Validation failures**: Ensure all required locales are present

## Output Validation

The system validates output through:
- **Self-tests**: `Meta.DumpFunctions.testDumpFunctions()`
- **File existence**: Checks all required files are generated
- **Data integrity**: Validates loaded data matches expected format
- **Statistics**: Reports generation statistics for analysis


```
QuestieDB Database Generation Flow
===================================

┌─────────────────────────────────────────────────────────────────────────────────┐
│                                INPUT SOURCES                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│  Raw Database Files:          Static Corrections:       Translation Sources:    │
│  ┌─────────────────┐          ┌──────────────────┐      ┌─────────────────┐     │
│  │ ClassicItemDB   │          │ Addon Corrections│      │ Questie L10n    │     │
│  │ ClassicNpcDB    │          │ ├─ itemFixes     │      │ Lookup Tables   │     │
│  │ ClassicObjectDB │    ───>  │ ├─ npcFixes      │ ───> │ ┌─────────────┐ │     │
│  │ ClassicQuestDB  │          │ ├─ objectFixes   │      │ │ deDE, frFR  │ │     │
│  │ (per version)   │          │ └─ questFixes    │      │ │ esES, ruRU  │ │     │
│  └─────────────────┘          └──────────────────┘      │ │ etc...      │ │     │
│                                                         │ └─────────────┘ │     │
│                                                         └─────────────────┘     │
│                                                         ┌─────────────────┐     │
│                                                         │ Mangos L10n     │     │
│                                                         │ XML Files       │     │
│                                                         │ (Gap-filling)   │     │
│                                                         └─────────────────┘     │
└─────────────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                            PROCESSING PIPELINE                                  │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐           │
│   │ createStatic.lua│────>│ Data Loaders    │───> │ L10n Processor  │           │
│   │                 │     │                 │     │                 │           │
│   │ • Phase 1:      │     │ ┌─────────────┐ │     │ ┌─────────────┐ │           │
│   │   Initialize    │     │ │ item.lua    │ │     │ │ Clean Files │ │           │
│   │   Addon Env     │     │ │ npc.lua     │ │     │ │ Load Lookup │ │           │
│   │                 │     │ │ object.lua  │ │     │ │ Tables      │ │           │
│   │ • Phase 2:      │     │ │ quest.lua   │ │     │ │ Inject      │ │           │
│   │   Validate      │     │ │ l10n.lua    │ │     │ │ Mangos Data │ │           │
│   │   Functions     │     │ └─────────────┘ │     │ │ Generate    │ │           │
│   │                 │     │                 │     │ │ Final L10n  │ │           │
│   │ • Phase 3:      │     │ Each loader:    │     │ └─────────────┘ │           │
│   │   Load Entity   │     │ 1. Load raw DB  │     │                 │           │
│   │   Data          │     │ 2. Execute data │     │ Merge Strategy: │           │
│   │                 │     │ 3. Load static  │     │ • Items/Objects:│           │
│   │ • Phase 4:      │     │    corrections  │     │   Replace empty │           │
│   │   Load L10n     │     │ 4. Merge by     │     │ • NPCs/Quests:  │           │
│   │   Data          │     │    field index  │     │   Add missing   │           │
│   │                 │     │                 │     │                 │           │
│   │ • Phase 5:      │     │ Output:         │     │ Output:         │           │
│   │   Prepare       │     │ • itemOverride  │     │ • l10nOverride  │           │
│   │   Output        │     │ • npcOverride   │     │   [id][type]    │           │
│   │                 │     │ • objectOverride│     │   [locale]      │           │
│   │ • Phase 6:      │     │ • questOverride │     │                 │           │
│   │   Generate      │     │                 │     │                 │           │
│   │   Files         │     │                 │     │                 │           │
│   └─────────────────┘     └─────────────────┘     └─────────────────┘           │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
┌─────────────────────────────────────────────────────────────────────────────────┐
│                            OUTPUT GENERATION                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────────────┐    │
│  │ dump.lua        │ ──> │ Dual Format     │ ──> │ Final Structure         │    │
│  │                 │     │ Generation      │     │                         │    │
│  │ • UTF-8 Safe    │     │                 │     │ Database/               │    │
│  │   Processing    │     │ ┌─────────────┐ │     │ ├─ Item/                │    │
│  │                 │     │ │ .lua-table  │ │     │ │  ├─ Era/              │    │
│  │ • String        │     │ │ (Debug)     │ │     │ │  │  ├─ _data/         │    │
│  │   Sanitization  │     │ │             │ │     │ │  │  │  ├─1.html       │    │
│  │   (2-phase)     │     │ │ Human-      │ │     │ │  │  │  ├─2.html       │    │
│  │                 │     │ │ readable    │ │     │ │  │  │  └─...          │    │
│  │ • Chunking      │     │ │ Lua table   │ │     │ │  │  │                 │    │
│  │   Strategy      │     │ │ format      │ │     │ │  │  ├─ ItemData       │    │
│  │                 │     │ └─────────────┘ │     │ │  │  │  Ids.html       │    │
│  │ • HTML          │     │                 │     │ │  │  ├─ ItemData       │    │
│  │   Generation    │     │ ┌─────────────┐ │     │ │  │  │  Templates.html │    │
│  │                 │     │ │ .html       │ │     │ │  │  └─ ItemData       │    │
│  │ Limits:         │     │ │ (Production)│ │     │ │  │     Files.xml      │    │
│  │ • 50 IDs/file   │     │ │             │ │     │ │  └─ Tbc/              │    │
│  │ • 65k p-tags    │     │ │ Segmented   │ │     │ ├─ Npc/                 │    │
│  │ • 4k chars/tag  │     │ │ for addon   │ │     │ ├─ Object/              │    │
│  │ • 45k file size │     │ │ consumption │ │     │ ├─ Quest/               │    │
│  │                 │     │ └─────────────┘ │     │ └─ l10n/                │    │
│  └─────────────────┘     └─────────────────┘     └─────────────────────────┘    │
│                                                                                 │
│  Generated Files Per Entity Type:                                               │
│  ┌─────────────────────────────────────────────────────────────────────────┐    │
│  │ • {Type}DataIds.html      ─ All valid entity IDs (comma-separated)      │    │
│  │ • {Type}DataTemplates.html ─ Frame names for all chunk files            │    │
│  │ • {Type}DataFiles.xml     ─ SimpleHTML definitions for addon loading    │    │
│  │ • _data/1.html, 2.html... ─ Chunked entity data with UTF-8 safety       │    │
│  │                                                                         │    │
│  │ HTML Structure Per Chunk:                                               │    │
│  │ <html><body>                                                            │    │
│  │   <p>id1,id2,id3...</p>           ← ID lookup table                     │    │
│  │   <!-- 123 -->                    ← Entity ID comment                   │    │
│  │   <p>1,2,5,7-1,7-2,7-e</p>        ← Field indices (segmented if large)  │    │
│  │   <p>field1_data</p>               ← Actual field data                  │    │
│  │   <p>field2_data</p>               ← (HTML-escaped, UTF-8 safe)         │    │
│  │   <p>field5_data_segment1</p>      ← Large fields split into segments   │    │
│  │   <p>field7_data_segment2</p>      ← (prevents memory issues)           │    │
│  │   <p>field7_data_end</p>           ← End segment marked with 'e'        │    │
│  │ </body></html>                                                          │    │
│  └─────────────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────────────┘
                                         │
                                         ▼
┌────────────────────────────────────────────────────────────────────────────────┐
│                              FINAL OUTPUT                                      │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐           │
│  │ Addon Loading   │     │ Debug/Compare   │     │ Development     │           │
│  │                 │     │                 │     │                 │           │
│  │ HTML files are  │     │ .lua-table      │     │ Maintainers can │           │
│  │ loaded by       │     │ files allow     │     │ easily verify   │           │
│  │ QuestieDB addon │     │ developers to   │     │ data integrity  │           │
│  │ via SimpleHTML  │     │ inspect the     │     │ and debug       │           │
│  │ frames          │     │ processed data  │     │ issues          │           │
│  │                 │     │ in readable     │     │                 │           │
│  │ Memory efficient│     │ format          │     │ Clear separation│           │
│  │ chunked loading │     │                 │     │ of data and     │           │
│  │ prevents game   │     │ Version control │     │ presentation    │           │
│  │ freezing        │     │ friendly        │     │ layers          │           │
│  └─────────────────┘     └─────────────────┘     └─────────────────┘           │
└────────────────────────────────────────────────────────────────────────────────┘

Key Technical Features:
═══════════════════════
• UTF-8 Safe String Processing
• Two-Phase HTML Entity Escaping
• Intelligent Data Chunking
• Memory-Efficient Loading
• Dual Output Format Strategy
• Comprehensive Error Handling
• Deterministic Processing Order
```