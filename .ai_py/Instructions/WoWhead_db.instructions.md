---
applyTo: '**/.wowhead2/*.py'
---

### Your Mission (1 minute elevator pitch)

> **Build a local, version‑aware cache of Wowhead pages optimized for high-performance, concurrent data fetching. Enable programmatic downloading and storage of raw HTML and tooltip data from Wowhead for various game entities across different game expansions, with multilingual support and intelligent fallback logic.**
> *Drive the crawl with sitemap‑delta analysis; store raw HTML and tooltips separately, parse later, and serve translation look‑ups with graceful fallback. Monitor and control fetching through a web interface while achieving hundreds of pages per second throughput.*

---

### Architecture & Data‑flow

1.  **Type System** (`sitemap_types.py`):
    The foundation of the system, providing modern Python type definitions with strong typing and immutable data structures.
    -   `VersionSlug` enum with chronological ordering (`RETAIL`, `CLASSIC`, `TBC`, `WOTLK`, `CATA`, `MOP_CLASSIC`).
    -   `Locale` enum for 11 supported Wowhead languages (`enUS`, `deDE`, `frFR`, `esES`, `esMX`, `itIT`, `ptBR`, `ruRU`, `koKR`, `zhCN`, `zhTW`).
    -   Strong type aliases like `EntityId`, `EntityType`, and `EntityDataType`.
    -   Immutable dataclasses like `WowheadEntity` with URL generation capabilities.
    -   `EntityDataType` distinguishes between `"tooltip"` and `"full"` HTML fetching strategies.

2.  **URL & Type Mappings** (`wowhead_mappings.py`):
    Centralizes all logic for parsing Wowhead URLs into structured `WowheadEntity` objects and vice-versa. Handles locale-specific URL segments and determines appropriate `EntityDataType` for each entity type.

3.  **Sitemap Processor** (`sitemap_processor.py`):
    The discovery and comparison engine. It fetches and parses Wowhead's sitemaps to generate lists of `WowheadEntity` objects. Features:
    -   Delta calculation between game versions to find added/removed entities
    -   `RequestsSitemapFetcher` implementation for concrete sitemap fetching
    -   Entity discovery for specific versions, types, and locales

4.  **Data Filtering** (`sitemap_filters.py`):
    Provides functions to clean up entity lists before fetching:
    -   `filter_unused_entities()`: Removes deprecated, NYI, placeholder, and unused entities
    -   `filter_entities_without_scripts()`: Filters entities by script presence for specific locales
    -   Includes helper functions for script detection (`sitemap_helpers.py`)

5.  **High-Performance Proxy Manager** (`proxy_fast.py`):
    Optimized for maximum throughput using in-memory circular buffers:
    -   `FastProxyManager` with configurable rate limiting (default 0.5s per proxy)
    -   Support for 32 proxy ports (26 US + 6 German)
    -   Non-blocking proxy rotation with minimal contention
    -   Theoretical maximum of ~64 req/s with proper proxy configuration

6.  **SQLite Store** (`wowhead_db.py`):
    Manages the `wowhead.db` database with performance optimizations (WAL mode, 256MB cache, memory mapping).

    | Table          | Key                                              | Purpose                                                              |
    | -------------- | ------------------------------------------------ | -------------------------------------------------------------------- |
    | `versions`     | `version_id PK, slug UNIQUE, order_idx UNIQUE`   | Defines game expansions and their chronological order for fallbacks. |
    | `wowhead_data` | **`PRIMARY KEY(version_slug, locale, entity_type, entity_id)`** | Stores raw HTML/tooltip data per entity, version, and locale with separate columns for both data types. |

7.  **Concurrent Fetcher** (`wowhead_fetcher.py`):
    The core orchestrator featuring:
    -   `ThreadPoolExecutor` with configurable worker count (default 128)
    -   Integration with `FastProxyManager` for high-throughput fetching
    -   Graceful shutdown support with stop events
    -   Progress monitoring and statistics tracking
    -   Automatic database filtering to avoid re-fetching existing entities
    -   Support for both HTML and tooltip data fetching

8.  **Web-based Controller** (`fetcher_controller.py`):
    HTTP server for monitoring and control:
    -   Real-time progress monitoring with configurable refresh rates
    -   Operations queue visualization
    -   Graceful stop functionality via web interface
    -   Runs on port 8000 by default

---

### Key Design Decisions

