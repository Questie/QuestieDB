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

## How does it work?

The system is composed of three main Python scripts:

-   **`sitemap.py`**: This is the discovery mechanism. It connects to Wowhead and parses its `sitemap.xml` files to find all the unique URLs for a given entity type (e.g., `quest`) and game version (e.g., `wotlk`). It can also be used to calculate the "delta" between two versions, identifying which pages were added or removed.

-   **`wowhead_db.py`**: This script is the heart of the storage system. It manages the `wowhead.sqlite` database file, including:
    -   Creating the necessary tables (`versions`, `translations`).
    -   Seeding the database with game version information (e.g., adding 'Classic', 'TBC', 'WotLK' with a specific order).
    -   Inserting and retrieving page data.
    -   A key feature is its **version fallback logic**. If you request a page for a specific version (e.g., WotLK) and it doesn't exist, the database can automatically find the newest available version that *does* exist (e.g., falling back to the TBC version).

-   **`wowhead_fetcher.py`**: This is the orchestrator. It uses `sitemap.py` to get a list of URLs to fetch and then uses `wowhead_db.py` to store the downloaded HTML. It manages the network requests, including setting a proper User-Agent and handling retries to ensure robust fetching.

### Data Flow

1.  **Discover**: `sitemap.py` generates a list of URLs for a target version (e.g., all WotLK quests).
2.  **Fetch**: `wowhead_fetcher.py` iterates through the list, downloads the raw HTML for each URL.
3.  **Store**: The fetched HTML is passed to `wowhead_db.py`, which saves it into the `translations` table, tagged with its canonical URL, version, and locale.
