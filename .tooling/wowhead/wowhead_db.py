# wowhead_db.py
"""SQLite helper for storing raw Wowhead pages *per locale*, keyed by
canonical URL + expansion version, with automatic fallback queries.

Schema
======
versions(version_id PK, slug UNIQUE, order_idx UNIQUE)
wowhead_data(canonical_loc, version_id → versions, locale, data, fetched_at)
PRIMARY KEY(canonical_loc, version_id, locale)

All SQL is vanilla SQLite 3 and runs on the builtin `sqlite3` module.
"""

from __future__ import annotations

import datetime as _dt
import sqlite3
from pathlib import Path
from typing import Tuple, Any, Optional

from sitemap_types import WowheadEntity, VersionSlug, Locale, EntityId


# === SCHEMA & CONNECTION HELPERS ===

_SCHEMA_SQL = """
-- ── 1. Safety+concurrency ────────────────────────────────────────────────────
PRAGMA foreign_keys = ON;          -- enforce FK to versions table
PRAGMA journal_mode  = WAL;        -- readers don't block the single writer
PRAGMA synchronous   = NORMAL;     -- WAL+NORMAL ≈ FULL durability at half the fsyncs
PRAGMA busy_timeout  = 5000;       -- wait up to 5 s when file is busy

-- ── 2. WAL & checkpoint tuning ───────────────────────────────────────────────
PRAGMA wal_autocheckpoint = 10000; -- checkpoint at ~40 MB (10k x 4 KiB pages)
PRAGMA journal_size_limit = 536870912;  -- trim WAL at 512 MB after checkpoint

-- ── 3. Memory for hotter pages ───────────────────────────────────────────────
PRAGMA cache_size = -262144;       -- 256 MB (negative = KB) page cache
PRAGMA mmap_size  = 2147483648;    -- memory map first 2 GB if RAM is available
PRAGMA temp_store = MEMORY;        -- keep temp B trees off disk

CREATE TABLE IF NOT EXISTS versions (
    version_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    slug         TEXT    UNIQUE NOT NULL,
    order_idx    INTEGER UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS wowhead_data (
    version_slug            TEXT    NOT NULL,
    locale                  TEXT    NOT NULL,
    entity_type             TEXT    NOT NULL,
    entity_id               INTEGER NOT NULL,
    name_slug               TEXT,
    lastmod                 TEXT,
    fetched_at_raw_html     TEXT,
    fetched_at_raw_tooltip  TEXT,
    raw_html_data           TEXT,
    raw_tooltip_data        TEXT,
    PRIMARY KEY (entity_id, entity_type, version_slug, locale)
);

CREATE INDEX IF NOT EXISTS idx_wowhead_data_lookup
  ON wowhead_data (entity_id, entity_type, locale, version_slug);
"""

# full_loc                TEXT GENERATED ALWAYS AS (
#     'https://www.wowhead.com/' ||
#     CASE WHEN version_slug != '' THEN version_slug || '/' ELSE '' END ||
#     entity_type ||
#     '=' ||
#     entity_id ||
#     '/' ||
#     COALESCE(name_slug, '')
# ),


def create_db(path: str | Path) -> sqlite3.Connection:
  """Create a new database or connect & ensure schema exists."""
  conn = sqlite3.connect(Path(path))
  conn.row_factory = sqlite3.Row
  with conn:
    conn.executescript(_SCHEMA_SQL)
  return conn


# === SEED & INSERT HELPERS ===


def add_version(conn: sqlite3.Connection, slug: str, order_idx: int) -> int:
  """Insert or ignore an expansion row; returns version_id."""
  cur = conn.execute(
    """
        INSERT INTO versions(slug, order_idx)
        VALUES(?, ?)
        ON CONFLICT(slug) DO UPDATE SET
            order_idx   = excluded.order_idx
        RETURNING version_id;
        """,
    (slug, order_idx),
  )
  return cur.fetchone()[0]


def insert_raw_data_html(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
  data: str,
  fetched_at: str | None = None,
) -> None:
  """Insert or update a raw HTML data for a given WowheadEntity."""
  if fetched_at is None:
    fetched_at = _dt.datetime.now(_dt.timezone.utc).isoformat()

  conn.execute(
    """
        INSERT INTO wowhead_data(entity_id, entity_type, version_slug, locale, name_slug, lastmod, raw_html_data, fetched_at_raw_html)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(entity_id, entity_type, version_slug, locale) DO UPDATE SET
            raw_html_data = excluded.raw_html_data,
            fetched_at_raw_html = excluded.fetched_at_raw_html,
            name_slug     = excluded.name_slug,
            lastmod       = excluded.lastmod
        WHERE excluded.raw_html_data IS NOT wowhead_data.raw_html_data;
        """,
    (
      entity.entity_id,
      entity.entity_type,
      entity.version.value,
      entity.locale.value,
      entity.name_slug,
      entity.lastmod,
      data,
      fetched_at,
    ),
  )
  conn.commit()


