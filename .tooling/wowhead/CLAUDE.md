# Wowhead Scraper System

Located in `.tooling/wowhead/`, this is a sophisticated Python-based system for creating and managing a local cache of Wowhead data across different game expansions and locales.

## Purpose
- Creates offline, high-performance access to Wowhead data
- Enables version differencing between expansions
- Provides reliable multilingual data extraction
- Maintains historical snapshots of game data

## Architecture

### Core Components
- **`main.py`**: Entry point that orchestrates fetching operations
- **`wowhead_fetcher.py`**: Core concurrent fetcher with thread pool management
- **`sitemap_processor.py`**: Discovery engine that parses Wowhead sitemaps and calculates deltas
- **`wowhead_db.py`**: SQLite database management with version fallback logic
- **`proxy_fast.py`**: High-performance proxy rotation for rate limiting
- **`fetcher_controller.py`**: Web-based monitoring and control interface

### Data Flow
1. **Configure**: Define fetch operations (version, entity type, locale)
2. **Discover**: Parse Wowhead sitemaps to generate entity lists
3. **Filter**: Remove unused/placeholder entities and apply locale-specific filters
4. **Check Cache**: Skip entities already in local database
5. **Fetch**: Concurrent download using thread pool and proxy rotation
6. **Store**: Save HTML/tooltip data tagged by entity, version, locale
7. **Monitor**: Real-time progress tracking via web interface

## Key Features

### Version-Aware Caching
- Stores data per expansion (Classic, TBC, WotLK, Cata, MoP Classic)
- Intelligent fallback to most recent available version
- Delta calculation to fetch only new/changed entities

### High-Performance Fetching
- Concurrent fetching with ThreadPoolExecutor (up to 128 workers)
- Proxy rotation to avoid rate limits
- Intelligent content type selection (full HTML for quests, tooltips for items/NPCs)

### Monitoring & Control
- Web interface at `http://localhost:8000` for real-time monitoring
- Progress tracking with ETA and requests/second metrics
- Graceful shutdown capabilities

## Usage

### Setup
```bash
cd .tooling/wowhead
pip install -r requirements.txt

# Create .env file with proxy credentials:
# PROXY_USERNAME=your_username
# PROXY_PASSWORD=your_password  
# PROXY_HOST=your_proxy_host
```

### Running
```bash
python main.py
```

Monitor progress at http://localhost:8000

### Database Schema
- **`wowhead_data`** table stores HTML/tooltip content
- **`versions`** table tracks expansion metadata
- Version fallback logic automatically finds newest available data

## Development Notes
- Uses type-safe design with comprehensive typing in `sitemap_types.py`
- Locale-specific filtering for Asian languages (koKR, zhCN, zhTW, ruRU)
- Graceful handling of network errors and rate limits
- Extensive caching to avoid redundant operations

## Filter System

The wowhead scraper has filtering logic in `sitemap_filters.py`:

### 1. **Unused Entity Filter** (`filter_unused_entities`)
- Removes deprecated, not-yet-implemented, placeholder, and unused entities
- Filters entities with name slugs starting with: `deprecated-`, `nyi-`, `ph-`, `unused-`, `unused`

### 2. **Script-Based Language Filter** (`filter_entities_without_scripts`)
- For Asian and Cyrillic locales (`koKR`, `zhCN`, `zhTW`, `ruRU`)
- Uses regex patterns to detect appropriate character scripts in entity URLs
- Ensures locale-appropriate content filtering

### 3. **Existing Entities Filter** (`filter_existing_entities`)
- Filters out entities already cached in the database unless `force=True`
- Uses dependency injection pattern with `entity_exists_check` callable
- Maintains consistency with other filter functions