"""Concurrent Wowhead page fetcher with database integration.

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
from concurrent.futures import ThreadPoolExecutor, as_completed

from proxy import RateLimitedProxyManager
from wowhead_db import create_db, add_version, insert_raw_data_html, insert_raw_data_tooltip, get_raw_data_html, entity_exists
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

manager = RateLimitedProxyManager(rate_limit_seconds=1)


def _create_worker_session(locale: Locale) -> requests.Session:
  """Creates a thread-safe requests session for a worker."""
  session = requests.Session()
  retry_strategy = Retry(
    total=3,
    backoff_factor=1,
    status_forcelist=[429, 500, 502, 503, 504],
  )
  adapter = HTTPAdapter(max_retries=retry_strategy)
  session.mount("https://", adapter)
  session.mount("http://", adapter)
  session.headers.update(
    {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
      "Accept-Language": f"{locale.value.split('US')[0]}-US,en;q=0.5",
    }
  )
  return session


def _fetch_worker(entity: WowheadEntity, locale: Locale) -> tuple[WowheadEntity, Optional[str]]:
  """Worker function to fetch a single URL. Designed to be run in a thread pool."""
  if entity.data_fetch_type == "tooltip":
    url = entity.generate_tooltip_url()
  else:
    url = entity.generate_url()
  try:
    # Each worker gets a proxy right before its request
    next_proxy, wait_time = manager.get_next_proxy()
    if wait_time > 0:
      print(f"Waiting {wait_time} seconds for next proxy...")
      time.sleep(wait_time)

    proxies = {"http": next_proxy, "https": next_proxy} if next_proxy else {}

    with _create_worker_session(locale) as session:
      print(f"Fetching: {url}")
      response = session.get(url, timeout=30, proxies=proxies)
      response.raise_for_status()
      # The RateLimitedProxyManager handles the delay, so no extra sleep is needed here.
      return entity, response.text
  except requests.exceptions.RequestException as e:
    print(f"Error fetching {url}: {e}")
    return entity, None


class WowheadFetcher:
  """Concurrent fetcher for Wowhead pages."""

  def __init__(
    self,
    db_path: str | Path = "wowhead.db",
    locale: Locale = Locale.enUS,
    max_workers: int = 10,
  ):
    self.db_path = Path(db_path)
    self.locale = locale
    self.conn = create_db(self.db_path)
    self.sitemap_fetcher = RequestsSitemapFetcher()
    self.max_workers = max_workers
    self._seed_versions()

  def _create_session(self) -> requests.Session:
    # This session is now only used for the sitemap fetcher, which is single-threaded.
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

  def _filter_existing_entities(self, entities: Iterable[WowheadEntity], force: bool) -> tuple[list[WowheadEntity], int]:
    """Filter out entities that already exist in the database unless force=True.

    Args:
      entities: List of entities to potentially filter
      force: If True, return all entities without filtering

    Returns:
      Tuple of (filtered_entities, skipped_count)
    """
    entities_list = list(entities)

    if force:
      return entities_list, 0

    # Filter out entities that already exist in the database
    filtered_entities = []
    skipped_count = 0

    print("Checking which entities already exist in database...")
    for entity in entities_list:
      if entity_exists(self.conn, entity):
        skipped_count += 1
      else:
        filtered_entities.append(entity)

    print(f"Skipped {skipped_count} entities that already exist in database")
    return filtered_entities, skipped_count

  def _fetch_entities(self, entities: Iterable[WowheadEntity], limit: Optional[int]) -> tuple[int, int]:
    """Helper to fetch and store a list of entities concurrently."""
    entities_to_fetch = list(entities)

    if limit:
      entities_to_fetch = entities_to_fetch[:limit]

    total_to_fetch = len(entities_to_fetch)
    successful = 0

    if total_to_fetch == 0:
      print("No entities to fetch")
      return 0, 0

    print(f"Fetching {total_to_fetch} entities")

    with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
      # Submit all fetch tasks to the thread pool
      future_to_entity = {executor.submit(_fetch_worker, entity, self.locale): entity for entity in entities_to_fetch}

      for i, future in enumerate(as_completed(future_to_entity), 1):
        entity, html_content = future.result()
        print(f"Progress: {i}/{total_to_fetch} - Received {entity.generate_url() if entity.data_fetch_type == 'full' else entity.generate_tooltip_url()}")

        if html_content and len(html_content) > 3:
          try:
            if entity.data_fetch_type == "tooltip":
              print(f"Stored: {entity.generate_tooltip_url()}")
              insert_raw_data_tooltip(self.conn, entity, html_content)
            else:
              print(f"Stored: {entity.generate_url()}")
              insert_raw_data_html(self.conn, entity, html_content)
            successful += 1
          except Exception as e:
            print(f"Database error storing {entity.generate_url() if entity.data_fetch_type == 'full' else entity.generate_tooltip_url()}: {e}")
        else:
          print(f"Failed to fetch: {entity.generate_url()}")

    print(f"Completed: {successful}/{total_to_fetch} successful fetches")
    return successful, total_to_fetch

  def fetch_version_entities(self, version: VersionSlug, entity_type: EntityType, limit: Optional[int] = None, force: bool = False) -> tuple[int, int]:
    """Fetch all entities for a specific version and entity type.

    Args:
      version: The game version to fetch entities for
      entity_type: The type of entities to fetch (quest, npc, item, etc.)
      limit: Optional limit on number of entities to process
      force: If True, refetch entities even if they already exist in database
    """
    print(f"Fetching all '{entity_type}' entities for '{version.value}'...")
    entities = get_entities(version, entity_type, self.sitemap_fetcher, self.locale)

    entities, skipped_count = self._filter_existing_entities(entities, force)

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, skipped_count

    return self._fetch_entities(entities, limit)

  def fetch_delta_entities(self, target_version: VersionSlug, entity_type: EntityType, limit: Optional[int] = None, force: bool = False) -> tuple[int, int]:
    """Fetch entities that were added in a specific version.

    Args:
      target_version: The game version to fetch delta entities for
      entity_type: The type of entities to fetch (quest, npc, item, etc.)
      limit: Optional limit on number of entities to process
      force: If True, refetch entities even if they already exist in database
    """
    print(f"Fetching delta '{entity_type}' entities for '{target_version.value}'...")
    delta = calculate_version_delta(target_version, entity_type, self.sitemap_fetcher, self.locale)
    entities = delta.added_entities

    entities, skipped_count = self._filter_existing_entities(entities, force)

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, skipped_count

    return self._fetch_entities(entities, limit)

  def fetch_specific_ids(self, version: VersionSlug, entity_type: EntityType, id_list: list[int], force: bool = False) -> tuple[int, int]:
    """Fetch specific entity IDs for a version and entity type.

    Args:
      version: The game version to fetch entities for
      entity_type: The type of entities to fetch (quest, npc, item, etc.)
      id_list: List of specific entity IDs to fetch
      force: If True, refetch entities even if they already exist in database
    """
    print(f"Fetching specific {entity_type} IDs for {version.value}: {id_list}")
    entities = [WowheadEntity(entity_id=EntityId(id), entity_type=entity_type, version=version, locale=self.locale) for id in id_list]

    entities, skipped_count = self._filter_existing_entities(entities, force)

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, skipped_count

    return self._fetch_entities(entities, None)

  def close(self) -> None:
    if hasattr(self, "conn") and self.conn:
      self.conn.close()

  def __enter__(self):
    return self

  def __exit__(self, exc_type, exc_val, exc_tb):
    self.close()


def main() -> None:
  db_path = Path("wowhead_refactored.db")
  # if db_path.exists():
  #   db_path.unlink()

  test_locale = Locale.enUS
  print("=== Wowhead Fetcher Demo ===")
  with WowheadFetcher(db_path=db_path, locale=test_locale) as fetcher:
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
      locale=test_locale,
    )
    dataClassic, versionClassic = get_raw_data_html(fetcher.conn, test_entity)

    if dataClassic:
      print(f"Successfully retrieved quest 1 for Classic.")
      print(f"  Data: {dataClassic[:10]}...")  # Print snippet
      print(versionClassic)
    else:
      print(f"Could not retrieve quest 1 for Classic.")

    dataTbc, versionTbc = get_raw_data_html(
      fetcher.conn,
      WowheadEntity(
        entity_id=EntityId(1),  # Assuming quest 1 exists in TBC
        entity_type="quest",
        version=VersionSlug.TBC,
        locale=test_locale,
      ),
    )

    if dataTbc:
      print(f"Successfully retrieved quest 1 for TBC.")
      print(f"  Data: {dataTbc[:10]}...")  # Print snippet
      print(versionTbc)
    else:
      print(f"Could not retrieve quest 1 for TBC.")

    # print("\n--- Fetching first 10 Classic npcs ---")
    # fetcher.fetch_version_entities(VersionSlug.CLASSIC, "npc", limit=100)

    # print("\n--- Fetching first 10 added TBC npcs ---")
    # fetcher.fetch_delta_entities(VersionSlug.TBC, "npc", limit=100)

    print(f"\nDatabase saved to: {fetcher.db_path}")


if __name__ == "__main__":
  main()
