"""Concurrent Wowhead page fetcher with database integration.

This module provides functionality to fetch Wowhead pages for specific versions
and entity types, storing the raw HTML in the local database for later parsing.
"""

from __future__ import annotations

import signal
import threading
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

manager = RateLimitedProxyManager(rate_limit_seconds=0.5)


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


def _fetch_worker(entity: WowheadEntity, locale: Locale, stop_event: threading.Event) -> tuple[WowheadEntity, Optional[str]]:
  """Worker function to fetch a single URL. Designed to be run in a thread pool."""
  # Check if we should stop before starting work
  if stop_event.is_set():
    return entity, None

  if entity.data_fetch_type == "tooltip":
    url = entity.generate_tooltip_url()
  else:
    url = entity.generate_url()
  try:
    # Check again before network operation
    if stop_event.is_set():
      return entity, None

    # Each worker gets a proxy right before its request
    next_proxy, wait_time = manager.get_next_proxy()
    if wait_time > 0:
      # print(f"Waiting {wait_time} seconds for next proxy...")
      # Use stop_event.wait() instead of time.sleep() for cancellable waiting
      if stop_event.wait(timeout=wait_time):
        return entity, None

    proxies = {"http": next_proxy, "https": next_proxy} if next_proxy else {}

    with _create_worker_session(locale) as session:
      # print(f"Fetching: {url}")
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
    max_workers: int = 32,
  ):
    self.db_path = Path(db_path)
    self.locale = locale
    self.conn = create_db(self.db_path)
    self.sitemap_fetcher = RequestsSitemapFetcher()
    self.max_workers = max_workers

    # Cancellation and monitoring support
    self._stop_event = threading.Event()
    self._running = False
    self._current_operation = ""
    self._progress_stats = {"current_batch": 0, "total_batches": 0, "successful": 0, "total": 0, "start_time": None, "entity_type": "", "version": ""}
    self._stats_lock = threading.Lock()

    # Signal handler for graceful shutdown
    self._setup_signal_handlers()

    self._seed_versions()

  def _setup_signal_handlers(self) -> None:
    """Set up signal handlers for graceful shutdown."""

    def signal_handler(signum, frame):
      print(f"\nReceived signal {signum}. Requesting graceful shutdown...")
      self.request_stop()

    try:
      signal.signal(signal.SIGINT, signal_handler)
      signal.signal(signal.SIGTERM, signal_handler)
    except (ValueError, OSError):
      # Signal handling might not be available in all environments
      pass

  def request_stop(self) -> None:
    """Request the fetcher to stop gracefully."""
    print("Stop requested - will finish current operations and shutdown gracefully")
    self._stop_event.set()

  def is_stopped(self) -> bool:
    """Check if the fetcher has been stopped."""
    return self._stop_event.is_set()

  def is_running(self) -> bool:
    """Check if the fetcher is currently running."""
    return self._running

  def get_progress_info(self) -> str:
    """Get current progress information as a formatted string."""
    with self._stats_lock:
      stats = self._progress_stats.copy()

    if stats["start_time"]:
      elapsed = time.time() - stats["start_time"]
      elapsed_str = f"{elapsed:.1f}s"
    else:
      elapsed_str = "N/A"

    info = f"""Current Operation: {self._current_operation}
Entity Type: {stats["entity_type"]}
Version: {stats["version"]}
Progress: {stats["successful"]}/{stats["total"]} successful
Elapsed Time: {elapsed_str}
Status: {"Stopping..." if self.is_stopped() else "Running"}"""

    return info

  def _update_progress(self, **kwargs) -> None:
    """Update progress statistics thread-safely."""
    with self._stats_lock:
      self._progress_stats.update(kwargs)

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

    # Set running state and update progress
    self._running = True
    self._update_progress(total=total_to_fetch, successful=0, start_time=time.time())

    print(f"Fetching {total_to_fetch} entities")

    try:
      with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
        # Submit all fetch tasks to the thread pool
        future_to_entity = {executor.submit(_fetch_worker, entity, self.locale, self._stop_event): entity for entity in entities_to_fetch}

        for i, future in enumerate(as_completed(future_to_entity), 1):
          # Check if we should stop before processing results
          if self._stop_event.is_set():
            print(f"Stop requested - cancelling remaining {total_to_fetch - i + 1} tasks")
            # Cancel remaining futures
            for f in future_to_entity.keys():
              if not f.done():
                f.cancel()
            break

          entity, html_content = future.result()
          print(f"Progress: {i}/{total_to_fetch} - Received {entity.generate_url() if entity.data_fetch_type == 'full' else entity.generate_tooltip_url()}")

          if html_content and len(html_content) > 3:
            try:
              if entity.data_fetch_type == "tooltip":
                # print(f"Stored: {entity.generate_tooltip_url()}")
                insert_raw_data_tooltip(self.conn, entity, html_content)
              else:
                # print(f"Stored: {entity.generate_url()}")
                insert_raw_data_html(self.conn, entity, html_content)
              successful += 1
              self._update_progress(successful=successful)
            except Exception as e:
              print(f"Database error storing {entity.generate_url() if entity.data_fetch_type == 'full' else entity.generate_tooltip_url()}: {e}")
          else:
            print(f"Failed to fetch: {entity.generate_url()}")

    finally:
      self._running = False

    status = "stopped" if self._stop_event.is_set() else "completed"
    print(f"Fetch operation {status}: {successful}/{total_to_fetch} successful fetches")
    return successful, total_to_fetch

  def fetch_version_entities(self, version: VersionSlug, entity_type: EntityType, limit: Optional[int] = None, force: bool = False) -> tuple[int, int]:
    """Fetch all entities for a specific version and entity type.

    Args:
      version: The game version to fetch entities for
      entity_type: The type of entities to fetch (quest, npc, item, etc.)
      limit: Optional limit on number of entities to process
      force: If True, refetch entities even if they already exist in database
    """
    if self._stop_event.is_set():
      print("Fetcher is stopped - cannot start new operations")
      return 0, 0

    self._current_operation = f"Fetching all {entity_type} entities for {version.value}"
    self._update_progress(entity_type=entity_type, version=version.value)

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
    if self._stop_event.is_set():
      print("Fetcher is stopped - cannot start new operations")
      return 0, 0

    self._current_operation = f"Fetching delta {entity_type} entities for {target_version.value}"
    self._update_progress(entity_type=entity_type, version=target_version.value)

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
    if self._stop_event.is_set():
      print("Fetcher is stopped - cannot start new operations")
      return 0, 0

    self._current_operation = f"Fetching specific {entity_type} IDs for {version.value}"
    self._update_progress(entity_type=entity_type, version=version.value)

    print(f"Fetching specific {entity_type} IDs for {version.value}: {id_list}")
    entities = [WowheadEntity(entity_id=EntityId(id), entity_type=entity_type, version=version, locale=self.locale) for id in id_list]

    entities, skipped_count = self._filter_existing_entities(entities, force)

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, skipped_count

    return self._fetch_entities(entities, None)

  def close(self) -> None:
    """Close the database connection and clean up resources."""
    # Request stop if not already set
    if not self._stop_event.is_set():
      self.request_stop()

    # Wait a moment for any running operations to finish
    if self._running:
      print("Waiting for current operations to finish...")
      for _ in range(10):  # Wait up to 10 seconds
        if not self._running:
          break
        time.sleep(1)

    if hasattr(self, "conn") and self.conn:
      print("Closing database connection...")
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


