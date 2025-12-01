# Tooling Directory

This directory contains development tools and utilities for the QuestieDB project.

## Directory Structure

- **`wowhead/`**: Wowhead scraper system for caching game data
- **`lua/`**: Lua tooling including CLI, libraries, and tests
- **`deprecated_tools/`**: Legacy tooling kept for reference

## Python Development Guidelines

### Code Style
- Follow Python PEP 8 conventions
- Use type hints for all function parameters and return values
- Use dataclasses for structured data
- Prefer tuple types over lists for immutable data

### Linting and Formatting
```bash
# Format and lint Python code
ruff format
ruff check
```

### Type Safety
- Use `typing.NewType` for domain-specific types (e.g., `EntityId`, `VersionSlug`)
- Leverage enum classes for constrained values
- Use Protocol classes for duck typing interfaces
- Favor composition over inheritance

### Error Handling
- Use specific exception types rather than generic `Exception`
- Implement graceful degradation for network operations
- Log errors with appropriate context and severity levels

### Testing
- Write unit tests for filter functions and data processing logic
- Use pytest for test framework
- Mock external dependencies (database, network calls)
- Test edge cases and error conditions

### Documentation
- Use docstrings for all public functions and classes
- Include type information in docstring parameters
- Document complex algorithms and business logic
- Keep README files updated for each subdirectory