| Topic                              | Final Choice                                                                          | Why                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Primary key includes `version`** | ✔️ yes                                                                                | Keeps historical text, enables diffing, and still allows fallback query via `order_idx`. |
| **Entity Identification**          | Composite key of `(version_slug, locale, entity_type, entity_id)`.                    | Uniquely identifies an entity at a specific point in time and language.                  |
| **Fallback query**                 | Single SQL: `ORDER BY v.order_idx DESC LIMIT 1` to pick latest ≤ target.              | Graceful degradation when exact version unavailable.                                     |
| **Raw vs. parsed**                 | Store raw HTML/tooltip data first; run parsers later.                                 | Flexibility for different parsers and future schema changes.                             |
| **Type safety**                    | Strong typing with enums and immutable dataclasses.                                   | Prevents bugs and improves maintainability.                                              |
| **Concurrency**                    | `PRAGMA journal_mode=WAL;` + `ThreadPoolExecutor` with 128 workers.                   | Production-ready concurrent access with high throughput.                                 |
| **Data storage strategy**          | Separate columns for `raw_html_data` and `raw_tooltip_data`.                          | Supports both full pages and lightweight tooltips based on entity type.                 |
| **Proxy management**               | In-memory circular buffer with `FastProxyManager`.                                    | Maximizes throughput while minimizing contention and database overhead.                  |
| **Monitoring approach**            | Web-based controller with real-time progress tracking.                                | Non-blocking monitoring without interfering with fetch performance.                      |
| **Filtering strategy**             | Multi-stage filtering: unused entities, script validation for specific locales.       | Reduces storage and network overhead by avoiding unnecessary data.                        |

---

### Component Details

#### Entry Point & Orchestration

*   **`main.py`**: Defines fetch operations for all versions, entity types, and locales. Integrates `WowheadFetcher` with `FetcherControlServer` for monitored execution.

#### Data Flow & Processing

1.  **Discovery**: `sitemap_processor.py` fetches Wowhead sitemaps and converts URLs to `WowheadEntity` objects
2.  **Filtering**: `sitemap_filters.py` removes deprecated, unused, and invalid entities
3.  **Caching Check**: `wowhead_fetcher.py` queries database to avoid re-fetching existing data
4.  **Concurrent Fetching**: `ThreadPoolExecutor` with `FastProxyManager` downloads data at scale
5.  **Storage**: Raw HTML/tooltip data stored in SQLite with version and locale metadata
6.  **Monitoring**: Real-time progress via web interface at `http://localhost:8000`

#### Performance Optimizations

*   **Proxy Rotation**: 32 concurrent proxy endpoints with 0.5s rate limiting
*   **Database Tuning**: WAL mode, 256MB cache, memory mapping for 2GB files
*   **Worker Threading**: 128 concurrent workers for maximum throughput
*   **Smart Data Types**: Tooltips for items/NPCs, full HTML for quests/objects
*   **Filtering**: Pre-fetch filtering reduces unnecessary network requests

---

### Deliverables

*   **`main.py`**: Application entry point with operation configuration.
    *   Defines comprehensive fetch operations for all expansions and locales.
    *   Integrates fetcher with web-based controller for monitoring.

*   **`wowhead_db.py`**: Core SQLite database layer with enhanced schema.
    *   `create_db(path)`: Builds/updates schema with performance optimizations.
    *   `add_version(conn, slug, order_idx)`: Idempotent expansion seeding.
    *   `insert_raw_data_html(conn, entity, data)`: UPSERTs raw HTML for a `WowheadEntity`.
    *   `insert_raw_data_tooltip(conn, entity, data)`: UPSERTs raw tooltip data for a `WowheadEntity`.
    *   `get_raw_data_html(conn, entity)`: Fallback lookup returning `(data, version_used)`.
    *   `get_raw_data_tooltip(conn, entity)`: Fallback lookup for tooltip data.
    *   `entity_exists(conn, entity)`: Check if entity data already exists to avoid re-fetching.

*   **`sitemap_processor.py`**: Enhanced sitemap analysis with delta calculation.
    *   `calculate_version_delta(target_version, entity_type, fetcher, locale)`: Calculates version deltas.
    *   `get_entities(version, entity_type, fetcher, locale)`: Fetches all entities for specific criteria.
    *   `RequestsSitemapFetcher`: Concrete `SitemapFetcher` implementation using `requests`.

*   **`sitemap_types.py`**: Comprehensive type system with 11 locale support.
    *   Enhanced `VersionSlug` enum including `RETAIL`, `CATA`, and `MOP_CLASSIC`.
    *   Complete `Locale` enum with all supported Wowhead languages.
    *   `EntityDataType` for fetching strategy (`"tooltip"` vs `"full"`).
    *   `WowheadEntity` with URL generation methods for both standard and tooltip URLs.

*   **`wowhead_mappings.py`**: URL parsing and generation with data type determination.
    *   `parse_url()`: Converts raw URLs to structured `WowheadEntity` objects.
    *   Automatic `EntityDataType` assignment based on entity type.

*   **`sitemap_filters.py`**: Data filtering and cleanup utilities.
    *   `filter_unused_entities()`: Removes deprecated and placeholder entities.
    *   `filter_entities_without_scripts()`: Script-based filtering for specific locales.

*   **`proxy_fast.py`**: High-performance proxy management.
    *   `FastProxyManager`: In-memory circular buffer proxy rotation.
    *   Support for 32 concurrent proxy endpoints with rate limiting.
    *   Thread-safe with minimal contention design.

*   **`wowhead_fetcher.py`**: Concurrent fetching orchestrator.
    *   `WowheadFetcher`: Main fetching class with `ThreadPoolExecutor` integration.
    *   Progress tracking and statistics for monitoring integration.
    *   Graceful shutdown support with stop events.
    *   Automatic database filtering to avoid re-fetching.

