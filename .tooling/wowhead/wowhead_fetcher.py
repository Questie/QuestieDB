"""Concurrent Wowhead page fetcher with database integration.

This module provides functionality to fetch Wowhead pages for specific versions
and entity types, storing the raw HTML in the local database for later parsing.
"""

from __future__ import annotations

import signal
import threading
import time
import os
from pathlib import Path
from typing import Optional, Iterable
import httpx
from concurrent.futures import ThreadPoolExecutor, as_completed
import sitemap_filters
from proxy import RateLimitedProxyManager  # noqa: F401
from proxy_fast import FastProxyManager
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

# manager = RateLimitedProxyManager(rate_limit_seconds=0.1)
manager = FastProxyManager(rate_limit_seconds=0.5)  # Use FastProxyManager for better performance

# Thread-local storage for persistent httpx clients per thread
_thread_local = threading.local()


def _get_worker_client(locale: Locale) -> httpx.Client:
  """Get or create a thread-local persistent HTTP/2 client for a worker."""
  if not hasattr(_thread_local, "client") or _thread_local.client is None:
    _thread_local.client = httpx.Client(
      http2=True,
      timeout=10.0,
      limits=httpx.Limits(max_connections=1, max_keepalive_connections=1),
      headers={
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
        "Accept-Language": f"{locale.value[:2]}-{locale.value[2:]},{locale.value[:2]};q=0.9,en;q=0.5",
        "Accept-Encoding": "gzip, deflate",
      },
    )
  return _thread_local.client


def _cleanup_worker_client() -> None:
  """Clean up thread-local client when a worker thread finishes."""
  if hasattr(_thread_local, "client") and _thread_local.client is not None:
    _thread_local.client.close()
    _thread_local.client = None


LOG_FILE = os.path.join(os.path.dirname(__file__), "fetch_debug.log")


def log_metadata(url, response, elapsed):
  """Writes useful metadata to a local log file for debugging."""
  enc = response.headers.get("Content-Encoding", "none")
  cache = response.headers.get("X-Cache", "N/A")
  size = len(response.content)
  status = response.status_code

  line = f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] {url}\n  → status={status}, encoding={enc}, size={size} bytes, time={elapsed:.3f}s, cache={cache}\n"

  # Append log entry safely even if multithreaded
  with threading.Lock():
    with open(LOG_FILE, "a", encoding="utf-8") as f:
      f.write(line)


def _fetch_worker(entity: WowheadEntity, locale: Locale, stop_event: threading.Event) -> tuple[WowheadEntity, Optional[str]]:
  """Worker function to fetch a single URL using HTTP/2. Designed to be run in a thread pool."""
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

    # Keep trying until we get a proxy or should stop
    while True:
      next_proxy, wait_time = manager.get_next_proxy()

      if next_proxy is not None:
        # Got a proxy, proceed with request
        break

      if wait_time > 0:
        # Need to wait before retrying
        if stop_event.wait(timeout=wait_time):
          return entity, None
        # Continue loop to try getting proxy again
      else:
        # No proxies available and no wait time means no proxies configured
        break

    # Configure proxy for httpx (httpx uses tuple format)
    proxy_url = f"http://{next_proxy}" if next_proxy else None
    mounts = {
      "http://": httpx.HTTPTransport(proxy=proxy_url) if proxy_url else None,
      "https://": httpx.HTTPTransport(proxy=proxy_url) if proxy_url else None,
    }
    # Filter out None values
    mounts = {k: v for k, v in mounts.items() if v is not None}

    client = _get_worker_client(locale)

    # Retry logic with backoff
    max_retries = 3
    for attempt in range(max_retries):
      try:
        if stop_event.is_set():
          return entity, None

        response = client.get(url, timeout=10.0)
        response.raise_for_status()

        log_metadata(url, response, response.elapsed.total_seconds())

        # The FastProxyManager handles the delay
        return entity, response.text
      except httpx.HTTPStatusError as e:
        if e.response.status_code in [429, 500, 502, 503, 504]:
          # Retryable error
          if attempt < max_retries - 1:
            backoff = 2**attempt
            if stop_event.wait(timeout=backoff):
              return entity, None
            continue
        raise
  except httpx.RequestError as e:
    print(f"Error fetching {url}: {e}")
    return entity, None
  finally:
    # Don't close the client; it's thread-local and reused for subsequent requests in this thread
    pass

  return entity, None


