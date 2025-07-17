import os
import requests
from xml.dom.minidom import parseString

from sitemap_types import (
  VersionSlug,
  Locale,
  EntityType,
  SitemapEntry,
  DeltaResult,
  SitemapFetcher,
  WowheadEntity,
  EntityId,
)
from wowhead_mappings import parse_url

# All supported versions as a tuple for iteration
VERSIONS: tuple[VersionSlug, ...] = tuple(VersionSlug)


# === UTILITY FUNCTIONS ===


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
    self.session = requests.Session()

  def get_sitemap_index(self) -> list[str]:
    """Fetch the main sitemap index containing all sitemap URLs."""
    print(f"Fetching sitemap index from: {self.base_url}/sitemap")
    response = self.session.get(f"{self.base_url}/sitemap", timeout=self.timeout)
    response.raise_for_status()
    parsed_data = parseString(response.text)
    urls = [loc.firstChild.nodeValue for sitemap in parsed_data.getElementsByTagName("sitemap") if (loc := sitemap.getElementsByTagName("loc")[0]) and loc.firstChild and loc.firstChild.nodeValue]
    print(f"Found {len(urls)} sitemap URLs")
    return urls

  def get_sitemap_entries(self, url: str, locale: Locale = Locale.enUS) -> list[SitemapEntry]:
    """Fetch and parse individual sitemap entries."""
    if locale != Locale.enUS:
      url = url.replace("sitemap", f"{locale.value}/sitemap")

    print(f"  → Fetching entries from: {url}")
    response = self.session.get(url, timeout=self.timeout)
    response.raise_for_status()
    parsed_data = parseString(response.text)
    entries = []
    for url_node in parsed_data.getElementsByTagName("url"):
      try:
        loc_element = url_node.getElementsByTagName("loc")[0]
        priority_element = url_node.getElementsByTagName("priority")[0]
        lastmod_element = url_node.getElementsByTagName("lastmod")[0]

        loc_value = loc_element.firstChild.nodeValue if loc_element.firstChild and loc_element.firstChild.nodeValue is not None else None
        priority_value = priority_element.firstChild.nodeValue if priority_element.firstChild and priority_element.firstChild.nodeValue is not None else None
        lastmod_value = lastmod_element.firstChild.nodeValue if lastmod_element.firstChild and lastmod_element.firstChild.nodeValue is not None else None

        if loc_value and priority_value and lastmod_value:
          entries.append(
            SitemapEntry(
              loc=loc_value,
              priority=float(priority_value),
              lastmod=lastmod_value,
              entity_id=EntityId(0),  # Placeholder, replaced by __post_init__
            )
          )
      except (ValueError, TypeError, IndexError) as e:
        print(f"Warning: Skipping invalid sitemap entry: {e}")
    print(f"    Found {len(entries)} entries")
    return entries

  def __del__(self):
    if hasattr(self, "session"):
      self.session.close()


# === CORE BUSINESS LOGIC ===


def get_version_sitemap_urls(version: VersionSlug, entity_type: EntityType, fetcher: SitemapFetcher) -> list[str]:
  """Get all sitemap URLs for a specific version and entity type."""
  validate_version(version)
  all_urls = fetcher.get_sitemap_index()
  return [url for url in all_urls if f"/{version.value}/" in url and f"/{entity_type}?" in url]


def get_entities(
  version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  locale: Locale = Locale.enUS,
) -> tuple[WowheadEntity, ...]:
  """Get all WowheadEntitys for a given version and entity type."""
  sitemap_urls = get_version_sitemap_urls(version, entity_type, fetcher)
  all_entries: list[SitemapEntry] = []
  for url in sitemap_urls:
    entries = fetcher.get_sitemap_entries(url, locale)
    all_entries.extend(entries)

  # Parse all URLs into structured entities
  entities = [parse_url(entry.loc) for entry in all_entries]

  # Sort by entity_id for consistent ordering
  return tuple(sorted(entities, key=lambda e: e.entity_id))