*   **`fetcher_controller.py`**: Web-based monitoring and control interface.
    *   `FetcherControlServer`: HTTP server for real-time monitoring.
    *   Progress visualization with configurable refresh rates.
    *   Operations queue display and graceful stop functionality.

---

### Quick-start Checklist

1.  **Environment Setup**:

    Create a `.env` file with proxy credentials for high-volume fetching:
    ```
    PROXY_USERNAME=your_username
    PROXY_PASSWORD=your_password
    PROXY_HOST=your_proxy_host
    ```

2.  **Initialize the Database and Seed Versions**:

    ```python
    from pathlib import Path
    from wowhead_db import create_db, add_version
    from sitemap_types import VersionSlug

    db_path = Path("wowhead.db")
    if db_path.exists():
        db_path.unlink()
    conn = create_db(db_path)

    for version in VersionSlug:
        add_version(conn, version.value, version.order_index)
    ```

3.  **Analyze a Delta**:

    ```python
    from sitemap_processor import calculate_version_delta, RequestsSitemapFetcher
    from sitemap_types import VersionSlug, Locale

    fetcher = RequestsSitemapFetcher()
    delta = calculate_version_delta(VersionSlug.TBC, "quest", fetcher, Locale.enUS)
    print(f"Added in TBC: {len(delta.added_entities)}")
    ```

4.  **Run the Complete Fetching System**:

    ```python
    from main import run_with_controller

    # This starts the fetcher with web-based monitoring
    run_with_controller()

    # Monitor progress at: http://localhost:8000
    ```

5.  **Fetch Specific Data with High-Performance Fetcher**:

    ```python
    from wowhead_fetcher import WowheadFetcher
    from sitemap_types import VersionSlug, Locale

    # Use a 'with' statement to ensure connections are closed
    with WowheadFetcher(db_path="wowhead.db", max_workers=128) as fetcher:
        # Fetch the first 5 quests added in The Burning Crusade
        fetcher.fetch_delta_entities(VersionSlug.TBC, "quest", limit=5, locale=Locale.enUS)
    ```

6.  **Lookup with Fallback**:

    ```python
    from wowhead_db import get_raw_data_html, get_raw_data_tooltip
    from sitemap_types import WowheadEntity, EntityId, VersionSlug, Locale

    # Create connection
    conn = create_db("wowhead.db")

    # Assume quest 2 was added in Classic, but not updated until TBC
    # We want the WotLK version, but it doesn't exist.
    lookup_entity = WowheadEntity(
        entity_id=EntityId(2),
        entity_type="quest",
        version=VersionSlug.WOTLK,
        locale=Locale.enUS
    )

    # This query will automatically fall back and return the TBC data
    html, version_used = get_raw_data_html(conn, lookup_entity)
    print(f"HTML data found from version: {version_used}")

    # For tooltip data
    tooltip, version_used = get_raw_data_tooltip(conn, lookup_entity)
    print(f"Tooltip data found from version: {version_used}")
    ```

7.  **Monitor and Control via Web Interface**:

    - Open browser to `http://localhost:8000` while fetcher is running
    - View real-time progress statistics
    - See operations queue
    - Gracefully stop fetching process
    - Configure refresh rates (1s, 2s, 5s, 10s, 30s, 1m)

---

### Performance & Scale

#### Throughput Capabilities
- **Theoretical Maximum**: ~64 requests/second with 32 proxies at 0.5s rate limit
- **Concurrent Workers**: 128 threads by default (configurable)
- **Proxy Pool**: 26 US ports + 6 German ports for geographic distribution
- **Database Optimization**: WAL mode, 256MB cache, 2GB memory mapping

#### Data Volume Examples
- **Complete Quest Data**: All expansions, all locales (~100K+ entities)
- **Smart Fetching**: Only tooltips for items/NPCs, full HTML for quests/objects
- **Delta-based Updates**: Only fetch entities new to each expansion
- **Filtering**: Automatic removal of deprecated/unused entities reduces storage by ~20%

#### Monitoring & Control
- **Real-time Progress**: Updates every 1-60 seconds via web interface
- **Queue Visibility**: See upcoming operations and estimated completion
- **Graceful Shutdown**: Stop cleanly without data corruption
- **Resource Management**: Automatic cleanup and connection management

---

### Future Enhancements

*   **Async crawler**: Upgrade to `aiohttp` for even higher concurrency with async/await patterns.
*   **FTS5 virtual table** on parsed data for fast full‑text search across all locales.
*   **ETag / Last‑Modified** headers stored to support conditional GETs and bandwidth optimization.
*   **Parsed data table**: Store structured fields (title, objectives, rewards) for direct analytics.
*   **Content diff UI**: Side‑by‑side HTML diff using fetched versions for expansion comparison.
*   **Content validation**: Parse and validate HTML structure before storage to ensure data quality.
*   **API endpoint**: RESTful API for external access to cached data.
*   **Export functionality**: Bulk export capabilities for integration with other tools.
*   **Distributed fetching**: Multi-machine coordination for enterprise-scale crawling.
*   **Machine learning**: Content analysis and classification for improved data extraction.
