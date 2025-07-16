# wowhead_db.py
"""SQLite helper for storing raw Wowhead pages *per locale*, keyed by
canonical URL + expansion version, with automatic fallback queries.

Schema
======
versions(version_id PK, slug UNIQUE, order_idx UNIQUE, released_at)
translations(canonical_loc, version_id → versions, locale, data, fetched_at)
PRIMARY KEY(canonical_loc, version_id, locale)

Public helpers
--------------
create_db(path)               → initialise / upgrade schema
add_version(conn, slug, idx)  → insert row in versions (idempotent)
insert_translation(conn, canonical_loc, version_slug, locale, data,
                   fetched_at=None) → UPSERT raw HTML/JSON
insert_translation_from_url(conn, url, locale, data, fetched_at=None) → UPSERT raw HTML/JSON from URL
get_translation(conn, canonical_loc, locale, target_slug) → fallback lookup

All SQL is vanilla SQLite 3 and runs on the builtin `sqlite3` module.
"""

from __future__ import annotations

import datetime as _dt
import sqlite3
from pathlib import Path
from typing import Optional, Tuple, Any

###############################################################################
# Schema & connection helpers
###############################################################################

_SCHEMA_SQL = """
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
PRAGMA cache_size = -262144;  -- 256MB cache (negative = KB)
PRAGMA temp_store = MEMORY;
PRAGMA mmap_size = 2147483648;  -- 2GB memory mapping
PRAGMA wal_autocheckpoint = 10000;
PRAGMA busy_timeout = 30000;  -- 30 seconds

-- Safety & Integrity
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS versions (
    version_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    slug         TEXT    UNIQUE NOT NULL,
    order_idx    INTEGER UNIQUE NOT NULL,
    released_at  DATE
);

CREATE TABLE IF NOT EXISTS translations (
    canonical_loc TEXT NOT NULL,
    version_id    INTEGER NOT NULL REFERENCES versions(version_id),
    locale        TEXT NOT NULL,
    data          TEXT,
    fetched_at    TEXT DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    PRIMARY KEY   (canonical_loc, version_id, locale)
);

CREATE INDEX IF NOT EXISTS idx_translations_lookup
    ON translations (canonical_loc, locale, version_id);
"""


def create_db(path: str | Path) -> sqlite3.Connection:
  """Create a new database or connect & ensure schema exists."""
  conn = sqlite3.connect(Path(path))
  conn.row_factory = sqlite3.Row
  # executescript commits implicitly so we wrap in transaction
  with conn:
    conn.executescript(_SCHEMA_SQL)
  return conn


###############################################################################
# Seed & insert helpers
###############################################################################


def add_version(conn: sqlite3.Connection, slug: str, order_idx: int, released_at: str | None = None) -> int:
  """Insert or ignore an expansion row; returns version_id."""
  cur = conn.execute(
    """
        INSERT INTO versions(slug, order_idx, released_at)
        VALUES(?, ?, ?)
        ON CONFLICT(slug) DO UPDATE SET
            order_idx   = excluded.order_idx,
            released_at = COALESCE(excluded.released_at, versions.released_at)
        RETURNING version_id;
        """,
    (slug, order_idx, released_at),
  )
  return cur.fetchone()[0]


def _get_version_id(conn: sqlite3.Connection, slug: str) -> int:
  cur = conn.execute("SELECT version_id FROM versions WHERE slug = ?", (slug,))
  row = cur.fetchone()
  if row is None:
    raise ValueError(f"Version '{slug}' missing. Add it with add_version().")
  return row[0]


def _extract_version_from_url(url: str) -> Tuple[str, str]:
  """Extract version and canonical URL from a Wowhead URL.

  Args:
    url: Full Wowhead URL like 'https://www.wowhead.com/tbc/quest=7786/thunderaan-the-windseeker'

  Returns:
    Tuple of (version_slug, canonical_url)

  Examples:
    'https://www.wowhead.com/tbc/quest=7786/thunderaan-the-windseeker'
    -> ('tbc', 'https://www.wowhead.com/quest=7786')

    'https://www.wowhead.com/quest=7786/thunderaan-the-windseeker'
    -> ('unknown', 'https://www.wowhead.com/quest=7786/thunderaan-the-windseeker')
  """
  # Split URL by '/' and get the part after wowhead.com
  parts = url.split("/")
  if len(parts) < 4 or parts[2] != "www.wowhead.com":
    raise ValueError(f"URL format not recognized: {url}")

  first_segment = parts[3]  # The segment right after www.wowhead.com/

  # If the first segment contains '=', it's content (quest=123), so no version
  if "=" in first_segment:
    version_slug = "unknown"
    canonical_url = url.split("?")[0]  # Remove any query params, keep path as-is
  else:
    # First segment is version, second should be content
    if len(parts) < 5:
      raise ValueError(f"URL format not recognized: {url}")

    version_slug = first_segment
    content_segment = parts[4]  # quest=123, item=456, etc.
    canonical_url = f"https://www.wowhead.com/{content_segment}"

  return version_slug, canonical_url