#  def fetch_version_entities_count(self, version: VersionSlug, entity_type: EntityType, force: bool = False) -> int:
#    """Fetch the count of entities for a specific version and entity type.
#
#    Args:
#      version: The game version to fetch entities for
#      entity_type: The type of entities to fetch (quest, npc, item, etc.)
#    """
#    if self._stop_event.is_set():
#      print("Fetcher is stopped - cannot start new operations")
#      return 0
#
#    print(f"Fetching count of all '{entity_type}' entities for '{version.value}'...")
#    entities = get_entities(version, entity_type, self.sitemap_fetcher, self.locale)
#
#    entities, skipped_count = self._filter_existing_entities(entities, force)
#
#    return len(entities)
#
#  def fetch_delta_entities_count(self, target_version: VersionSlug, entity_type: EntityType, force: bool = False) -> int:
#    """Fetch the count of entities that were added in a specific version.
#
#    Args:
#      target_version: The game version to fetch delta entities for
#      entity_type: The type of entities to fetch (quest, npc, item, etc.)
#      force: If True, refetch entities even if they already exist in database
#    """
#    if self._stop_event.is_set():
#      print("Fetcher is stopped - cannot start new operations")
#      return 0
#
#    print(f"Fetching count of delta '{entity_type}' entities for '{target_version.value}'...")
#    delta = calculate_version_delta(target_version, entity_type, self.sitemap_fetcher, self.locale)
#    entities = delta.added_entities
#
#    entities, skipped_count = self._filter_existing_entities(entities, force)
#
#    return len(entities)
