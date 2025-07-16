---
applyTo: '**/.wowhead2/*.py'
---

### Your Mission (1 minute elevator pitch)

> **Build a local, version‑aware cache of Wowhead pages so you can diff expansions and extract multilingual quest/item/NPC text whenever you like—without re‑crawling.**
> *Drive the crawl with your sitemap‑delta script; keep the raw HTML, parse later, and serve translation look‑ups with graceful fallback (e.g., "give me quest 2 for WotLK, otherwise the newest earlier expansion").*

---

### Architecture & Data‑flow

1. **Delta Finder** (`sitemap_processor.py`):
   *Classic → TBC → WotLK …* deltas for each content type using functional programming patterns.
   - `calculate_version_delta()` - produces lists of *added / removed* URLs between versions
   - `get_locations()` - fetches all URLs for a version/content type
   - `get_version_sitemap_urls()` - gets sitemap URLs for specific version/content type
   - Uses strong typing with `sitemap_types.py` for type safety and immutable data structures

2. **Type System** (`sitemap_types.py`):
   Modern Python type definitions with protocols and strong typing.
   - `VersionSlug` enum with chronological ordering (CLASSIC, TBC, WOTLK, CATA, MOP_CLASSIC)
   - `Locale` enum for supported Wowhead languages (enUS, deDE, frFR, etc.)
   - Strong type aliases: `CanonicalUrl`, `VersionSpecificUrl`, `ContentId`
   - Immutable dataclasses: `SitemapEntry`, `DeltaResult`, `VersionInfo`
   - Protocols for dependency injection: `SitemapFetcher`, `DeltaExporter`, `UrlTransformer`

3. **URL & Type Mappings** (`wowhead_mappings.py`):
   Bridges between sitemap enums and existing wowhead.py data formats.
   - Converts between Locale/VersionSlug enums and string/numeric formats
   - `extract_version_and_locale_from_url()` - parses Wowhead URLs
   - `generate_tooltip_url()` - creates tooltip API URLs
   - `convert_sitemap_url_to_tooltip_url()` - transforms between URL formats
   - Maps to locale-specific URL segments and numeric codes

4. **Crawler Integration**:
   For every `(url, version, locale)` that's missing or due for refresh, GET Wowhead, optionally compress HTML, and use `insert_translation()` or `insert_translation_from_url()`.

5. **SQLite store** (one file, WAL mode with performance optimizations):

   | table                               | key                                                  | purpose                           |
   | ----------------------------------- | ---------------------------------------------------- | --------------------------------- |
   | `versions`                          | `version_id PK, slug UNIQUE, order_idx, released_at` | Release ordering & metadata.      |
   | `translations`                      | **`PRIMARY KEY(canonical_loc, version_id, locale)`** | Raw page blobs with fetched_at.   |
   | *(optional)* `translations_archive` | extends PK with `archived_at`                        | Saves snapshots before overwrite. |
   | *(possible later)* `wowhead_parsed` | same PK                                              | Parsed JSON for fast queries.     |

6. **Extractor / API** (`wowhead_db.py`):
   Uses `get_translation()` to fetch *the newest row ≤ target expansion*, or falls back cleanly.
   Performance optimized with WAL mode, 256MB cache, 2GB memory mapping, and intelligent caching.

---

### Key Design Decisions Discussed

| Topic                              | Final Choice                                                                          | Why                                                                                      |
| ---------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Primary key includes `version`** | ✔️ yes                                                                                | Keeps historical text, enables diffing, and still allows fallback query via `order_idx`. |
| **Canonical URL**                  | Strip `/classic/`, `/tbc/`… segment so the same quest ID maps to one `canonical_loc`. | Enables version-independent lookups with fallback.                                       |
| **Fallback query**                 | Single SQL: `ORDER BY v.order_idx DESC LIMIT 1` to pick latest ≤ target.              | Graceful degradation when exact version unavailable.                                     |
| **Raw vs. parsed**                 | Store *compressed HTML* first; run parsers later into a separate table.               | Flexibility for different parsers and future schema changes.                             |
| **Compression**                    | Optional zstd or leave raw; SQLite handles blobs up to 2 GB.                          | Balance between storage and CPU usage.                                                   |
| **Type safety**                    | Strong typing with enums, protocols, and immutable dataclasses.                       | Prevents bugs and improves maintainability.                                              |
| **Concurrency**                    | `PRAGMA journal_mode=WAL;` = one writer, many readers.                                | Production-ready concurrent access.                                                      |

---

### Deliverables Already Created

