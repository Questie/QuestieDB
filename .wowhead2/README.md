# Local Wowhead Database Cache

This directory contains a set of Python scripts designed to create and manage a local, version-aware cache of [Wowhead](https://www.wowhead.com) pages, optimized for high-performance, concurrent data fetching.

## What is this?

The core purpose of this toolset is to programmatically download and store raw HTML and tooltip data from Wowhead for various game entities (quests, items, NPCs, etc.) across different game expansions (Classic, TBC, WotLK, etc.). The data is stored in a local SQLite database, preserving the specific version and locale it was fetched for.

## Why does this exist?

Building a local cache serves several key purposes for a project like Questie:

1.  **Offline Data & Performance**: It provides fast, local access to vast amounts of game data without needing to crawl Wowhead every time information is required.
2.  **Version Differencing**: By storing pages per-expansion, we can programmatically compare entities to see how they changed over time. For example, we can diff a quest's text between its Classic, TBC, and WotLK versions.
3.  **Reliable Data Extraction**: It creates a stable, offline dataset from which multilingual text and other game data can be reliably parsed and extracted for the addon.
4.  **Historical Archiving**: It builds a historical snapshot of game data, insulating the project from changes or removals on the live Wowhead site.

## Key Features

-   **Version-aware Caching**: Stores data for each game expansion (`Classic`, `TBC`, `WotLK`, `Cata`, `MoP Classic`), with intelligent fallback logic to find the most recent available data.
-   **Delta Calculation**: Can identify and fetch only the entities that were added or changed between two game versions, saving significant time and bandwidth.
-   **HTML & Tooltip Fetching**: Intelligently decides whether to fetch a full HTML page or a lightweight tooltip based on the entity type (e.g., full pages for quests, tooltips for items and NPCs) to minimize data storage.
-   **High-Performance Concurrent Fetching**: Utilizes a thread pool and a high-throughput proxy manager (`proxy_fast.py`) to fetch hundreds of pages per second.
-   **Web-based Monitoring & Control**: A built-in web server (`fetcher_controller.py`) provides a UI to monitor fetching progress in real-time, view the operations queue, and gracefully stop the process.
-   **Type-Safe Design**: Employs modern Python typing (`sitemap_types.py`) to ensure data consistency and prevent common errors.

## How it Works (Component Overview)

The system is composed of several focused Python scripts:

-   **`main.py` (Entry Point)**: The primary script to run the application. It defines the sequence of fetching operations (e.g., fetch all WotLK quests for all locales), starts the `WowheadFetcher`, and launches the web-based `FetcherControlServer`.

-   **`sitemap_types.py` (Core Data Structures)**: The foundation of the system. It contains all the type definitions, `Enum`s (like `VersionSlug`, `Locale`), and immutable data classes (like `WowheadEntity`). This separation ensures that the core data structures are consistent and reusable. A key type is `EntityDataType`, which specifies whether to fetch `full` HTML or just a `tooltip`.

-   **`wowhead_mappings.py` (URL Logic)**: Centralizes all logic for parsing and generating Wowhead URLs. It handles the complexity of converting between a raw URL string and a structured `WowheadEntity` object and determines the appropriate `EntityDataType` for each entity.

-   **`sitemap_processor.py` (Discovery Engine)**: The discovery and comparison engine. It connects to Wowhead, parses its `sitemap.xml` files, and uses `wowhead_mappings.py` to transform URLs into `WowheadEntity` objects. Its key function is to calculate the "delta" between two game versions.

-   **`sitemap_filters.py` (Data Filtering)**: Provides functions to clean up the list of entities before fetching. It can filter out deprecated/unused entities and, for certain locales, remove entries that do not contain the expected language-specific characters.

-   **`wowhead_db.py` (Database Storage)**: Manages the `wowhead.db` SQLite database. The schema is designed to store both `raw_html_data` and `raw_tooltip_data` per entity, version, and locale. Its key feature is the **version fallback logic**: if you request a page for a specific version (e.g., WotLK) and it doesn't exist, the database can automatically find the newest available version that *does* exist (e.g., falling back to the TBC version).

-   **`proxy_fast.py` (Proxy Management)**: A high-performance, non-blocking proxy manager designed for maximum throughput. It uses an in-memory circular buffer to rotate through a list of proxies, minimizing contention and maximizing requests per second.

-   **`wowhead_fetcher.py` (The Orchestrator)**: This is the core worker. It takes a list of entities, filters out those that already exist in the database, and then uses a `ThreadPoolExecutor` and `FastProxyManager` to execute concurrent fetches. It handles graceful shutdowns and updates the monitoring UI with progress.

-   **`fetcher_controller.py` (Web Controller)**: Runs a simple `HTTPServer` in a separate thread to provide a web interface for monitoring and controlling the fetcher. It allows you to see the current progress, the queue of operations, and to stop the fetcher gracefully.

## Data Flow

1.  **Configure**: The `main.py` script defines a list of fetch operations (version, entity type, locale).
2.  **Discover**: For each operation, `sitemap_processor.py` generates a list of `WowheadEntity` objects from Wowhead's sitemaps. This can be a full list or a delta compared to a previous version.
3.  **Filter**: The list of entities is passed through `sitemap_filters.py` to remove junk data (e.g., unused or placeholder entities).
4.  **Check Cache**: `wowhead_fetcher.py` checks the `wowhead.db` and removes any entities that have already been successfully downloaded.
5.  **Fetch**: The fetcher uses a `ThreadPoolExecutor` to concurrently download the remaining entities. `proxy_fast.py` provides a different proxy for each request to maximize speed and avoid rate limits.
6.  **Store**: The fetched HTML or tooltip data is passed to `wowhead_db.py`, which saves it into the `wowhead_data` table, tagged with its entity ID, type, version, and locale.
7.  **Monitor & Control**: Throughout the process, the `fetcher_controller.py` web server runs, allowing the user to monitor progress and stop the operation via a web browser.

## Usage

### 1. Setup

Proxy credentials are required for high-volume fetching. Create a `.env` file in the root directory with your proxy information:

```
PROXY_USERNAME=your_username
PROXY_PASSWORD=your_password
PROXY_HOST=your_proxy_host
```

### 2. Running the Fetcher

The primary entry point is `main.py`. You can configure the desired operations directly within this file.

To start the process, run:

```bash
python main.py
```

### 3. Monitoring

Once running, you can monitor the fetcher's progress by opening the web controller in your browser:

[http://localhost:8000](http://localhost:8000)

The web interface displays the current operation, progress statistics, the queue of upcoming operations, and a "Stop Fetcher" button to gracefully shut down the process.
