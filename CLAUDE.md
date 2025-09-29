# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

QuestieDB is a World of Warcraft Classic addon database library that provides comprehensive game data (Quests, Items, NPCs, Objects, and Localization) for the Questie addon. It's designed as a library addon that can be embedded in other projects or run standalone.

## Architecture

### Core Components

- **Database/**: Core database system with on-demand data loading using WoW's SimpleHTML frames
  - Uses binary search for efficient data retrieval from sparse datasets
  - Data is organized by expansion (Era, TBC, Wotlk, Cata, Mop)
  - Each data type (Quest, Item, Npc, Object, l10n) has its own module structure

- **Corrections/**: Override system for modifying/extending generated data
  - Static corrections: Applied at compile/build time
  - Dynamic corrections: Applied at runtime for faction-specific data
  - Organized by expansion with load order priority system

- **Meta/**: Defines data structure and dump functions for each data type
  - Contains metadata definitions and processing functions
  - Handles data conversion between formats

### Data Loading System

The addon uses a unique approach with WoW's SimpleHTML frames:
- Data files are HTML with `<p>` tags containing game data
- On-demand loading reduces memory usage and startup time
- Binary search through file ranges for efficient data access
- Data is cached once loaded to avoid re-processing

### File Structure

- **Generated Data**: `Database/<Type>/<Expansion>/` contains auto-generated data files
- **Corrections**: `Corrections/<Expansion>/` contains manual fixes and overrides
- **CLI Tools**: `cli/` contains command-line interface for development/testing

## Development Commands

### Build System
```bash
# Build the addon for distribution
python build.py build

# Get version information
python build.py version
```

### Python Linting
```bash
# Format and lint Python code
ruff format
ruff check
```

### Testing
```bash
# In-game slash commands for testing
/qdb test    # Run all data tests
/qdb ui      # Open settings UI
```

### Database Generation
The database generation system converts raw game data into the HTML format used by the addon. For detailed information, see [`.database_generator/CLAUDE.md`](.database_generator/CLAUDE.md).

```bash
# Run database generation (from .database_generator/)
docker-compose up
```

## Code Patterns

### Data Access Pattern
All data access follows this pattern:
1. Get data function from module (e.g., `Quest.Get(questId)`)
2. Binary search finds correct data file
3. Load file on-demand if not cached
4. Apply corrections/overrides
5. Return processed data

### Corrections System
When adding corrections:
1. Use appropriate expansion folder in `Corrections/`
2. Register with `Corrections.RegisterCorrectionStatic()` or `Corrections.RegisterCorrectionDynamic()`
3. Follow the load order system (base orders defined in Corrections.lua:14-26)

### Module Structure
Each data type follows this structure:
- `<Type>.lua`: Main module with Get/Set functions
- `<Type>Meta.lua`: Data structure definitions
- `<Expansion>/<Type>Fixes.lua`: Expansion-specific corrections

## Coding Standards

### Lua Development Guidelines

#### File Naming Conventions
- Use CamelCase for Lua files
- Name Lua test files as `<name>.test.lua`
- Name LuaLS type files as `<name>.t.lua`

#### Type Annotations
- Always use LuaLS annotations for Lua files
- Favor project-specific types over primitives
- Use `---@` prefix for all type annotations
- Optional types should use `string?` syntax, not `string | nil`

#### Code Style
- Use descriptive variable names; avoid single-letter names except for loop counters
- Use consistent indentation (2 spaces) and line breaks
- Use comments to explain complex logic or important decisions
- Follow the project's existing coding patterns

#### Key Project Types
- `QuestId`, `ItemId`, `NpcId`, `ObjectId` for entity identifiers
- `ExpansionStrings`: `"Era"|"Tbc"|"Wotlk"|"Cata"|"MoP"`
- `StartedBy`, `FinishedBy` for quest relationships
- `Objective` types for quest requirements
- `CorrectionObject` for data override system

### TOC File Guidelines
- Use `## Interface:` with comma-separated versions for multi-client support
- Always include proper metadata (`Title`, `Author`, `Version`, `Notes`)
- Use `## Category:` for grouping in Cata Classic+
- File paths in TOC should use backslashes (`\`)
- Comments in TOC files must start with `#` at beginning of line

## Important Notes

- Debug mode can be enabled via `Database.debugEnabled = true`
- The CLI mode (`Is_CLI`) provides additional debugging capabilities
- All data is stored as strings and converted at runtime using `loadstring()` or `tonumber()`
- The system supports multiple WoW expansions with separate data sets
- Performance is critical - data loading uses optimized binary search and caching

## Expansion Support

The addon supports multiple WoW expansions:
- **Era**: Classic WoW
- **SoD**: Season of Discovery
- **TBC**: The Burning Crusade
- **Wotlk**: Wrath of the Lich King
- **Cata**: Cataclysm
- **Mop**: Mists of Pandaria

Each expansion has its own data files and correction system with proper load ordering.

## Tooling Systems

The project includes several specialized tooling systems for data management and processing:

### Wowhead Scraper System

A sophisticated Python-based system for creating and managing a local cache of Wowhead data across different game expansions and locales. For detailed documentation, see [`.tooling/wowhead/CLAUDE.md`](.tooling/wowhead/CLAUDE.md).

### Database Generator System
A Lua-based system that converts raw game data and corrections into the HTML format consumed by the QuestieDB addon. For detailed documentation, see [`.database_generator/CLAUDE.md`](.database_generator/CLAUDE.md).

## Git Commit Guidelines

When committing changes to the repository, please follow these guidelines:

Generate a commit message for the staged changes.
The commit message should be structured with one change per line if multiple distinct logical changes are present.

For EACH distinct logical change identified in the staged files, create a new line in the commit message.
Each line MUST follow this format: `[category_tag] PastTenseVerb Concise description of that specific change.`

Available category tags and their purpose:
*   `[feature]` - New user-facing features or significant enhancements.
*   `[generator]` - Changes to the generator
*   `[fix]` - General user-facing bug fixes not specific to other categories.
*   `[quest]` - Quest additions, fixes, objective updates, pre-req changes.
*   `[db]` - Database changes (items, NPCs, spawns, map data, game objects).
*   `[locale]` - Localization or translation updates.
*   `[perf]` - Changes improving performance, speed, or resource usage.
*   `[ui]` - Changes to user interface elements or user experience.
*   `[refactor]` - Internal code restructuring or improvements without changing external user-facing behavior.
*   `[tooling]` - Additions or Updates to developer tools, scripts, or internal utilities.
*   `[maint]` - Routine maintenance, code cleanup, comment updates, typo fixes in code/comments, or other small internal improvements.
*   `[toc]` - Updates to the toc file, for example addition, removal of files or creation/rename/delete of .toc file


The description for each line MUST start with a verb in PAST TENSE (e.g., Added, Fixed, Updated, Improved, Removed, Changed, Marked, Implemented, Corrected, Optimized, Refactored, Enhanced, Cleaned, Clarified).
Be specific for each line. If it's a quest, mention the quest name. If it's an item/NPC, mention it.

Example of a multi-line commit message (each line is part of the same commit):
[quest] Fixed pre-quests for Golden Lotus quests in VoEB
[db] Greatly improved friendlyToFaction for MoP NPCs
[refactor] Simplified NPC data retrieval logic
[tooling] Added _dotenv.lua for environment variable management

Another example:
[feature] Implemented the new "Pet Journal" search functionality
[ui] Adjusted padding on the Pet Journal entries for better readability
[maint] Removed unused import from PetJournal.lua
[toc] Updated .toc files to load _dotenv.lua for environment settings

If there's only one logical change, provide a single-line commit message as before (e.g., `[fix] Corrected a minor display issue`).

Focus on WHAT was changed for each line, ensuring the description starts with a past tense verb.

NEVER include "Generated with [Claude Code](https://claude.ai/code)" or "Co-Authored-By: Claude <noreply@anthropic.com>" in the commit message.