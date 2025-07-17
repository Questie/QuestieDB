---
applyTo: '**/.wowhead2/*.py'
---

### Your Mission (1 minute elevator pitch)

> **Build a local, version‑aware cache of Wowhead pages so you can diff expansions and extract multilingual quest/item/NPC text whenever you like—without re‑crawling.**
> *Drive the crawl with your sitemap‑delta script; keep the raw HTML, parse later, and serve translation look‑ups with graceful fallback (e.g., "give me quest 2 for WotLK, otherwise the newest earlier expansion").*

---

### Architecture & Data‑flow

1.  **Type System** (`sitemap_types.py`):
    The foundation of the system, providing modern Python type definitions with protocols and strong typing.
    -   `VersionSlug` enum with chronological ordering (`CLASSIC`, `TBC`, `WOTLK`, etc.).
    -   `Locale` enum for supported Wowhead languages (`enUS`, `deDE`, `frFR`, etc.).
    -   Strong type aliases like `EntityId` and `EntityType`.
    -   Immutable dataclasses like `WowheadEntity`, `SitemapEntry`, and `DeltaResult`.
    -   Protocols for dependency injection (`SitemapFetcher`, `DeltaExporter`).

2.  **URL & Type Mappings** (`wowhead_mappings.py`):
    Centralizes all logic for parsing Wowhead URLs into structured `WowheadEntity` objects and vice-versa. This ensures a single source of truth for URL manipulation.

3.  **Sitemap Processor** (`sitemap_processor.py`):
    The discovery and comparison engine. It fetches and parses Wowhead's sitemaps to generate lists of `WowheadEntity` objects. It can calculate the "delta" between two game versions to find added or removed entities.

4.  **Fetcher** (`wowhead_fetcher.py`):
    The orchestrator. It uses the sitemap processor to get a list of entities, then fetches the raw HTML for each one and uses the database layer to store it. It handles retries and request headers.

5.  **SQLite Store** (`wowhead_db.py`):
    Manages the `wowhead.sqlite` database with performance optimizations (WAL mode, etc.).

    | Table          | Key                                              | Purpose                                                              |
    | -------------- | ------------------------------------------------ | -------------------------------------------------------------------- |
    | `versions`     | `version_id PK, slug UNIQUE, order_idx UNIQUE`   | Defines game expansions and their chronological order for fallbacks. |
    | `wowhead_data` | **`PRIMARY KEY(entity_id, entity_type, version_slug, locale)`** | Stores raw HTML/tooltip data per entity, version, and locale.        |

6.  **Extractor / API** (`wowhead_db.py`):
    Provides functions to query the database. The key feature is the version fallback logic: `get_raw_data_html()` and `get_raw_data_tooltip()` will fetch the newest row for an entity that is less than or equal to the target expansion version.

---

### Key Design Decisions

| Topic                              | Final Choice                                                                          | Why                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Primary key includes `version`** | ✔️ yes                                                                                | Keeps historical text, enables diffing, and still allows fallback query via `order_idx`. |
| **Entity Identification**          | Composite key of `(entity_id, entity_type, version_slug, locale)`.                    | Uniquely identifies an entity at a specific point in time and language.                  |
| **Fallback query**                 | Single SQL: `ORDER BY v.order_idx DESC LIMIT 1` to pick latest ≤ target.              | Graceful degradation when exact version unavailable.                                     |
| **Raw vs. parsed**                 | Store raw HTML/tooltip data first; run parsers later.                                 | Flexibility for different parsers and future schema changes.                             |
| **Type safety**                    | Strong typing with enums, protocols, and immutable dataclasses.                       | Prevents bugs and improves maintainability.                                              |
| **Concurrency**                    | `PRAGMA journal_mode=WAL;` = one writer, many readers.                                | Production-ready concurrent access.                                                      |

---

### Deliverables

*   **`wowhead_db.py`**: Core SQLite database layer.
    *   `create_db(path)`: Builds/updates schema with performance optimizations.
    *   `add_version(conn, slug, order_idx)`: Idempotent expansion seeding.
    *   `insert_raw_data_html(conn, entity, data)`: UPSERTs raw HTML for a `WowheadEntity`.
    *   `insert_raw_data_tooltip(conn, entity, data)`: UPSERTs raw tooltip data for a `WowheadEntity`.
    *   `get_raw_data_html(conn, entity)`: Fallback lookup returning `(data, version_used)`.
    *   `get_raw_data_tooltip(conn, entity)`: Fallback lookup for tooltip data.
    *   `get_entity_row(conn, entity)`: Fallback lookup returning the full database row.

*   **`sitemap_processor.py`**: Functional sitemap analysis.
    *   `calculate_version_delta(target_version, entity_type, fetcher, locale)`: Calculates the delta between two versions.
    *   `get_entities(version, entity_type, fetcher, locale)`: Fetches all entities for a specific version.
    *   `RequestsSitemapFetcher`: Concrete `SitemapFetcher` implementation using the `requests` library.

*   **`sitemap_types.py`**: Contains all type definitions, enums, and dataclasses.

*   **`wowhead_mappings.py`**: Centralizes URL parsing and generation logic via the `parse_url` function.

*   **`wowhead_fetcher.py`**: High-level orchestrator for fetching and storing data.

---

### Quick-start Checklist

1.  **Initialize the Database and Seed Versions**:

    ```python
    from pathlib import Path
    from wowhead_db import create_db, add_version
    from sitemap_types import VersionSlug

    db_path = Path("wowhead.sqlite")
    if db_path.exists():
        db_path.unlink()
    conn = create_db(db_path)

    for version in VersionSlug:
        add_version(conn, version.value, version.order_index)
    ```

2.  **Analyze a Delta**:

    ```python
    from sitemap_processor import calculate_version_delta, RequestsSitemapFetcher
    from sitemap_types import VersionSlug, EntityType

    fetcher = RequestsSitemapFetcher()
    delta = calculate_version_delta(VersionSlug.TBC, "quest", fetcher)
    print(f"Added in TBC: {len(delta.added_entities)}")
    ```

3.  **Fetch and Store Data**:

    ```python
    from wowhead_fetcher import WowheadFetcher
    from sitemap_types import VersionSlug, EntityType

    # Use a 'with' statement to ensure connections are closed
    with WowheadFetcher(db_path="wowhead.sqlite") as fetcher:
        # Fetch the first 5 quests added in The Burning Crusade
        fetcher.fetch_delta_entities(VersionSlug.TBC, "quest", limit=5)
    ```

4.  **Lookup with Fallback**:

    ```python
    from wowhead_db import get_raw_data_html
    from sitemap_types import WowheadEntity, EntityId, VersionSlug, Locale

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
    print(f"Data found from version: {version_used}")
    ```

---

### Future Enhancements

*   **Async crawler**: Use `aiohttp` for concurrent fetching with rate limiting.
*   **FTS5 virtual table** on parsed data for fast full‑text search.
*   **ETag / Last‑Modified** headers stored to support conditional GETs.
*   **Parsed data table**: Store structured fields (title, objectives, rewards) for analytics.
*   **Content diff UI**: Side‑by‑side HTML diff using fetched versions.
*   **Content validation**: Parse and validate HTML structure before storage.
