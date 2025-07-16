"""
Functional approach to Wowhead sitemap processing.

This module provides a clean, type-safe way to analyze differences between
WoW expansion versions by fetching and comparing sitemap data from Wowhead.
Modern Python patterns with protocols, immutable data, and strong typing.
"""

import os
import requests
from functools import cache
from xml.dom.minidom import parseString

from sitemap_types import VersionSlug, Locale, EntityType, CanonicalUrl, VersionSpecificUrl, EntityId, SitemapEntry, DeltaResult, SitemapFetcher

# All supported versions as a tuple for iteration
VERSIONS: tuple[VersionSlug, ...] = tuple(VersionSlug)


# === URL UTILITY FUNCTIONS ===


@cache
def canonicalize_url(url: str) -> CanonicalUrl:
  """Convert a version-specific Wowhead URL to its canonical form."""
  # Remove version segments from URL path to create canonical form
  # e.g., /classic/quest=1 -> /quest=1, /tbc/de/quest=1 -> /quest=1
  for version in VERSIONS:
    if version.value:  # Skip RETAIL (empty string)
      version_path = f"/{version.value}/"
      if version_path in url:
        return CanonicalUrl(url.replace(version_path, "/"))

  # Handle edge case where no version path is found (already canonical)
  return CanonicalUrl(url)


@cache
def add_version_to_url(canonical_url: CanonicalUrl, version: VersionSlug) -> VersionSpecificUrl:
  """Convert a canonical Wowhead URL to a version-specific URL."""
  if version not in VERSIONS:
    raise ValueError(f"Unknown version '{version}'. Supported versions: {VERSIONS}")

  return VersionSpecificUrl(canonical_url.replace("https://www.wowhead.com/", f"https://www.wowhead.com/{version.value}/"))


@cache
def extract_entity_id_from_url(url: str) -> int:
  """Extract the numeric entity ID from a Wowhead URL."""
  try:
    return int(url.split("=")[1].split("/")[0])
  except (IndexError, ValueError) as error:
    raise ValueError(f"Cannot extract entity ID from URL: {url}") from error


def validate_version(version: VersionSlug) -> None:
  """Validate that a version slug is supported."""
  if version not in VERSIONS:
    raise ValueError(f"Version '{version}' not found in supported versions: {VERSIONS}")


def get_previous_version(target_version: VersionSlug) -> VersionSlug:
  """Get the previous version in the chronological sequence."""
  validate_version(target_version)
  target_index = VERSIONS.index(target_version)

  if target_index == 0:
    raise ValueError(f"Cannot get previous version for first version '{target_version}'")

  return VERSIONS[target_index - 1]


# === CONCRETE IMPLEMENTATION ===


class RequestsSitemapFetcher:
  """HTTP requests-based implementation of the SitemapFetcher protocol."""

  def __init__(self, base_url: str = "https://www.wowhead.com", timeout: float = 30.0):
    self.base_url = base_url
    self.timeout = timeout
    # Create a session for connection pooling (small performance boost)
    self.session = requests.Session()

  def get_sitemap_index(self) -> list[str]:
    """Fetch the main sitemap index containing all sitemap URLs."""
    print(f"Fetching sitemap index from: {self.base_url}/sitemap")

    response = self.session.get(f"{self.base_url}/sitemap", timeout=self.timeout)
    response.raise_for_status()

    parsed_data = parseString(response.text)
    urls = []

    for sitemap in parsed_data.getElementsByTagName("sitemap"):
      loc_element = sitemap.getElementsByTagName("loc")[0]
      if loc_element.firstChild and loc_element.firstChild.nodeValue:
        urls.append(loc_element.firstChild.nodeValue)

    print(f"Found {len(urls)} sitemap URLs")
    return urls

  def get_sitemap_entries(self, url: str, locale: Locale = Locale.enUS) -> list[SitemapEntry]:
    """Fetch and parse individual sitemap entries."""
    # Add locale to URL if not English
    if locale not in [Locale.enUS]:
      url = url.replace("sitemap", f"{locale.value}/sitemap")

    print(f"  → Fetching entries from: {url}")

    response = self.session.get(url, timeout=self.timeout)
    response.raise_for_status()

    parsed_data = parseString(response.text)
    entries = []

    for url_node in parsed_data.getElementsByTagName("url"):
      loc_element = url_node.getElementsByTagName("loc")[0]
      priority_element = url_node.getElementsByTagName("priority")[0]
      lastmod_element = url_node.getElementsByTagName("lastmod")[0]

      # Ensure nodeValue is not None before passing to SitemapEntry
      loc_value = loc_element.firstChild.nodeValue if loc_element.firstChild and loc_element.firstChild.nodeValue is not None else None
      priority_value = priority_element.firstChild.nodeValue if priority_element.firstChild and priority_element.firstChild.nodeValue is not None else None
      lastmod_value = lastmod_element.firstChild.nodeValue if lastmod_element.firstChild and lastmod_element.firstChild.nodeValue is not None else None

      if loc_value is not None and priority_value is not None and lastmod_value is not None:
        try:
          entry = SitemapEntry(
            loc=loc_value,
            priority=float(priority_value),
            lastmod=lastmod_value,
            entity_id=EntityId(0),  # Will be set by __post_init__
          )
          entries.append(entry)
        except (ValueError, TypeError) as error:
          print(f"Warning: Skipping invalid sitemap entry: {error}")
          print(f"  Entry values: loc={loc_value}, priority={priority_value}, lastmod={lastmod_value}")
          continue
      else:
        print(f"Warning: Skipping sitemap entry with None values: loc={loc_value}, priority={priority_value}, lastmod={lastmod_value}")
        continue

    print(f"    Found {len(entries)} entries")
    return entries

  def __del__(self):
    """Clean up session when fetcher is destroyed."""
    if hasattr(self, "session"):
      self.session.close()


