# Local Wowhead Database Cache

This directory contains a set of Python scripts designed to create and manage a local, version-aware cache of [Wowhead](https://www.wowhead.com) pages.

## What is this?

The core purpose of this toolset is to programmatically download and store raw HTML from Wowhead for various game entities (quests, items, NPCs, etc.) across different game expansions (Classic, TBC, WotLK, etc.). The data is stored in a local SQLite database, preserving the specific version and locale it was fetched for.

## Why does this exist?

Building a local cache serves several key purposes for a project like Questie:

1.  **Offline Data & Performance**: It provides fast, local access to vast amounts of game data without needing to crawl Wowhead every time information is required.
2.  **Version Differencing**: By storing pages per-expansion, we can programmatically compare entities to see how they changed over time. For example, we can diff a quest's text between its Classic, TBC, and WotLK versions.
3.  **Reliable Data Extraction**: It creates a stable, offline dataset from which multilingual text and other game data can be reliably parsed and extracted for the addon.
4.  **Historical Archiving**: It builds a historical snapshot of game data, insulating the project from changes or removals on the live Wowhead site.

## Key Concepts

The system is built around a few core, type-safe concepts to ensure data consistency and prevent common errors:

-   **`WowheadEntity`**: A structured, immutable object representing a single Wowhead entry (e.g., a specific quest in a specific version and language).
-   **`VersionSlug`**: An `Enum` that defines the supported game expansions (`CLASSIC`, `TBC`, `WOTLK`, etc.) in their chronological order.
-   **`EntityType`**: A `Literal` type that restricts entity types to a known list (`quest`, `item`, `npc`, etc.).
-   **`Locale`**: An `Enum` for all supported Wowhead languages.
-   **Protocols (`SitemapFetcher`, `DeltaExporter`)**: Abstract base classes that define contracts for fetching and exporting data, allowing for dependency injection and easier testing.

## How does it work?

The system is composed of several focused Python scripts:

-   **`sitemap_types.py`**: The foundation of the system. It contains all the type definitions, `Enum`s (like `VersionSlug`, `Locale`), and immutable data classes (like `WowheadEntity`, `DeltaResult`). This separation ensures that the core data structures are consistent and reusable across the entire application.

-   **`wowhead_mappings.py`**: This module centralizes all logic for parsing and generating Wowhead URLs. It handles the complexity of converting between a raw URL string and a structured `WowheadEntity` object, including detecting the version, locale, entity type, and ID.

-   **`sitemap_processor.py`**: This is the discovery and comparison engine. It connects to Wowhead, parses its `sitemap.xml` files, and uses `wowhead_mappings.py` to transform URLs into `WowheadEntity` objects. Its key function is to calculate the "delta" between two game versions, identifying which entities were added or removed.

-   **`wowhead_db.py`**: This script is the heart of the storage system. It manages the `wowhead.sqlite` database file, including:
    -   Creating the necessary tables (`versions`, `wowhead_data`).
    -   Seeding the database with game version information.
    -   Inserting and retrieving page data.
    -   A key feature is its **version fallback logic**. If you request a page for a specific version (e.g., WotLK) and it doesn't exist, the database can automatically find the newest available version that *does* exist (e.g., falling back to the TBC version).

-   **`wowhead_fetcher.py`**: This is the orchestrator. It uses the sitemap processor to get a list of entities to fetch and then uses `wowhead_db.py` to store the downloaded HTML. It manages network requests, including setting a proper User-Agent, handling retries, and respecting rate limits to ensure robust fetching.

### Data Flow

1.  **Discover**: `sitemap_processor.py` generates a list of `WowheadEntity` objects for a target version (e.g., all WotLK quests). This can be a full list or a delta compared to a previous version.
2.  **Fetch**: `wowhead_fetcher.py` iterates through the list, generates a URL for each entity, and downloads the raw HTML.
3.  **Store**: The fetched HTML is passed to `wowhead_db.py`, which saves it into the `wowhead_data` table, tagged with its entity ID, type, version, and locale.

## Usage

The primary entry point for fetching data is the `wowhead_fetcher.py` script. It can be run directly to demonstrate its functionality.

To perform a full fetch for a specific version and entity type, you would use the `WowheadFetcher` class and call one of its methods, such as:

-   `fetch_version_entities(version, entity_type)`: Fetches all entities for a given version.
-   `fetch_delta_entities(target_version, entity_type)`: Fetches only the entities that were added in the target version.
-   `fetch_specific_ids(version, entity_type, id_list)`: Fetches a specific list of entity IDs.

The script will create a `wowhead.sqlite` file in the same directory, which can then be used for data extraction and analysis.