def calculate_version_delta(
  target_version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  locale: Locale = Locale.enUS,
) -> DeltaResult:
  """Calculate the delta between target_version and the previous version."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Calculating delta from '{previous_version}' to '{target_version}' for type '{entity_type}'")

  print(f"Fetching {previous_version} sitemap entries...")
  previous_entities = get_entities(previous_version, entity_type, fetcher, locale)

  print(f"Fetching {target_version} sitemap entries...")
  target_entities = get_entities(target_version, entity_type, fetcher, locale)

  # Use sets of a composite key (ID, name) for efficient and accurate comparison
  previous_keys = {(entity.entity_id, entity.name_slug) for entity in previous_entities}
  target_keys = {(entity.entity_id, entity.name_slug) for entity in target_entities}

  added_keys = target_keys - previous_keys
  removed_keys = previous_keys - target_keys

  # Filter the full entity objects based on the delta keys
  # Sort by entity_id for consistent ordering
  added_entities = tuple(sorted([entity for entity in target_entities if (entity.entity_id, entity.name_slug) in added_keys], key=lambda e: e.entity_id))
  removed_entities = tuple(sorted([entity for entity in previous_entities if (entity.entity_id, entity.name_slug) in removed_keys], key=lambda e: e.entity_id))
  all_entities = tuple(sorted(added_entities + removed_entities, key=lambda e: e.entity_id))

  print(f"Found {len(added_entities)} added, {len(removed_entities)} removed")

  return DeltaResult(
    target_version=target_version,
    previous_version=previous_version,
    entity_type=entity_type,
    all_entities=all_entities,
    added_entities=added_entities,
    removed_entities=removed_entities,
  )


# === FILE EXPORT UTILITIES (FOR DEBUGGING) ===


def export_version_comparison(
  target_version: VersionSlug,
  entity_type: EntityType,
  fetcher: SitemapFetcher,
  output_dir: str = ".",
  locale: Locale = Locale.enUS,
) -> tuple[str, str]:
  """Export version comparison to separate files for manual inspection."""
  validate_version(target_version)
  previous_version = get_previous_version(target_version)

  print(f"Exporting comparison files for '{previous_version}' vs '{target_version}' ({entity_type})")

  previous_entities = get_entities(previous_version, entity_type, fetcher, locale)
  target_entities = get_entities(target_version, entity_type, fetcher, locale)

  previous_file = f"{output_dir}/_{previous_version.value}_{entity_type}_ids"
  target_file = f"{output_dir}/_{target_version.value}_{entity_type}_ids"

  with open(previous_file + "_fullurl.txt", "w", encoding="utf-8") as f:
    f.write(f"# {previous_version.value.upper()} {entity_type.upper()} IDs ({len(previous_entities)} total)\n")
    for entity in previous_entities:
      f.write(f"{entity.generate_url()}\n")

  with open(target_file + "_fullurl.txt", "w", encoding="utf-8") as f:
    f.write(f"# {target_version.value.upper()} {entity_type.upper()} IDs ({len(target_entities)} total)\n")
    for entity in target_entities:
      f.write(f"{entity.generate_url()}\n")

  with open(previous_file + "_tooltip.txt", "w", encoding="utf-8") as f:
    f.write(f"# {previous_version.value.upper()} {entity_type.upper()} IDs ({len(previous_entities)} total)\n")
    for entity in previous_entities:
      f.write(f"{entity.generate_tooltip_url()}\n")

  with open(target_file + "_tooltip.txt", "w", encoding="utf-8") as f:
    f.write(f"# {target_version.value.upper()} {entity_type.upper()} IDs ({len(target_entities)} total)\n")
    for entity in target_entities:
      f.write(f"{entity.generate_tooltip_url()}\n")

  print(f"Files created:")
  print(f"  Previous ({previous_version.value}): {previous_file}")
  print(f"  Target ({target_version.value}): {target_file}")

  return previous_file, target_file


# === MAIN ENTRY POINT ===

if __name__ == "__main__":
  fetcher = None
  try:
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_dir = os.path.join(script_dir, "debug-output")
    os.makedirs(output_dir, exist_ok=True)

    print("=== Functional Sitemap Processing Demo ===")
    fetcher = RequestsSitemapFetcher()

    print("\n--- Calculating Delta (Classic -> TBC, Quest) ---")
    delta_result = calculate_version_delta(VersionSlug.TBC, "quest", fetcher)

    print(f"\nDelta Results:")
    print(f"  Target Version: {delta_result.target_version.value}")
    print(f"  Previous Version: {delta_result.previous_version.value}")
    print(f"  Entity Type: {delta_result.entity_type}")
    print(f"  Total changes: {delta_result.change_count}")
    print(f"  Added: {len(delta_result.added_entities)}")
    print(f"  Removed: {len(delta_result.removed_entities)}")

    # Check if id 1 exists in both added and removed
    if any(entity.entity_id == EntityId(1) for entity in delta_result.added_entities):
      print("Quest ID 1 was added in TBC!")

    if any(entity.entity_id == EntityId(1) for entity in delta_result.removed_entities):
      print("Quest ID 1 was removed in TBC!")

    if delta_result.added_entities:
      print("\nFirst 5 added quest URLs:")
      for entity in delta_result.added_entities[:5]:
        print(f"  {entity.generate_url()}")

    if delta_result.removed_entities:
      print("\nFirst 5 removed quest URLs:")
      for entity in delta_result.removed_entities[:5]:
        print(f"  {entity.generate_url()}")

    print("\n--- Exporting Comparison Files ---")
    export_version_comparison(VersionSlug.TBC, "quest", fetcher, output_dir=output_dir)

  except Exception as error:
    print(f"Error during demo: {error}")
    raise
  finally:
    if fetcher is not None:
      del fetcher