class WowheadFetcher:
  """Concurrent fetcher for Wowhead pages."""

  def __init__(
    self,
    db_path: str | Path = "wowhead.db",
    locale: Locale = Locale.enUS,
    max_workers: int = 128,
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

  def update_locale(self, new_locale: Locale) -> None:
    """Update the locale for the fetcher and its session."""
    self.locale = new_locale
    print(f"Locale updated to {new_locale.value}")

  # ? Control and Status functions

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

    # calculate estimated time remaining
    if stats["start_time"] and stats["successful"] > 0 and stats["total"] > 0:
      avg_time_per_entity = (time.time() - stats["start_time"]) / stats["successful"]
      remaining_entities = stats["total"] - stats["successful"]
      estimated_remaining = remaining_entities * avg_time_per_entity
      estimated_remaining_str = f"{estimated_remaining:.1f}s"
    else:
      estimated_remaining_str = "N/A"

    # calculate requests per second
    if stats["start_time"] and stats["successful"] > 0:
      elapsed_seconds = time.time() - stats["start_time"]
      requests_per_second = stats["successful"] / elapsed_seconds if elapsed_seconds > 0 else 0
      requests_per_second_str = f"{requests_per_second:.2f} req/s"
    else:
      requests_per_second_str = "N/A"

    info = f"""Current Operation: {self._current_operation}
Entity Type: {stats["entity_type"]}
Version: {stats["version"]}
Locale: {self.locale.value}
Progress: {stats["successful"]}/{stats["total"]} successful
Elapsed Time: {elapsed_str}
Estimated Time Remaining: {estimated_remaining_str}
Requests Per Second: {requests_per_second_str}
Status: {"Stopping..." if self.is_stopped() else "Running"}"""

    return info

  def _update_progress(self, **kwargs) -> None:
    """Update progress statistics thread-safely."""
    with self._stats_lock:
      self._progress_stats.update(kwargs)

  # ? #####################################################

  # ? Fetching functions

  def _create_session(self) -> httpx.Client:
    # This client is used for single-threaded sitemap fetching with HTTP/2
    client = httpx.Client(
      http2=True,
      timeout=10.0,
      limits=httpx.Limits(max_connections=1, max_keepalive_connections=1),
      headers={
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
        "Accept-Language": f"{self.locale.value[:2]}-{self.locale.value[2:]},{self.locale.value[:2]};q=0.9,en;q=0.5",
      },
    )
    return client

  def _seed_versions(self) -> None:
    """Seed the database with known expansion versions."""
    for version in VersionSlug:
      add_version(self.conn, version.value, version.order_index)

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
            print(f"This might take a minute or two, please wait not to corrupt the database...")
            # Cancel remaining futures
            for f in future_to_entity.keys():
              if not f.done():
                f.cancel()
            break

          entity, html_content = future.result()
          url = entity.generate_url() if entity.data_fetch_type == "full" else (f"{entity.generate_url()} (tooltip: {entity.generate_tooltip_url()})")
          if i % 100 == 0 or i == total_to_fetch:
            print(f"Progress: {i}/{total_to_fetch} - Received {url}")

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
              print(f"Database error storing {url}: {e}")
          else:
            print(f"Failed to fetch: {url}")

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

    self._current_operation = f"Fetching all {entity_type} entities for {self.locale.value} {version.value}"
    self._update_progress(entity_type=entity_type, version=version.value)

    print(f"Fetching all '{entity_type}' entities for '{self.locale.value} {version.value}'...")
    entities = get_entities(version, entity_type, self.sitemap_fetcher, self.locale)

    # Filter out unused entities
    print("Filtering out unused entities...")
    entities, skipped_entities = sitemap_filters.filter_unused_entities(entities)
    print(f"Skipped {len(skipped_entities)} unused entities")

    # For koKR, zhCN, zhTW and ruRU we can use their different character "scripts" to filter out incorrect entities
    if self.locale in [Locale.koKR, Locale.zhCN, Locale.zhTW, Locale.ruRU]:
      print("Filtering entities without scripts...")
      entities, skipped_entities = sitemap_filters.filter_entities_without_scripts(entities)
      print(f"Skipped {len(skipped_entities)} entities without scripts")

    # Filter out entities that already exist in the database
    print("Filtering out existing entities...")
    entities, removed_entities = sitemap_filters.filter_existing_entities(entities, lambda e: entity_exists(self.conn, e), force)
    print(f"Skipped {len(removed_entities)} entities that already exist in database")

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, len(removed_entities)

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

    self._current_operation = f"Fetching delta {entity_type} entities for {self.locale.value} {target_version.value}"
    self._update_progress(entity_type=entity_type, version=target_version.value)

    print(f"Fetching delta '{entity_type}' entities for '{self.locale.value} {target_version.value}'...")
    delta = calculate_version_delta(target_version, entity_type, self.sitemap_fetcher, self.locale)
    entities = delta.added_entities

    # Filter out unused entities
    print("Filtering out unused entities...")
    entities, skipped_entities = sitemap_filters.filter_unused_entities(entities)
    print(f"  Skipped {len(skipped_entities)} unused entities")

    # For koKR, zhCN, zhTW and ruRU we can use their different character "scripts" to filter out incorrect entities
    if self.locale in [Locale.koKR, Locale.zhCN, Locale.zhTW, Locale.ruRU]:
      print("Filtering entities without scripts...")
      entities, skipped_entities = sitemap_filters.filter_entities_without_scripts(entities)
      print(f"  Skipped {len(skipped_entities)} entities without scripts")

    # Filter out entities that already exist in the database
    print("Filtering out existing entities...")
    entities, removed_entities = sitemap_filters.filter_existing_entities(entities, lambda e: entity_exists(self.conn, e), force)
    print(f"  Skipped {len(removed_entities)} entities that already exist in database")

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, len(removed_entities)

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

    entities, removed_entities = sitemap_filters.filter_existing_entities(tuple(entities), lambda e: entity_exists(self.conn, e), force)

    if len(entities) == 0:
      print("No new entities to fetch - all already exist in database")
      return 0, len(removed_entities)

    return self._fetch_entities(entities, None)


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