def insert_raw_data_tooltip(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
  data: str,
  fetched_at: str | None = None,
) -> None:
  """Insert or update a raw tooltip data for a given WowheadEntity."""
  if fetched_at is None:
    fetched_at = _dt.datetime.now(_dt.timezone.utc).isoformat()

  conn.execute(
    """
        INSERT INTO wowhead_data(entity_id, entity_type, version_slug, locale, name_slug, lastmod, raw_tooltip_data, fetched_at_raw_tooltip)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(entity_id, entity_type, version_slug, locale) DO UPDATE SET
            raw_tooltip_data = excluded.raw_tooltip_data,
            fetched_at_raw_tooltip = excluded.fetched_at_raw_tooltip,
            name_slug        = excluded.name_slug,
            lastmod          = excluded.lastmod
        WHERE excluded.raw_tooltip_data IS NOT wowhead_data.raw_tooltip_data;
        """,
    (
      entity.entity_id,
      entity.entity_type,
      entity.version.value,
      entity.locale.value,
      entity.name_slug,
      entity.lastmod,
      data,
      fetched_at,
    ),
  )
  conn.commit()


# === FALLBACK QUERY HELPER ===


def entity_exists(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
) -> bool:
  """Check if an entity exists in the database with either HTML or tooltip data and matching name_slug."""
  sql = """
    SELECT 1
    FROM   wowhead_data
    WHERE  entity_id   = ?
      AND  entity_type = ?
      AND  version_slug = ?
      AND  locale      = ?
      AND  (name_slug = ? OR (name_slug IS NULL AND ? IS NULL))
      AND  (raw_html_data IS NOT NULL OR raw_tooltip_data IS NOT NULL)
    LIMIT 1;
    """
  cur = conn.execute(
    sql,
    (
      entity.entity_id,
      entity.entity_type,
      entity.version.value,
      entity.locale.value,
      entity.name_slug,
      entity.name_slug,
    ),
  )
  return cur.fetchone() is not None


def get_raw_data_html(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
) -> Tuple[Any, Optional[str]]:
  """Return `(raw_html_data, version_used)` or `None` if no expansion up to target exists."""
  target_version_order_idx = conn.execute("SELECT order_idx FROM versions WHERE slug = ?", (entity.version.value,)).fetchone()["order_idx"]

  sql = """
    SELECT t.raw_html_data,
           v.slug AS version_used
    FROM   wowhead_data AS t
    JOIN   versions     AS v ON v.slug = t.version_slug
    WHERE  t.entity_id   = ?
      AND  t.entity_type = ?
      AND  t.locale      = ?
      AND  v.order_idx   <= ?
      AND  t.raw_html_data IS NOT NULL
    ORDER BY v.order_idx DESC
    LIMIT 1;
    """
  cur = conn.execute(
    sql,
    (
      entity.entity_id,
      entity.entity_type,
      entity.locale.value,
      target_version_order_idx,
    ),
  )
  row = cur.fetchone()
  if row:
    return row["raw_html_data"], row["version_used"]
  return None, None


def get_raw_data_tooltip(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
) -> Tuple[Any, Optional[str]]:
  """Return `(raw_tooltip_data, version_used)` or `None` if no expansion up to target exists."""
  target_version_order_idx = conn.execute("SELECT order_idx FROM versions WHERE slug = ?", (entity.version.value,)).fetchone()["order_idx"]

  sql = """
    SELECT t.raw_tooltip_data,
           v.slug AS version_used
    FROM   wowhead_data AS t
    JOIN   versions     AS v ON v.slug = t.version_slug
    WHERE  t.entity_id   = ?
      AND  t.entity_type = ?
      AND  t.locale      = ?
      AND  v.order_idx   <= ?
      AND  t.raw_tooltip_data IS NOT NULL
    ORDER BY v.order_idx DESC
    LIMIT 1;
    """
  cur = conn.execute(
    sql,
    (
      entity.entity_id,
      entity.entity_type,
      entity.locale.value,
      target_version_order_idx,
    ),
  )
  row = cur.fetchone()
  if row:
    return row["raw_tooltip_data"], row["version_used"]
  return None, None


def get_entity_row(
  conn: sqlite3.Connection,
  entity: WowheadEntity,
) -> Tuple[Optional[sqlite3.Row], Optional[str]]:
  """Return `(row, version_used)` or `None` if no expansion up to target exists."""
  target_version_order_idx = conn.execute("SELECT order_idx FROM versions WHERE slug = ?", (entity.version.value,)).fetchone()["order_idx"]

  sql = """
    SELECT t.*,
           v.slug AS version_used
    FROM   wowhead_data AS t
    JOIN   versions     AS v ON v.slug = t.version_slug
    WHERE  t.entity_id   = ?
      AND  t.entity_type = ?
      AND  t.locale      = ?
      AND  v.order_idx   <= ?
    ORDER BY v.order_idx DESC
    LIMIT 1;
    """
  cur = conn.execute(
    sql,
    (
      entity.entity_id,
      entity.entity_type,
      entity.locale.value,
      target_version_order_idx,
    ),
  )
  row = cur.fetchone()
  if row:
    return row, row["version_used"]
  return None, None


# === EXAMPLE CLI USAGE ===


