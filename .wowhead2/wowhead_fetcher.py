"""Single-threaded Wowhead page fetcher with database integration.

This module provides functionality to fetch Wowhead pages for specific versions
and entity types, storing the raw HTML in the local database for later parsing.
"""

from __future__ import annotations

import time
from pathlib import Path
from typing import Optional, Iterable
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

from wowhead_db import create_db, add_version, insert_raw_data_html, get_raw_data_html
from sitemap_processor import (
  calculate_version_delta,
  get_entities,
  RequestsSitemapFetcher,
)
from sitemap_types import (
  VersionSlug,
  EntityType,
  Locale,
  WowheadEntity,
  EntityId,
)


class WowheadFetcher:
  """Single-threaded fetcher for Wowhead pages."""

  def __init__(self, db_path: str | Path = "wowhead.sqlite", locale: Locale = Locale.enUS):
    self.db_path = Path(db_path)
    self.locale = locale
    self.conn = create_db(self.db_path)
    self.session = self._create_session()
    self.sitemap_fetcher = RequestsSitemapFetcher()
    self._seed_versions()

  def _create_session(self) -> requests.Session:
    session = requests.Session()
    retry_strategy = Retry(
      total=3,
      backoff_factor=1,
      status_forcelist=[429, 500, 502, 503, 504],
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    session.mount("https://", adapter)
    session.headers.update(
      {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
        "Accept-Language": f"{self.locale.value.split('US')[0]}-US,en;q=0.5",
      }
    )
    return session

  def _seed_versions(self) -> None:
    """Seed the database with known expansion versions."""
    for version in VersionSlug:
      add_version(self.conn, version.value, version.order_index)

  def fetch_url(self, url: str, delay: float = 1.0) -> Optional[str]:
    try:
      print(f"Fetching: {url}")
      response = self.session.get(url, timeout=30)
      response.raise_for_status()
      time.sleep(delay)
      return response.text
    except requests.exceptions.RequestException as e:
      print(f"Error fetching {url}: {e}")
      return None

  def fetch_and_store(self, entity: WowheadEntity, delay: float = 1.0) -> bool:
    url = entity.generate_url()
    html_content = self.fetch_url(url, delay)
    if html_content is None:
      return False

    try:
      insert_raw_data_html(self.conn, entity, html_content)
      print(f"Stored: {url}")
      return True
    except Exception as e:
      print(f"Database error storing {url}: {e}")
      return False

  def _fetch_entities(self, entities: Iterable[WowheadEntity], limit: Optional[int], delay: float) -> tuple[int, int]:
    """Helper to fetch and store a list of entities."""
    entities_to_fetch = list(entities)
    if limit:
      entities_to_fetch = entities_to_fetch[:limit]

    total = len(entities_to_fetch)
    successful = 0
    for i, entity in enumerate(entities_to_fetch, 1):
      print(f"Progress: {i}/{total}")
      if self.fetch_and_store(entity, delay):
        successful += 1
      else:
        print(f"Failed to fetch {i}/{total}: {entity.generate_url()}")

    print(f"Completed: {successful}/{total} successful fetches")
    return successful, total

  def fetch_version_entities(self, version: VersionSlug, entity_type: EntityType, limit: Optional[int] = None, delay: float = 1.0) -> tuple[int, int]:
    print(f"Fetching all '{entity_type}' entities for '{version.value}'...")
    entities = get_entities(version, entity_type, self.sitemap_fetcher, self.locale)
    return self._fetch_entities(entities, limit, delay)

  def fetch_delta_entities(self, target_version: VersionSlug, entity_type: EntityType, limit: Optional[int] = None, delay: float = 1.0) -> tuple[int, int]:
    print(f"Fetching delta '{entity_type}' entities for '{target_version.value}'...")
    delta = calculate_version_delta(target_version, entity_type, self.sitemap_fetcher, self.locale)
    # We only care about newly added things for the target version
    return self._fetch_entities(delta.added_entities, limit, delay)

  def fetch_specific_ids(self, version: VersionSlug, entity_type: EntityType, id_list: list[int], delay: float = 1.0) -> tuple[int, int]:
    print(f"Fetching specific {entity_type} IDs for {version.value}: {id_list}")
    entities = [WowheadEntity(entity_id=EntityId(id), entity_type=entity_type, version=version, locale=self.locale) for id in id_list]
    return self._fetch_entities(entities, None, delay)

  def close(self) -> None:
    if hasattr(self, "conn"):
      self.conn.close()
    if hasattr(self, "session"):
      self.session.close()

  def __enter__(self):
    return self

  def __exit__(self, exc_type, exc_val, exc_tb):
    self.close()


def main() -> None:
  db_path = Path("wowhead_refactored.db")
  if db_path.exists():
    db_path.unlink()

  print("=== Wowhead Fetcher Demo ===")
  with WowheadFetcher(db_path=db_path) as fetcher:
    print("\n--- Fetching first 5 Classic quests ---")
    fetcher.fetch_version_entities(VersionSlug.CLASSIC, "quest", limit=5)

    print("\n--- Fetching first 5 added TBC quests ---")
    fetcher.fetch_delta_entities(VersionSlug.TBC, "quest", limit=5)

    print("\n=== Verifying a Fetched Quest ===")
    # Verify that a quest fetched from Classic can be retrieved
    test_entity = WowheadEntity(
      entity_id=EntityId(1),  # Assuming quest 1 exists and was fetched
      entity_type="quest",
      version=VersionSlug.CLASSIC,
      locale=Locale.enUS,
    )
    translation = get_raw_data_html(fetcher.conn, test_entity)

    if translation:
      print(f"Successfully retrieved quest 1 for Classic.")
      print(translation)
      # print(f"  Data: {translation[0][:80]}...") # Print snippet
    else:
      print(f"Could not retrieve quest 1 for Classic.")

    print(f"\nDatabase saved to: {fetcher.db_path}")


if __name__ == "__main__":
  main()
