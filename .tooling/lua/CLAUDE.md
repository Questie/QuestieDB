# Lua Tooling Directory

This directory contains Lua-based development tools for QuestieDB development and testing.

## Directory Structure

- **`cli/`**: Command-line interface tools for development
- **`libs/`**: Shared Lua libraries and utilities  
- **`tests/`**: Test suites and testing frameworks

## Lua Development Guidelines

### File Naming Conventions
- Use CamelCase for Lua files
- Name Lua test files as `<name>.test.lua`
- Name LuaLS type files as `<name>.t.lua`

### Type Annotations
- Always use LuaLS annotations for Lua files
- Favor project-specific types over primitives
- Use `---@` prefix for all type annotations
- Optional types should use `string?` syntax, not `string | nil`

### Code Style
- Use descriptive variable names; avoid single-letter names except for loop counters
- Use consistent indentation (2 spaces) and line breaks
- Use comments to explain complex logic or important decisions
- Follow the project's existing coding patterns

### Key Project Types
- `QuestId`, `ItemId`, `NpcId`, `ObjectId` for entity identifiers
- `ExpansionStrings`: `"Era"|"Tbc"|"Wotlk"|"Cata"|"MoP"`
- `StartedBy`, `FinishedBy` for quest relationships
- `Objective` types for quest requirements
- `CorrectionObject` for data override system

### CLI Environment
- Uses `Is_CLI` flag to simulate addon environment outside WoW
- Provides access to addon APIs and data structures
- Enables testing and development without game client
- Supports debug mode for additional logging and validation

### Testing Patterns
- Write unit tests for data processing functions
- Test edge cases and error conditions
- Mock WoW API calls when testing outside game environment
- Validate data integrity and type correctness