def _demo() -> None:  # pragma: no cover
  db_path = Path("wowhead_refactored_testing.db")
  if db_path.exists():
    db_path.unlink()
  conn = create_db(db_path)

  print("--- Seeding Versions ---")
  add_version(conn, VersionSlug.RETAIL.value, 0)
  add_version(conn, VersionSlug.CLASSIC.value, 1)
  add_version(conn, VersionSlug.TBC.value, 2)
  add_version(conn, VersionSlug.WOTLK.value, 3)
  print("Seeding complete.")

  print("\n--- Inserting Wowhead_data ---")
  # Create two entities for the same quest, but different versions
  quest_classic = WowheadEntity(
    entity_id=EntityId(2),
    entity_type="quest",
    version=VersionSlug.CLASSIC,
    locale=Locale.enUS,
    name_slug="a-low-level-quest",
  )
  quest_tbc = WowheadEntity(
    entity_id=EntityId(2),
    entity_type="quest",
    version=VersionSlug.TBC,
    locale=Locale.enUS,
    name_slug="a-low-level-quest",
  )

  insert_raw_data_html(conn, quest_classic, "<html>Classic flavour text</html>")
  insert_raw_data_tooltip(conn, quest_classic, "{tooltip: 'Classic tooltip'}")
  print(f"Inserted Classic quest (ID: 2)")
  insert_raw_data_html(conn, quest_tbc, "<html>TBC flavour text</html>")
  print(f"Inserted TBC quest (ID: 2)")

  print("\n--- Testing Fallback Logic ---")
  # 1. Request WotLK version, should fall back to TBC
  print("\n1. Requesting WotLK (should fall back to TBC)")
  lookup_wotlk = WowheadEntity(
    entity_id=EntityId(2),
    entity_type="quest",
    version=VersionSlug.WOTLK,
    locale=Locale.enUS,
  )
  res = get_raw_data_html(conn, lookup_wotlk)
  print(f"  Lookup for {lookup_wotlk.version.value} returned: {res}")
  assert res and res[0] == "<html>TBC flavour text</html>" and res[1] == "tbc"

  # 2. Request TBC version, should get exact match
  print("\n2. Requesting TBC (should find exact match)")
  lookup_tbc = quest_tbc
  res = get_raw_data_html(conn, lookup_tbc)
  print(f"  Lookup for {lookup_tbc.version.value} returned: {res}")
  assert res and res[0] == "<html>TBC flavour text</html>" and res[1] == "tbc"

  # 3. Request Classic version, should get exact match
  print("\n3. Requesting Classic (should find exact match)")
  lookup_classic = quest_classic
  res = get_raw_data_html(conn, lookup_classic)
  print(f"  Lookup for {lookup_classic.version.value} returned: {res}")
  assert res and res[0] == "<html>Classic flavour text</html>" and res[1] == "classic"

  # 4. Request a non-existent locale, should return None
  print("\n4. Requesting deDE (should find nothing)")
  lookup_de = WowheadEntity(
    entity_id=EntityId(2),
    entity_type="quest",
    version=VersionSlug.WOTLK,
    locale=Locale.deDE,
  )
  res, _ = get_raw_data_html(conn, lookup_de)
  print(f"  Lookup for {lookup_de.locale.value} returned: {res}")
  assert res is None

  print("\n--- Testing Tooltip Fallback Logic ---")
  # 5. Request Classic tooltip, should get exact match
  print("\n5. Requesting Classic tooltip (should find exact match)")
  res = get_raw_data_tooltip(conn, lookup_classic)
  print(f"  Lookup for {lookup_classic.version.value} returned: {res}")
  assert res and res[0] == "{tooltip: 'Classic tooltip'}" and res[1] == "classic"

  # 6. Request WotLK tooltip, should fall back to Classic
  print("\n6. Requesting WotLK tooltip (should fall back to Classic)")
  res = get_raw_data_tooltip(conn, lookup_wotlk)
  print(f"  Lookup for {lookup_wotlk.version.value} returned: {res}")
  assert res and res[0] == "{tooltip: 'Classic tooltip'}" and res[1] == "classic"

  print("\n--- Testing Row Fallback Logic ---")
  # 7. Request WotLK row, should fall back to TBC and contain all TBC data
  print("\n7. Requesting WotLK row (should fall back to TBC)")
  res, version_used = get_entity_row(conn, lookup_wotlk)
  print(f"  Lookup for {lookup_wotlk.version.value} returned version: {version_used}")
  assert res is not None
  assert version_used == "tbc"
  assert res["raw_html_data"] == "<html>TBC flavour text</html>"
  assert res["raw_tooltip_data"] is None

  # 8. Request Classic row, should get exact match
  print("\n8. Requesting Classic row (should find exact match)")
  res, version_used = get_entity_row(conn, lookup_classic)
  print(f"  Lookup for {lookup_classic.version.value} returned version: {version_used}")
  assert res is not None
  assert version_used == "classic"
  assert res["raw_html_data"] == "<html>Classic flavour text</html>"
  assert res["raw_tooltip_data"] == "{tooltip: 'Classic tooltip'}"

  print("\nDemo finished successfully!")
  conn.close()


if __name__ == "__main__":
  _demo()