def insert_translation(
  conn: sqlite3.Connection,
  canonical_loc: str,
  version_slug: str,
  locale: str,
  data: bytes | str,
  fetched_at: Optional[str] = None,
) -> None:
  """Insert or update a raw HTML/JSON data.

  * `data` can be bytes (for future compression support) or str.
  * Currently stored as TEXT, but function supports both types for flexibility.
  * If `fetched_at` None -> now in ISO‑8601.
  """
  if fetched_at is None:
    # Use timezone-aware UTC datetime as recommended
    fetched_at = _dt.datetime.now(_dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

  version_id = _get_version_id(conn, version_slug)

  conn.execute(
    """
        INSERT INTO translations(canonical_loc, version_id, locale, data, fetched_at)
        VALUES (?, ?, ?, ?, ?)
        ON CONFLICT(canonical_loc, version_id, locale) DO UPDATE SET
            data       = excluded.data,
            fetched_at = excluded.fetched_at
        WHERE excluded.data IS NOT translations.data;
        """,
    (canonical_loc, version_id, locale, data, fetched_at),
  )
  conn.commit()


def insert_translation_from_url(
  conn: sqlite3.Connection,
  url: str,
  locale: str,
  data: bytes | str,
  fetched_at: Optional[str] = None,
) -> None:
  """Insert or update a raw HTML/JSON data, extracting version from URL.

  * `url` should be a full Wowhead URL like 'https://www.wowhead.com/tbc/quest=7786/thunderaan-the-windseeker'
  * `data` can be bytes (for future compression support) or str.
  * Currently stored as TEXT, but function supports both types for flexibility.
  * If `fetched_at` None -> now in ISO‑8601.

  The function will extract the version slug from the URL and convert it to a canonical format.
  """
  if fetched_at is None:
    # Use timezone-aware UTC datetime as recommended
    fetched_at = _dt.datetime.now(_dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

  version_slug, canonical_loc = _extract_version_from_url(url)
  version_id = _get_version_id(conn, version_slug)

  conn.execute(
    """
        INSERT INTO translations(canonical_loc, version_id, locale, data, fetched_at)
        VALUES (?, ?, ?, ?, ?)
        ON CONFLICT(canonical_loc, version_id, locale) DO UPDATE SET
            data       = excluded.data,
            fetched_at = excluded.fetched_at
        WHERE excluded.data IS NOT translations.data;
        """,
    (canonical_loc, version_id, locale, data, fetched_at),
  )
  conn.commit()


###############################################################################
# Fallback query helper
###############################################################################


def get_translation(
  conn: sqlite3.Connection,
  canonical_loc: str,
  locale: str,
  target_version_slug: str,
) -> Optional[Tuple[Any, str]]:
  """Return `(data, version_used)` or `None` if no expansion up to target exists."""

  sql = """
    SELECT t.data,
           v.slug AS version_used
    FROM   translations AS t
    JOIN   versions     AS v ON v.version_id = t.version_id
    WHERE  t.canonical_loc = ?
      AND  t.locale        = ?
      AND  v.order_idx     <= (SELECT order_idx
                               FROM   versions
                               WHERE  slug = ?)
    ORDER BY v.order_idx DESC
    LIMIT 1;
    """
  cur = conn.execute(sql, (canonical_loc, locale, target_version_slug))
  row = cur.fetchone()
  if row:
    return row["data"], row["version_used"]
  return None


###############################################################################
# Example CLI usage
###############################################################################


def _demo() -> None:  # pragma: no cover
  db = Path("wowhead.db")
  conn = create_db(db)

  # Seed expansions
  add_version(conn, "unknown", 0, None)  # For URLs without explicit version
  add_version(conn, "classic", 1, "2004-11-23")
  add_version(conn, "tbc", 2, "2007-01-16")
  add_version(conn, "wotlk", 3, "2008-11-13")
  add_version(conn, "cata", 4, "2010-12-07")
  add_version(conn, "mop-classic", 5, "2012-09-25")

  # Insert two copies of quest=2 in English using old method
  insert_translation(
    conn,
    "https://www.wowhead.com/quest=2",
    "classic",
    "enUS",
    "Classic flavour text",
  )
  insert_translation(
    conn,
    "https://www.wowhead.com/quest=2",
    "tbc",
    "enUS",
    "TBC flavour text",
  )

  # Insert translation using URL with version extraction
  insert_translation_from_url(
    conn,
    "https://www.wowhead.com/tbc/quest=7786/thunderaan-the-windseeker",
    "enUS",
    "TBC quest flavour text",
  )

  # Test URL parsing examples
  print("Testing URL parsing:")
  test_urls = [
    "https://www.wowhead.com/tbc/quest=7786/thunderaan-the-windseeker",
    "https://www.wowhead.com/wotlk/item=12345",
    "https://www.wowhead.com/quest=7786/thunderaan-the-windseeker",
    "https://www.wowhead.com/quest=2",
    "https://www.wowhead.com/item=1234/some-item-name",
  ]

  for url in test_urls:
    try:
      version, canonical = _extract_version_from_url(url)
      print(f"  {url} -> version: {version}, canonical: {canonical}")
    except ValueError as e:
      print(f"  {url} -> ERROR: {e}")

  # Query requesting WotLK but falling back
  res = get_translation(conn, "https://www.wowhead.com/quest=2", "enUS", "wotlk")
  print("Lookup result:", res)


if __name__ == "__main__":
  _demo()