* **`wowhead_db.py`** - Core SQLite database layer:
  * `create_db(path)` – builds/updates schema with performance optimizations
  * `add_version(conn, slug, order_idx, released_at)` – idempotent expansion seeding
  * `insert_translation(conn, canonical_loc, version_slug, locale, data, fetched_at)` – UPSERT raw blob
  * `insert_translation_from_url(conn, url, locale, data, fetched_at)` – UPSERT from full URL
  * `get_translation(conn, canonical_loc, locale, target_version_slug)` – fallback lookup returning `(data, version_used)`
  * `_extract_version_from_url(url)` – helper for URL parsing

* **`sitemap_processor.py`** - Functional sitemap analysis:
  * `calculate_version_delta(target_version, content_type, fetcher, locale)` – delta calculation
  * `get_locations(version, content_type, fetcher, locale)` – fetch all URLs for version
  * `get_version_sitemap_urls(version, content_type, fetcher)` – get sitemap URLs
  * `canonicalize_url(url)` / `add_version_to_url(canonical_url, version)` – URL transformations
  * `RequestsSitemapFetcher` - concrete implementation with requests library

* **`sitemap_types.py`** - Type definitions and protocols:
  * Strong enums for `VersionSlug` and `Locale`
  * Immutable dataclasses for structured data
  * Protocols for dependency injection and testing

* **`wowhead_mappings.py`** - Type bridging and URL utilities:
  * Bidirectional mappings between enums and legacy string/numeric formats
  * URL parsing and generation helpers
  * Integration points with existing codebase

* Ready for direct import in VS Code; uses only standard library modules (`sqlite3`, `urllib.parse`, `xml.dom.minidom`) plus `requests` for HTTP.

---

### Quick‑start Checklist for VS Code Helper

1. **Import modules** into your project (all 4 files).

2. **Seed expansions** once:

   ```python
   from wowhead_db import create_db, add_version
   conn = create_db('wowhead.sqlite')
   add_version(conn, 'classic', 0, '2004-11-23')
   add_version(conn, 'tbc', 1, '2007-01-16')
   add_version(conn, 'wotlk', 2, '2008-11-13')
   add_version(conn, 'cata', 3, '2010-12-07')
   add_version(conn, 'mop-classic', 4, '2012-09-25')
   ```

3. **Delta analysis**:

   ```python
   from sitemap_processor import calculate_version_delta, RequestsSitemapFetcher
   from sitemap_types import VersionSlug, Locale

   fetcher = RequestsSitemapFetcher()
   delta = calculate_version_delta(VersionSlug.WOTLK, "quest", fetcher, Locale.enUS)
   print(f"Added: {len(delta.added_urls)}, Removed: {len(delta.removed_urls)}")
   ```

4. **Crawler loop**:

   ```python
   # Option 1: Direct canonical URL
   insert_translation(conn,
       canonical_loc='https://www.wowhead.com/quest=2',
       version_slug='wotlk',
       locale='deDE',
       data=compressed_html_bytes)

   # Option 2: From full URL (auto-extracts version)
   insert_translation_from_url(conn,
       url='https://www.wowhead.com/wotlk/de/quest=2/some-quest-name',
       locale='deDE',
       data=compressed_html_bytes)
   ```

5. **Lookup with fallback**:

   ```python
   html, version_used = get_translation(
       conn,
       'https://www.wowhead.com/quest=2',
       'deDE',
       'wotlk')  # Falls back to TBC/Classic if WotLK unavailable
   ```

6. **Type-safe URL handling**:

   ```python
   from wowhead_mappings import extract_version_and_locale_from_url, generate_tooltip_url

   version_str, locale_str = extract_version_and_locale_from_url(
       'https://www.wowhead.com/classic/de/quest=1/title')
   # Returns: ('classic', 'deDE')

   tooltip_url = generate_tooltip_url('quest', 123, 'wotlk', 'frFR')
   # Returns tooltip API URL for French WotLK quest 123
   ```

7. **(Optional)** add `translations_archive` trigger if you want snapshots before each overwrite.

---

### Future Enhancements (bookmark for later)

* **Archive table**: `translations_archive` to keep every historical blob.
* **FTS5 virtual table** on parsed JSON for fast full‑text search.
* **ETag / Last‑Modified** headers stored to support conditional GETs.
* **Parsed table**: store structured fields (title, objectives, rewards) for analytics.
* **Content diff UI**: side‑by‑side HTML diff using archived versions.
* **Async crawler**: Use `aiohttp` for concurrent fetching with rate limiting.
* **Incremental updates**: Track last-modified times to avoid re-fetching unchanged pages.
* **Content validation**: Parse and validate HTML structure before storage.

Everything above runs on plain SQLite 3; no external server or extensions required.