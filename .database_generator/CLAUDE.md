# Database Generator System

Located in `.database_generator/`, this Lua-based system converts raw game data and corrections into the HTML format consumed by the QuestieDB addon.

## Purpose
- Compiles raw database files with static corrections
- Generates HTML files for WoW's SimpleHTML frame system
- Creates multi-lingual translation data
- Produces addon-ready database files for each expansion

## Architecture

### Core Components
- **`main.lua`**: Entry point that orchestrates the entire compilation process
- **`createStatic.lua`**: Main compilation function that processes all entity types
- **`dump.lua`**: HTML generation engine with UTF-8 safe string processing
- **`data_loaders/`**: Individual loaders for each entity type (quest, item, npc, object, l10n)
- **`db_helpers.lua`**: Utility functions for file operations and data manipulation

### Compilation Process
1. **Environment Setup**: Initialize addon environment for target expansion
2. **Database Loading**: Load raw data files and apply static corrections
3. **Data Merging**: Combine base data with correction overrides
4. **Localization**: Merge translation data from multiple sources
5. **HTML Generation**: Convert processed data to HTML format
6. **File Output**: Create all necessary files for addon consumption

## HTML Generation System

The core of the system is the HTML generation in `dump.lua`:

### Key Features
- **UTF-8 Safe Processing**: Handles multi-byte characters (Chinese, Korean, etc.) correctly
- **String Chunking**: Splits large content across multiple `<p>` tags to respect WoW client limits
- **HTML Sanitization**: Converts special characters to safe HTML entities
- **File Chunking**: Splits entity data across multiple files (default: 50 IDs per file)

### Generated Files Structure
For each entity type and expansion, generates:

1. **Data Files** (`_data/*.html`): Actual entity data split into chunks
   - Format: `<p>id1,id2,id3</p>` (ID index) followed by data `<p>` tags
   - Each file contains up to 50 entities to optimize loading performance

2. **ID Files** (`<Type>DataIds.html`): Complete list of valid entity IDs
   - Contains comma-separated lists of all available entity IDs
   - Used by addon to validate data existence

3. **Template Files** (`<Type>DataTemplates.html`): File range mappings  
   - Lists all data file names and their ID ranges
   - Enables binary search for efficient data file location

4. **XML Files** (`<Type>DataFiles.xml`): WoW UI frame definitions
   - Defines SimpleHTML frames pointing to generated HTML files
   - Required for WoW addon system to load the data

### String Processing Pipeline
1. **Dump Function Application**: Convert Lua data to string representation
2. **UTF-8 Sanitization**: Replace special characters with safe equivalents
3. **Chunking**: Split oversized content across multiple `<p>` tags  
4. **HTML Entity Conversion**: Convert safe characters to proper HTML entities
5. **File Writing**: Output to structured HTML files

## Usage

### Running Database Generation
```bash
cd .database_generator
./generate_database.sh [lua_executable]
```

This will:
1. Set up the environment and dependencies
2. Run `main.lua` to compile all expansions
3. Generate HTML files in `Database/<Type>/<Expansion>/`

### Key Constraints
- **WoW Client Limits**: Max 4000 chars per `<p>` tag, 45000 chars per HTML file
- **Performance Limits**: Max ~50 IDs per file to prevent exponential load time increase
- **UTF-8 Safety**: All string operations must respect multi-byte character boundaries

## Development Notes
- Uses CLI environment simulation to load addon code outside WoW
- Applies only static corrections during generation (dynamic corrections applied at runtime)  
- Supports debug mode for additional HTML comments and profiling
- Handles translation merging from both Questie data and Mangos translation databases
- All file paths use absolute references for cross-platform compatibility