# === CORE BUSINESS LOGIC ===


def get_version_sitemap_urls(version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher = RequestsSitemapFetcher()) -> list[str]:
  """Get all sitemap URLs for a specific version and entity type."""
  validate_version(version)
  all_urls = fetcher.get_sitemap_index()

  # Filter URLs based on version and entity type
  filtered_urls = [url for url in all_urls if f"/{version.value}/" in url and f"/{entity_type}?" in url]

  return filtered_urls


def get_canonical_locations(version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher = RequestsSitemapFetcher(), locale: Locale = Locale.enUS) -> frozenset[CanonicalUrl]:
  """Get all canonical URLs for a given version and entity type."""
  sitemap_urls = get_version_sitemap_urls(version, entity_type, fetcher)

  # Fetch all sitemap entries (sequential for simplicity)
  all_entries: list[SitemapEntry] = []
  for url in sitemap_urls:
    print(f"Fetching sitemap: {url}")
    entries = fetcher.get_sitemap_entries(url, locale)
    all_entries.extend(entries)

  # Convert to canonical URLs and return as frozen set
  canonical_urls = {canonicalize_url(entry.loc) for entry in all_entries}
  return frozenset(canonical_urls)


def calculate_version_delta(target_version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher = RequestsSitemapFetcher(), locale: Locale = Locale.enUS) -> DeltaResult:
  """Calculate the delta between target_version and the previous version."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Calculating delta from '{previous_version}' to '{target_version}' for type '{entity_type}'")

  # Get canonical URLs for both versions (sequential)
  print(f"Fetching {previous_version} sitemap entries...")
  previous_canonical = get_canonical_locations(previous_version, entity_type, fetcher, locale)

  print(f"Fetching {target_version} sitemap entries...")
  target_canonical = get_canonical_locations(target_version, entity_type, fetcher, locale)

  # Calculate deltas using canonical URLs
  added_canonical = target_canonical - previous_canonical
  removed_canonical = previous_canonical - target_canonical

  # Convert canonical URLs back to version-specific URLs
  added_versioned = tuple(add_version_to_url(url, target_version) for url in added_canonical)
  removed_versioned = tuple(add_version_to_url(url, previous_version) for url in removed_canonical)

  # Sort by entity ID for consistent output
  added_sorted = tuple(sorted(added_versioned, key=extract_entity_id_from_url))
  removed_sorted = tuple(sorted(removed_versioned, key=extract_entity_id_from_url))
  fixed_sorted = tuple(sorted((*added_versioned, *removed_versioned), key=extract_entity_id_from_url))

  print(f"Found {len(added_sorted)} added IDs, {len(removed_sorted)} removed IDs")

  return DeltaResult(target_version=target_version, previous_version=previous_version, entity_type=entity_type, all_urls=fixed_sorted, added_urls=added_sorted, removed_urls=removed_sorted)


# ! #####################################################
# ! #####################################################
# ! Below is test code rather than actual implementation.
# ! #####################################################
# ! #####################################################

# === FILE EXPORT UTILITIES ===


def export_version_comparison(
  target_version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher = RequestsSitemapFetcher(), output_dir: str = ".", locale: Locale = Locale.enUS
) -> tuple[str, str]:
  """Export version comparison to separate files for manual inspection."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Exporting comparison files for '{previous_version}' vs '{target_version}' ({entity_type})")

  # Get canonical URLs for both versions
  previous_canonical = get_canonical_locations(previous_version, entity_type, fetcher, locale)
  target_canonical = get_canonical_locations(target_version, entity_type, fetcher, locale)

  # Convert to sorted lists
  previous_ids = sorted(previous_canonical, key=extract_entity_id_from_url)
  target_ids = sorted(target_canonical, key=extract_entity_id_from_url)

  # Create file names
  previous_file = f"{output_dir}/_{previous_version.value}_{entity_type}_ids.txt"
  target_file = f"{output_dir}/_{target_version.value}_{entity_type}_ids.txt"

  # Export previous version IDs
  with open(previous_file, "w", encoding="utf-8") as file:
    file.write(f"# {previous_version.value.upper()} {entity_type.upper()} IDs ({len(previous_ids)} total)\n")
    file.write(f"# Generated with functional approach using requests\n")
    file.write(f"# Locale: {locale.value}\n\n")
    for url in previous_ids:
      file.write(f"{url}\n")

  # Export target version IDs
  with open(target_file, "w", encoding="utf-8") as file:
    file.write(f"# {target_version.value.upper()} {entity_type.upper()} IDs ({len(target_ids)} total)\n")
    file.write(f"# Generated with functional approach using requests\n")
    file.write(f"# Locale: {locale.value}\n\n")
    for url in target_ids:
      file.write(f"{url}\n")

  print(f"Files created:")
  print(f"  Previous ({previous_version}): {previous_file} ({len(previous_ids)} IDs)")
  print(f"  Target ({target_version}): {target_file} ({len(target_ids)} IDs)")
  print(f"\nCompare in VS Code using:")
  print(f'  code --diff "{previous_file}" "{target_file}"')

  return previous_file, target_file


