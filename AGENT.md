# QuestieDB Agent Guide

## Build/Test Commands
- **Build**: `python build.py` (creates a zip distribution in `.build/`, does not do any checks)
- **Tests**: `lua .tooling/lua/tests/runTests.lua <Era|Sod|Tbc|Wotlk|Cata|Mop|All>` (requires Docker or native Lua)
- **Format Lua**: Uses StyLua with config in `.stylua.toml`
- **Format Python**: Uses Ruff with config in `ruff.toml`
- **Typecheck**: None configured (Lua project with Python build tools)

## Database Generation
- **Generate**: folder `.database_generator` run generate_database.sh to regenerate the database.

## Architecture
- **Core**: WoW addon database using SimpleHTML storage for on-demand loading
- **Database/**: Entity data (Quest/Item/Npc/Object/l10n) organized by ID ranges, supports Era/Sod/Tbc/Wotlk/Cata/Mop expansions
- **Meta/**: Data structure definitions (*Meta.lua files) and dump functions
- **Corrections/**: Runtime data fixes organized by expansion, registered via Corrections.lua
- **Helpers/**: Utilities (events, threading, version checking, debug)
- **Translations/**: Multi-language support with locale extraction from semicolon-delimited strings, used for bespoke strings that arn't Quest/item/Npc/Object.
- **Library.lua**: Main public API, CLI tools in cli/

## Code Style
- **Lua**: 2 spaces, 160 column width, double quotes preferred, no call parentheses (StyLua)
- **Python**: 2 spaces, 200 line length, double quotes, space indents (Ruff)
- **Naming**: PascalCase for modules/classes, camelCase for functions, snake_case for local vars
- **Comments**: Use `---@` for type annotations, `--!` for important notes, `--?` for explanations
- **Imports**: Group by type (local vars, then requires), use absolute paths when possible
