"""Single-threaded Wowhead page fetcher with database integration.

This module provides functionality to fetch Wowhead pages for specific versions
and content types, storing the raw HTML in the local database for later parsing.
"""

from __future__ import annotations

import time
from pathlib import Path
from typing import Optional, List
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

from wowhead_db import create_db, add_version, insert_translation_from_url
from sitemap import get_all_locs, get_version_delta


class WowheadFetcher:
  """Single-threaded fetcher for Wowhead pages."""

  def __init__(self, db_path: str | Path = "wowhead.sqlite", locale: str = "enUS"):
    """Initialize the fetcher with database connection and HTTP session.

    Args:
      db_path: Path to the SQLite database file
      locale: Locale for fetching pages (enUS, deDE, frFR, etc.)
    """
    self.db_path = Path(db_path)
    self.locale = locale
    self.conn = create_db(self.db_path)
    self.session = self._create_session()

    # Initialize versions in database
    self._seed_versions()

  def _create_session(self) -> requests.Session:
    """Create a configured requests session with retries and proper headers."""
    session = requests.Session()

    # Configure retry strategy
    retry_strategy = Retry(total=3, backoff_factor=1, status_forcelist=[429, 500, 502, 503, 504], allowed_methods=["HEAD", "GET", "OPTIONS"])

    adapter = HTTPAdapter(max_retries=retry_strategy)
    session.mount("http://", adapter)
    session.mount("https://", adapter)

    # Set proper headers to avoid being blocked
    session.headers.update(
      {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.5",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1",
      }
    )

    return session

  def _seed_versions(self) -> None:
    """Seed the database with known expansion versions."""
    versions = [
      ("unknown", 0, None),
      ("classic", 1, "2004-11-23"),
      ("tbc", 2, "2007-01-16"),
      ("wotlk", 3, "2008-11-13"),
      ("cata", 4, "2010-12-07"),
      ("mop-classic", 5, "2012-09-25"),
    ]

    for slug, order_idx, released_at in versions:
      add_version(self.conn, slug, order_idx, released_at)

  def fetch_url(self, url: str, delay: float = 1.0) -> Optional[str]:
    """Fetch a single URL with error handling and rate limiting.

    Args:
      url: The URL to fetch
      delay: Delay in seconds between requests

    Returns:
      Raw HTML content or None if fetch failed
    """
    try:
      print(f"Fetching: {url}")
      response = self.session.get(url, timeout=30)
      response.raise_for_status()

      # Add delay to be respectful to the server
      time.sleep(delay)

      return response.text

    except requests.exceptions.RequestException as request_error:
      print(f"Error fetching {url}: {request_error}")
      return None
    except Exception as general_error:
      print(f"Unexpected error fetching {url}: {general_error}")
      return None

  def fetch_and_store(self, url: str, delay: float = 1.0) -> bool:
    """Fetch a URL and store it in the database.

    Args:
      url: The URL to fetch and store
      delay: Delay in seconds between requests

    Returns:
      True if successful, False otherwise
    """
    html_content = self.fetch_url(url, delay)
    if html_content is None:
      return False

    try:
      insert_translation_from_url(self.conn, url, self.locale, html_content.encode("utf-8"))
      print(f"Stored: {url}")
      return True

    except Exception as db_error:
      print(f"Database error storing {url}: {db_error}")
      return False

  def fetch_version_content(self, version: str, content_type: str, limit: Optional[int] = None, delay: float = 1.0) -> tuple[int, int]:
    """Fetch all content of a specific type for a version.

    Args:
      version: The expansion version (classic, tbc, wotlk, etc.)
      content_type: The content type (quest, item, npc, etc.)
      limit: Maximum number of URLs to fetch (None for all)
      delay: Delay in seconds between requests

    Returns:
      Tuple of (successful_fetches, total_attempts)
    """
    print(f"Fetching {content_type} content for {version}...")

    try:
      urls = get_all_locs(version, content_type)

      if limit:
        urls = urls[:limit]

      print(f"Found {len(urls)} URLs to fetch")

      successful = 0
      total = len(urls)

      for index, url in enumerate(urls, 1):
        print(f"Progress: {index}/{total}")

        if self.fetch_and_store(url, delay):
          successful += 1
        else:
          print(f"Failed to fetch URL {index}/{total}: {url}")

      print(f"Completed: {successful}/{total} successful fetches")
      return successful, total

    except Exception as error:
      print(f"Error in fetch_version_content: {error}")
      return 0, 0

  def fetch_delta_content(self, target_version: str, content_type: str, limit: Optional[int] = None, delay: float = 1.0) -> tuple[int, int]:
    """Fetch only the delta content between versions.

    Args:
      target_version: The target expansion version
      content_type: The content type (quest, item, npc, etc.)
      delay: Delay in seconds between requests

    Returns:
      Tuple of (successful_fetches, total_attempts)
    """
    print(f"Fetching delta {content_type} content for {target_version}...")

    try:
      delta_result = get_version_delta(target_version, content_type)
      urls = delta_result.fixed  # Combined added and removed URLs

      if limit:
        urls = urls[:limit]

      print(f"Found {len(urls)} delta URLs to fetch")
      print(f"  Added: {len(delta_result.added)}")
      print(f"  Removed: {len(delta_result.removed)}")

      successful = 0
      total = len(urls)

      for index, url in enumerate(urls, 1):
        print(f"Progress: {index}/{total}")

        if self.fetch_and_store(url, delay):
          successful += 1
        else:
          print(f"Failed to fetch URL {index}/{total}: {url}")

      print(f"Completed: {successful}/{total} successful fetches")
      return successful, total

    except Exception as error:
      print(f"Error in fetch_delta_content: {error}")
      return 0, 0

  def fetch_specific_ids(self, version: str, content_type: str, id_list: List[int], delay: float = 1.0) -> tuple[int, int]:
    """Fetch specific content IDs for testing or targeted fetching.

    Args:
      version: The expansion version
      content_type: The content type (quest, item, npc, etc.)
      id_list: List of specific IDs to fetch
      delay: Delay in seconds between requests

    Returns:
      Tuple of (successful_fetches, total_attempts)
    """
    print(f"Fetching specific {content_type} IDs for {version}: {id_list}")

    successful = 0
    total = len(id_list)

    for index, content_id in enumerate(id_list, 1):
      # Construct URL based on version and content type
      if version == "unknown":
        url = f"https://www.wowhead.com/{content_type}={content_id}"
      else:
        url = f"https://www.wowhead.com/{version}/{content_type}={content_id}"

      print(f"Progress: {index}/{total}")

      if self.fetch_and_store(url, delay):
        successful += 1
      else:
        print(f"Failed to fetch ID {index}/{total}: {content_id}")

    print(f"Completed: {successful}/{total} successful fetches")
    return successful, total

  def close(self) -> None:
    """Close the database connection and HTTP session."""
    if hasattr(self, "conn"):
      self.conn.close()
    if hasattr(self, "session"):
      self.session.close()

  def __enter__(self):
    """Context manager entry."""
    return self

  def __exit__(self, exc_type, exc_val, exc_tb):
    """Context manager exit."""
    self.close()


def main() -> None:
  """Main function to fetch first 5 quests from classic iand TBC for comparison."""
  print("=== Wowhead Fetcher: First 5 Quests (Classic vs TBC) ===")

  with WowheadFetcher() as fetcher:
    print("\n--- Fetching first 5 Classic quests ---")
    classic_success, classic_total = fetcher.fetch_version_content("classic", "quest", limit=5, delay=1.0)

    print("\n--- Fetching first 5 TBC quests ---")
    tbc_success, tbc_total = fetcher.fetch_delta_content("tbc", "quest", limit=5, delay=1.0)

    print("\n=== Results ===")
    print(f"Classic: {classic_success}/{classic_total} successful")
    print(f"TBC: {tbc_success}/{tbc_total} successful")
    print(f"\nDatabase saved to: {fetcher.db_path}")
    print("You can now inspect the SQLite file to see the differences!")


if __name__ == "__main__":
  main()