# === MAIN ENTRY POINT ===

if __name__ == "__main__":
  """Main function demonstrating the functional approach."""
  fetcher = None
  try:
    # Get script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_dir = os.path.join(script_dir, "debug-output")

    print("=== Functional Sitemap Processing Demo ===")

    # Create fetcher with dependency injection
    fetcher = RequestsSitemapFetcher()

    os.makedirs(output_dir, exist_ok=True)

    # Example: Calculate delta between classic and tbc for quests
    print("\n--- Calculating Delta (Classic -> TBC, Quest) ---")
    delta_result = calculate_version_delta(VersionSlug.TBC, "quest", fetcher)

    print(f"\nDelta Results:")
    print(f"  Target Version: {delta_result.target_version.value}")
    print(f"  Previous Version: {delta_result.previous_version.value}")
    print(f"  Entity Type: {delta_result.entity_type}")
    print(f"  Total changes: {delta_result.change_count}")
    print(f"  Added: {len(delta_result.added_urls)}")
    print(f"  Removed: {len(delta_result.removed_urls)}")

    # Show first few IDs as examples
    if delta_result.added_urls:
      print(f"\nFirst 5 added quest URLs:")
      for url in delta_result.added_urls[:5]:
        print(f"  {url}")

    if delta_result.removed_urls:
      print(f"\nFirst 5 removed quest URLs:")
      for url in delta_result.removed_urls[:5]:
        print(f"  {url}")

    # Example 2: Export comparison files
    print(f"\n--- Exporting Comparison Files ---")
    export_version_comparison(VersionSlug.TBC, "quest", fetcher, output_dir=output_dir)
    export_version_comparison(VersionSlug.WOTLK, "quest", fetcher, output_dir=output_dir)
    export_version_comparison(VersionSlug.CATA, "quest", fetcher, output_dir=output_dir)
    export_version_comparison(VersionSlug.MOP_CLASSIC, "quest", fetcher, output_dir=output_dir)

    # Example 3: Export tooltip URLs
    print(f"\n--- Exporting Tooltip URLs ---")
    # export_tooltip_urls_from_delta(delta_result)

  except Exception as error:
    print(f"Error during demo: {error}")
    raise
  finally:
    # Clean up session
    if fetcher is not None:
      del fetcher
